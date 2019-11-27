package pro.taskana.adapter.camunda.outbox.rest.service;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.ibatis.datasource.pooled.PooledDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import pro.taskana.adapter.camunda.outbox.rest.controller.CamundaTaskEventsController;
import pro.taskana.adapter.camunda.outbox.rest.resource.CamundaTaskEventResource;
import spinjar.com.fasterxml.jackson.databind.JsonNode;
import spinjar.com.fasterxml.jackson.databind.ObjectMapper;

public class CamundaTaskEventsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CamundaTaskEventsService.class);

    private static final String SQL_GET_CREATE_EVENTS = "SELECT * FROM taskana_tables.event_store WHERE type = ?";
    private static final String SQL_GET_COMPLETE_AND_DELETE_EVENTS = "SELECT * FROM taskana_tables.event_store WHERE type = ? OR type = ?";
    private static final String SQL_WITHOUT_PLACEHOLDERS_DELETE_EVENTS = "DELETE FROM taskana_tables.event_store WHERE id in (%s)";

    private DataSource dataSource = null;

    public List<CamundaTaskEventResource> getEvents(List<String> requestedEventTypes) {

        List<CamundaTaskEventResource> camundaTaskEventResources = new ArrayList<>();

        if (requestedEventTypes.contains("create")) {

            camundaTaskEventResources = getCreateEvents();

        } else if (requestedEventTypes.contains("delete") && requestedEventTypes.contains("complete")) {

            camundaTaskEventResources = getCompleteAndDeleteEvents();
        }

        return camundaTaskEventResources;

    }

    public void deleteEvents(String idsAsJsonArray) {

        List<Integer> idsAsIntegers = getIdsAsIntegers(idsAsJsonArray);

        String DeleteEventsSqlWithPlaceholders = String.format(SQL_WITHOUT_PLACEHOLDERS_DELETE_EVENTS,
            preparePlaceHolders(idsAsIntegers.size()));

        try (Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DeleteEventsSqlWithPlaceholders)) {

            setPreparedStatementValues(preparedStatement, idsAsIntegers);
            preparedStatement.execute();

        } catch (Exception e) {
            LOGGER.warn("Caught {} while trying to delete events from the outbox table", e);
        }

    }

    private List<CamundaTaskEventResource> getCreateEvents() {

        List<CamundaTaskEventResource> camundaTaskEventResources = new ArrayList<>();

        try (
            Connection connection = getConnection();
            PreparedStatement preparedStatement = getPreparedCreateEventsStatement(connection);) {

            ResultSet camundaTaskEventResultSet = preparedStatement.executeQuery();
            camundaTaskEventResources = getCamundaTaskEventResources(camundaTaskEventResultSet);

        } catch (SQLException | NullPointerException e) {
            LOGGER.warn("Caught {} while trying to retrieve create events from the outbox", e);
        }
        return camundaTaskEventResources;
    }

    private String preparePlaceHolders(int length) {
        return String.join(",", Collections.nCopies(length, "?"));

    }

    private void setPreparedStatementValues(PreparedStatement preparedStatement, List<Integer> ids)
        throws SQLException {
        for (int i = 0; i < ids.size(); i++) {
            preparedStatement.setObject(i + 1, ids.get(i));
        }
    }

    private List<CamundaTaskEventResource> getCamundaTaskEventResources(ResultSet createEventsResultSet)
        throws SQLException {

        List<CamundaTaskEventResource> camundaTaskEventResources = new ArrayList<>();

        while (createEventsResultSet.next()) {

            CamundaTaskEventResource camundaTaskEventResource = new CamundaTaskEventResource();

            camundaTaskEventResource.setId(createEventsResultSet.getInt(1));
            camundaTaskEventResource.setType(createEventsResultSet.getString(2));
            camundaTaskEventResource.setCreated(formatDate(createEventsResultSet.getTimestamp(3)));
            camundaTaskEventResource.setPayload(createEventsResultSet.getString(4));

            camundaTaskEventResources.add(camundaTaskEventResource);

        }

        return camundaTaskEventResources;

    }

    private List<Integer> getIdsAsIntegers(String idsAsJsonArray) {

        ObjectMapper objectMapper = new ObjectMapper();
        List<Integer> idsAsIntegers = new ArrayList<>();

        try {
            JsonNode idsAsJsonArrayNode = objectMapper.readTree(idsAsJsonArray).get("taskCreationIds");

            if (idsAsJsonArrayNode != null) {
                idsAsJsonArrayNode.forEach(id -> idsAsIntegers.add(id.asInt()));
            }

        } catch (IOException e) {
            LOGGER.warn(
                "Caught {} while trying to read the passed JSON-Object in the POST-Request to delete events from the outbox table",
                e);
        }
        return idsAsIntegers;
    }

    private PreparedStatement getPreparedCreateEventsStatement(Connection connection) throws SQLException {

        PreparedStatement preparedStatement = connection.prepareStatement(SQL_GET_CREATE_EVENTS);
        preparedStatement.setString(1, "create");

        return preparedStatement;
    }

    private List<CamundaTaskEventResource> getCompleteAndDeleteEvents() {

        List<CamundaTaskEventResource> camundaTaskEventResources = new ArrayList<>();

        try (
            Connection connection = getConnection();
            PreparedStatement preparedStatement = getPreparedCompleteAndDeleteEventsStatement(connection);) {

            ResultSet completeAndDeleteEventsResultSet = preparedStatement.executeQuery();
            camundaTaskEventResources = getCamundaTaskEventResources(completeAndDeleteEventsResultSet);

        } catch (SQLException | NullPointerException e) {
            LOGGER.warn("Caught {} while trying to retrieve complete/delete events from the outbox", e);
        }

        return camundaTaskEventResources;
    }

    private PreparedStatement getPreparedCompleteAndDeleteEventsStatement(Connection connection) throws SQLException {

        PreparedStatement preparedStatement = connection.prepareStatement(SQL_GET_COMPLETE_AND_DELETE_EVENTS);
        preparedStatement.setString(1, "complete");
        preparedStatement.setString(2, "delete");

        return preparedStatement;
    }

    private Connection getConnection() {

        Connection connection = null;
        try {
            connection = getDataSourceFromPropertiesFile().getConnection();
        } catch (SQLException | NullPointerException e) {
            LOGGER.warn("Caught {} while trying to retrieve a connection from the provided datasource", e);
        }

        return connection;
    }

    private DataSource getDataSourceFromPropertiesFile() {

        synchronized (CamundaTaskEventsService.class) {
            if (dataSource == null) {

                InputStream config = CamundaTaskEventsController.class.getClassLoader()
                    .getResourceAsStream("datasource.properties");

                Properties properties = new Properties();

                try {

                    properties.load(config);
                    String jndiUrl = properties.getProperty("taskana.adapter.outbox.rest.datasource.jndi");

                    if (jndiUrl != null) {
                        dataSource = (DataSource) new InitialContext().lookup(jndiUrl);

                    } else {

                        dataSource = createDatasource(
                            properties.getProperty("taskana.adapter.outbox.rest.datasource.driver"),
                            properties.getProperty("taskana.adapter.outbox.rest.datasource.url"),
                            properties.getProperty("taskana.adapter.outbox.rest.datasource.username"),
                            properties.getProperty("taskana.adapter.outbox.rest.datasource.password"));
                    }

                } catch (IOException | NamingException | NullPointerException e) {
                    LOGGER.warn("Caught {} while trying to retrieve the datasource from the provided properties file",
                        e);
                }
            }
        }
        return dataSource;
    }

    public static DataSource createDatasource(String driver, String jdbcUrl, String username, String password) {
        return new PooledDataSource(driver, jdbcUrl, username, password);
    }

    private String formatDate(Date date) {
        if (date == null) {
            return null;
        } else {
            return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
                .withZone(ZoneId.systemDefault())
                .format(date.toInstant());

        }
    }

}
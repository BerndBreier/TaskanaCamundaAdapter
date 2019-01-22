-- KSC authorizations                             (ID                                        , WB_ID                                     ,    ACCESS_ID,    ACCESS_NAME   , READ, OPEN, APPEND, TRANSFER, DISTRIBUTE, C1, .., C12)
-- PPKs
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000001', 'WBI:100000000000000000000000000000000004', 'teamlead_1', 'Meyer, Dominik'    , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000002', 'WBI:100000000000000000000000000000000005', 'teamlead_2', 'Hagen, Holger'     , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000003', 'WBI:100000000000000000000000000000000006',   'user_1_1', 'Rojas, Miguel'     , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000004', 'WBI:100000000000000000000000000000000007',   'user_1_2', 'Lengl, Marcel'     , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000005', 'WBI:100000000000000000000000000000000008',   'user_2_1', 'Zorgati, Mustapha' , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000006', 'WBI:100000000000000000000000000000000009',   'user_2_2', 'Breier, Bernd'     , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
-- group internal access
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000007', 'WBI:100000000000000000000000000000000004',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000008', 'WBI:100000000000000000000000000000000005',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000009', 'WBI:100000000000000000000000000000000006',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000010', 'WBI:100000000000000000000000000000000007',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000011', 'WBI:100000000000000000000000000000000008',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000012', 'WBI:100000000000000000000000000000000009',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
-- teamlead substitution
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000013', 'WBI:100000000000000000000000000000000004', 'teamlead_2', 'Hagen, Holger'     , true, true, true,   true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000014', 'WBI:100000000000000000000000000000000005', 'teamlead_1', 'Meyer, Dominik'    , true, true, true,   false,    false,      false, false, false, false, false, false, false, false, false, false, false, false);
-- cross team tranfers
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000015', 'WBI:100000000000000000000000000000000006',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, false, true,  false,    false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000016', 'WBI:100000000000000000000000000000000007',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, false, true,  false,    false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000017', 'WBI:100000000000000000000000000000000008',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, false, false, false,    false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000018', 'WBI:100000000000000000000000000000000009',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, false, true,  false,    false,      false, false, false, false, false, false, false, false, false, false, false, false);
-- Team GPK access
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000019', 'WBI:100000000000000000000000000000000002',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000020', 'WBI:100000000000000000000000000000000003',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
-- Cross team GPK access
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000021', 'WBI:100000000000000000000000000000000001', 'teamlead_1', 'Meyer, Dominik'    , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000022', 'WBI:100000000000000000000000000000000001', 'teamlead_2', 'Hagen, Holger'     , true, true, true,   true,     true,       true, true, true, true, true, true, true, true, true, true, true, true);
-- TPK access
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000123', 'WBI:100000000000000000000000000000000010', 'teamlead_1', 'Meyer, Dominik'    , true, false, false,   false,     false,      false, false, false, false, false, false, false, false, false, false, false, false);

-- Access to other domains
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000023', 'WBI:100000000000000000000000000000000012',    'cn=developersgroup,ou=groups,o=taskanatest', 'DevelopersGroup'   , true, false, true,  true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000024', 'WBI:100000000000000000000000000000000013',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, false, true,  true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000025', 'WBI:100000000000000000000000000000000014',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,  true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('WAI:100000000000000000000000000000000026', 'WBI:100000000000000000000000000000000015',    'cn=usersgroup,ou=groups,o=taskanatest', 'UsersGroup'        , true, true, true,  true,     false,      false, false, false, false, false, false, false, false, false, false, false, false);

-- Access to workbaskets for sorting test
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000900', '0000000000000000000000000000000000000900', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000901', '0000000000000000000000000000000000000901', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000902', '0000000000000000000000000000000000000902', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000903', '0000000000000000000000000000000000000903', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000904', '0000000000000000000000000000000000000904', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000905', '0000000000000000000000000000000000000905', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000906', '0000000000000000000000000000000000000906', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000907', '0000000000000000000000000000000000000907', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000908', '0000000000000000000000000000000000000908', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
INSERT INTO WORKBASKET_ACCESS_LIST VALUES ('0000000000000000000000000000000000000909', '0000000000000000000000000000000000000909', 'max', 'Behrendt, Maximilian', true, true, true, true, true, true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true,  true);
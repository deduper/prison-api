INSERT INTO OMS_ROLES (ROLE_ID, ROLE_NAME, ROLE_SEQ, ROLE_CODE, PARENT_ROLE_CODE) VALUES ( -1, 'System User', 1, 'SYSTEM_USER', null);
INSERT INTO OMS_ROLES (ROLE_ID, ROLE_NAME, ROLE_SEQ, ROLE_CODE, PARENT_ROLE_CODE) VALUES ( -2, 'Wing Officer', 1, 'WING_OFF', null);

INSERT INTO STAFF_MEMBERS (STAFF_ID, ASSIGNED_CASELOAD_ID, WORKING_CASELOAD_ID, USER_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, PERSONNEL_TYPE)
VALUES (-1, 'LEI', 'LEI', 'ELITE2_API_USER', 'User', 'Elite2', 'API', 'STAFF');
INSERT INTO STAFF_MEMBERS (STAFF_ID, ASSIGNED_CASELOAD_ID, WORKING_CASELOAD_ID, USER_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, PERSONNEL_TYPE)
VALUES (-2, 'LEI', 'LEI', 'ITAG_USER', 'User', 'API', 'ITAG', 'STAFF');
INSERT INTO STAFF_MEMBERS (STAFF_ID, ASSIGNED_CASELOAD_ID, WORKING_CASELOAD_ID, USER_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, PERSONNEL_TYPE)
VALUES (-3, 'LEI', 'LEI', 'HPA_USER', 'User', 'HPA', null, 'STAFF');
INSERT INTO STAFF_MEMBERS (STAFF_ID, ASSIGNED_CASELOAD_ID, WORKING_CASELOAD_ID, USER_ID, LAST_NAME, FIRST_NAME, MIDDLE_NAME, PERSONNEL_TYPE)
VALUES (-4, 'MUL', 'MUL', 'API_TEST_USER', 'User', 'Test', null, 'STAFF');

INSERT INTO STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID, ROLE_CODE) VALUES (-1, -1, 'SYSTEM_USER');
INSERT INTO STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID, ROLE_CODE) VALUES (-2, -2, 'WING_OFF');
INSERT INTO STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID, ROLE_CODE) VALUES (-2, -3, 'WING_OFF');
INSERT INTO STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID, ROLE_CODE) VALUES (-1, -3, 'SYSTEM_USER');
INSERT INTO STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID, ROLE_CODE) VALUES (-2, -4, 'WING_OFF');

INSERT INTO INTERNET_ADDRESSES (INTERNET_ADDRESS_ID, OWNER_ID, OWNER_CLASS, INTERNET_ADDRESS_CLASS, INTERNET_ADDRESS)
VALUES (-1, -1, 'STF', 'EMAIL', 'elite2-api-user@syscon.net');
INSERT INTO INTERNET_ADDRESSES (INTERNET_ADDRESS_ID, OWNER_ID, OWNER_CLASS, INTERNET_ADDRESS_CLASS, INTERNET_ADDRESS)
VALUES (-2, -2, 'STF', 'EMAIL', 'itaguser@syscon.net');

INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('LEI', -1);
INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('LEI', -2);
INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('WAI', -2);
INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('BXI', -2);
INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('LEI', -3);
INSERT INTO STAFF_ACCESSIBLE_CASELOADS (CASELOAD_ID, STAFF_ID) VALUES ('MUL', -4);

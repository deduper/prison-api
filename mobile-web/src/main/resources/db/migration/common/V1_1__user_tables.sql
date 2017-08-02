CREATE SEQUENCE STAFF_ID START WITH 1;
CREATE SEQUENCE INTERNET_ADDRESS_ID START WITH 1;
CREATE SEQUENCE ROLE_ID START WITH 1;

CREATE TABLE STAFF_MEMBERS
(
  STAFF_ID                      DECIMAL(10, 0) PRIMARY KEY,
  ASSIGNED_CASELOAD_ID          VARCHAR(6),
  WORKING_STOCK_LOC_ID          VARCHAR(6),
  WORKING_CASELOAD_ID           VARCHAR(6),
  USER_ID                       VARCHAR(32),
  BADGE_ID                      VARCHAR(20),
  LAST_NAME                     VARCHAR(35),
  FIRST_NAME                    VARCHAR(35),
  MIDDLE_NAME                   VARCHAR(35),
  ABBREVIATION                  VARCHAR(15),
  POSITION                      VARCHAR(25),
  BIRTHDATE                     DATE,
  TERMINATION_DATE              DATE,
  UPDATE_ALLOWED_FLAG           VARCHAR(1)  DEFAULT 'Y',
  DEFAULT_PRINTER_ID            DECIMAL(10, 0),
  SUSPENDED_FLAG                VARCHAR(1)  DEFAULT 'N',
  SUPERVISOR_STAFF_ID           DECIMAL(10, 0),
  COMM_RECEIPT_PRINTER_ID       VARCHAR(12),
  PERSONNEL_TYPE                VARCHAR(12),
  AS_OF_DATE                    DATE,
  EMERGENCY_CONTACT             VARCHAR(20),
  ROLE                          VARCHAR(12),
  SEX_CODE                      VARCHAR(12),
  STATUS                        VARCHAR(12),
  SUSPENSION_DATE               DATE,
  SUSPENSION_REASON             VARCHAR(12),
  FORCE_PASSWORD_CHANGE_FLAG    VARCHAR(1)  DEFAULT 'N',
  LAST_PASSWORD_CHANGE_DATE     DATE,
  LICENSE_CODE                  VARCHAR(12),
  LICENSE_EXPIRY_DATE           DATE,
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  TITLE                         VARCHAR(12),
  NAME_SEQUENCE                 VARCHAR(12),
  QUEUE_CLUSTER_ID              DECIMAL(6, 0),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  FIRST_LOGON_FLAG              VARCHAR(1)  DEFAULT 'N',
  SIGNIFICANT_DATE              DATE,
  SIGNIFICANT_NAME              VARCHAR(100),
  NATIONAL_INSURANCE_NUMBER     VARCHAR(13)
);

CREATE UNIQUE INDEX STAFF_MEMBERS_PK2 ON STAFF_MEMBERS (USER_ID);

ALTER TABLE STAFF_MEMBERS ALTER STAFF_ID SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER LAST_NAME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER FIRST_NAME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER UPDATE_ALLOWED_FLAG SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE STAFF_MEMBERS ALTER CREATE_USER_ID SET NOT NULL;


CREATE TABLE STAFF_USER_ACCOUNTS
(
  USERNAME                      VARCHAR(30),
  STAFF_ID                      DECIMAL(10, 0),
  STAFF_USER_TYPE               VARCHAR(12),
  ID_SOURCE                     VARCHAR(12),
  WORKING_CASELOAD_ID           VARCHAR(6),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

CREATE UNIQUE INDEX STAFF_USER_ACCOUNTS_UK1 ON STAFF_USER_ACCOUNTS (STAFF_ID, STAFF_USER_TYPE);
CREATE UNIQUE INDEX STAFF_USER_ACCOUNTS_PK ON STAFF_USER_ACCOUNTS (USERNAME);

ALTER TABLE STAFF_USER_ACCOUNTS ALTER USERNAME SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER STAFF_ID SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER STAFF_USER_TYPE SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER ID_SOURCE SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER CREATE_USER_ID SET NOT NULL;


CREATE TABLE STAFF_MEMBER_ROLES
(
  STAFF_ID                      DECIMAL(10, 0),
  ROLE_ID                       DECIMAL(10, 0),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  ROLE_CODE                     VARCHAR(30),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

CREATE UNIQUE INDEX STAFF_MEMBER_ROLES_PK ON STAFF_MEMBER_ROLES (ROLE_ID, STAFF_ID);

ALTER TABLE STAFF_MEMBER_ROLES ALTER STAFF_ID SET NOT NULL;
ALTER TABLE STAFF_MEMBER_ROLES ALTER ROLE_ID SET NOT NULL;
ALTER TABLE STAFF_MEMBER_ROLES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE STAFF_MEMBER_ROLES ALTER CREATE_USER_ID SET NOT NULL;
ALTER TABLE STAFF_MEMBER_ROLES ALTER ROLE_CODE SET NOT NULL;


CREATE TABLE INTERNET_ADDRESSES
(
  INTERNET_ADDRESS_ID           DECIMAL(10, 0),
  OWNER_CLASS                   VARCHAR(12),
  OWNER_ID                      DECIMAL(10, 0),
  OWNER_SEQ                     DECIMAL(6, 0),
  OWNER_CODE                    VARCHAR(12),
  INTERNET_ADDRESS_CLASS        VARCHAR(12) DEFAULT 'EMAIL',
  INTERNET_ADDRESS              VARCHAR(240),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

CREATE UNIQUE INDEX INTERNET_ADDRESSES_PK ON INTERNET_ADDRESSES (INTERNET_ADDRESS_ID);

ALTER TABLE INTERNET_ADDRESSES ALTER INTERNET_ADDRESS_ID SET NOT NULL;
ALTER TABLE INTERNET_ADDRESSES ALTER OWNER_CLASS SET NOT NULL;
ALTER TABLE INTERNET_ADDRESSES ALTER INTERNET_ADDRESS_CLASS SET NOT NULL;
ALTER TABLE INTERNET_ADDRESSES ALTER INTERNET_ADDRESS SET NOT NULL;
ALTER TABLE INTERNET_ADDRESSES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE INTERNET_ADDRESSES ALTER CREATE_USER_ID SET NOT NULL;


CREATE TABLE USER_CASELOAD_ROLES
(
  ROLE_ID                       DECIMAL(10, 0),
  USERNAME                      VARCHAR(30),
  CASELOAD_ID                   VARCHAR(6),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

ALTER TABLE USER_CASELOAD_ROLES ALTER ROLE_ID SET NOT NULL;
ALTER TABLE USER_CASELOAD_ROLES ALTER USERNAME SET NOT NULL;
ALTER TABLE USER_CASELOAD_ROLES ALTER CASELOAD_ID SET NOT NULL;
ALTER TABLE USER_CASELOAD_ROLES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE USER_CASELOAD_ROLES ALTER CREATE_USER_ID SET NOT NULL;


CREATE TABLE OMS_ROLES
(
  ROLE_ID                       DECIMAL(10, 0),
  ROLE_NAME                     VARCHAR(30),
  ROLE_SEQ                      DECIMAL(3, 0),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  ROLE_CODE                     VARCHAR(30),
  PARENT_ROLE_CODE              VARCHAR(30),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  ROLE_TYPE                     VARCHAR(12),
  ROLE_FUNCTION                 VARCHAR(12) DEFAULT 'GENERAL',
  SYSTEM_DATA_FLAG              VARCHAR(1)  DEFAULT 'N'
);

CREATE UNIQUE INDEX USER_GROUPS_PK ON OMS_ROLES (ROLE_ID);
CREATE UNIQUE INDEX OMS_ROLES_UK ON OMS_ROLES (ROLE_CODE);

ALTER TABLE OMS_ROLES ALTER ROLE_ID SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_NAME SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_SEQ SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER CREATE_USER_ID SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_CODE SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER ROLE_FUNCTION SET NOT NULL;
ALTER TABLE OMS_ROLES ALTER SYSTEM_DATA_FLAG SET NOT NULL;


CREATE TABLE SYSTEM_PROFILES
(
  PROFILE_TYPE                  VARCHAR(12),
  PROFILE_CODE                  VARCHAR(12),
  DESCRIPTION                   VARCHAR(80),
  PROFILE_VALUE                 VARCHAR(40),
  PROFILE_VALUE_2               VARCHAR(12),
  MODIFY_USER_ID                VARCHAR(32),
  OLD_TABLE_NAME                VARCHAR(50),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

CREATE UNIQUE INDEX SYSTEM_PROFILES_PK ON SYSTEM_PROFILES (PROFILE_TYPE, PROFILE_CODE);

ALTER TABLE SYSTEM_PROFILES ALTER PROFILE_TYPE SET NOT NULL;
ALTER TABLE SYSTEM_PROFILES ALTER PROFILE_CODE SET NOT NULL;
ALTER TABLE SYSTEM_PROFILES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE SYSTEM_PROFILES ALTER CREATE_USER_ID SET NOT NULL;

CREATE SEQUENCE CASE_NOTE_ID START WITH 1000 ;

CREATE TABLE OFFENDER_CASE_NOTES
(
  CASE_NOTE_ID                  SERIAL PRIMARY KEY,
  OFFENDER_BOOK_ID              DECIMAL(10, 0),
  CONTACT_DATE                  DATE,
  CONTACT_TIME                  TIMESTAMP(6),
  CASE_NOTE_TYPE                VARCHAR(12),
  CASE_NOTE_SUB_TYPE            VARCHAR(12),
  STAFF_ID                      DECIMAL(10, 0),
  CASE_NOTE_TEXT                VARCHAR(4000),
  AMENDMENT_FLAG                VARCHAR(1)  DEFAULT 'N',
  IWP_FLAG                      VARCHAR(1)  DEFAULT 'N',
  CHECK_BOX1                    VARCHAR(1)  DEFAULT 'N',
  CHECK_BOX2                    VARCHAR(1)  DEFAULT 'N',
  CHECK_BOX3                    VARCHAR(1)  DEFAULT 'N',
  CHECK_BOX4                    VARCHAR(1)  DEFAULT 'N',
  CHECK_BOX5                    VARCHAR(1)  DEFAULT 'N',
  EVENT_ID                      DECIMAL(10, 0),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  NOTE_SOURCE_CODE              VARCHAR(12),
  DATE_CREATION                 DATE              DEFAULT now(),
  TIME_CREATION                 DATE,
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

ALTER TABLE OFFENDER_CASE_NOTES ALTER OFFENDER_BOOK_ID SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CONTACT_DATE SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CONTACT_TIME SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CASE_NOTE_TYPE SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CASE_NOTE_SUB_TYPE SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER STAFF_ID SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER AMENDMENT_FLAG SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER IWP_FLAG SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CHECK_BOX1 SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CHECK_BOX2 SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CHECK_BOX3 SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CHECK_BOX4 SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CHECK_BOX5 SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE OFFENDER_CASE_NOTES ALTER CREATE_USER_ID SET NOT NULL;

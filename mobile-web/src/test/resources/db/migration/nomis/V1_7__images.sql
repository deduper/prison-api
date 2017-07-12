CREATE TABLE OFFENDER_IMAGES
(
  "OFFENDER_IMAGE_ID"             NUMBER(10, 0) PRIMARY KEY,
  "OFFENDER_BOOK_ID"              NUMBER(10, 0) NOT NULL,
  "CAPTURE_DATETIME"              DATE NOT NULL,
  "ORIENTATION_TYPE"              VARCHAR2(12 CHAR) NOT NULL,
  "FULL_SIZE_IMAGE"               BLOB,
  "THUMBNAIL_IMAGE"               BLOB,
  "IMAGE_OBJECT_TYPE"             VARCHAR2(12 CHAR) NOT NULL,
  "IMAGE_VIEW_TYPE"               VARCHAR2(12 CHAR),
  "IMAGE_OBJECT_ID"               NUMBER(10, 0),
  "IMAGE_OBJECT_SEQ"              NUMBER(10, 0),
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL,
  "IMAGE_SOURCE_CODE"             VARCHAR2(12 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR)
);


CREATE TABLE TAG_IMAGES
(
  "TAG_IMAGE_ID"                  NUMBER(10, 0),
  "IMAGE_OBJECT_TYPE"             VARCHAR2(12 CHAR),
  "IMAGE_OBJECT_ID"               NUMBER(10, 0),
  "IMAGE_OBJECT_SEQ"              NUMBER(6, 0),
  "CAPTURE_DATETIME"              DATE,
  "SET_NAME"                      VARCHAR2(12 CHAR),
  "IMAGE_VIEW_TYPE"               VARCHAR2(12 CHAR),
  "ORIENTATION_TYPE"              VARCHAR2(12 CHAR),
  "FULL_SIZE_IMAGE"               BLOB,
  "THUMBNAIL_IMAGE"               BLOB,
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'N',
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  "IMAGE_SOURCE_CODE"             VARCHAR2(12 CHAR)
);

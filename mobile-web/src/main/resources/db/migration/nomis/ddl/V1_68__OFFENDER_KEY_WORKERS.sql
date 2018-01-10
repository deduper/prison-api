CREATE TABLE "OFFENDER_KEY_WORKERS"
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0)                     NOT NULL ,
  "OFFICER_ID"                    NUMBER(6, 0)                      NOT NULL ,
  "ASSIGNED_DATE"                 DATE                              NOT NULL ,
  "ASSIGNED_TIME"                 DATE                              NOT NULL ,
  "USER_ID"                       VARCHAR2(32 CHAR)                 NOT NULL ,
  "ALLOC_REASON"                  VARCHAR2(12) DEFAULT 'MANUAL'     NOT NULL ,
  "ALLOC_TYPE"                    VARCHAR2(1) DEFAULT 'M'           NOT NULL ,
  "DEALLOC_REASON"                VARCHAR2(12),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR)                  NOT NULL ,
  "ACTIVE_FLAG"                   VARCHAR2(1 CHAR) DEFAULT 'Y'      NOT NULL ,
  "EXPIRY_DATE"                   DATE,
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp NOT NULL ,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER    NOT NULL ,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  CONSTRAINT "OFFENDER_KEY_WORKERS_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "OFFICER_ID", "ASSIGNED_DATE", "ASSIGNED_TIME"),
  CONSTRAINT "OFF_KEY_WORKERS_BOOK_ID_FK" FOREIGN KEY ("OFFENDER_BOOK_ID")
  REFERENCES "OFFENDER_BOOKINGS" ("OFFENDER_BOOK_ID") ,
  CONSTRAINT "OFF_KEY_WORKERS_OFFICER_ID_FK" FOREIGN KEY ("OFFICER_ID")
  REFERENCES "STAFF_MEMBERS" ("STAFF_ID"),
  CONSTRAINT OFFENDER_KEY_WORKERS_C1 CHECK (ALLOC_TYPE IN ('A','M'))
);


COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."OFFENDER_BOOK_ID" IS 'The Related Offender Book Id';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."OFFICER_ID" IS 'The Related Key Worker Staff Id';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."ASSIGNED_DATE" IS 'Assigned Date';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."ASSIGNED_TIME" IS 'Assigned Time';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."ALLOC_REASON" IS 'Reason for allocation';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."ALLOC_TYPE" IS 'Type of allocation, M for manual, A for auto';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."USER_ID" IS 'Assigned by User Id';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."AGY_LOC_ID" IS 'Establishment';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."ACTIVE_FLAG" IS 'Assignment Active Flag';

COMMENT ON COLUMN "OFFENDER_KEY_WORKERS"."EXPIRY_DATE" IS 'Expiry Date of Assignment';

COMMENT ON TABLE "OFFENDER_KEY_WORKERS" IS 'Records the Key Worker assignment history of offenders on remand or serving custodial sentences held within an establishment.';


CREATE INDEX "OFF_KEY_WORKERS_BOOK_ID_FK"
  ON "OFFENDER_KEY_WORKERS" ("OFFENDER_BOOK_ID");


CREATE INDEX "OFF_KEY_WORKERS_OFFICER_ID_FK"
  ON "OFFENDER_KEY_WORKERS" ("OFFICER_ID");


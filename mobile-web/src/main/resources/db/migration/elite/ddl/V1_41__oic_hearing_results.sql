CREATE TABLE OIC_HEARING_RESULTS
(
    OIC_HEARING_ID     NUMBER(10)                          NOT NULL,
    RESULT_SEQ         NUMBER(6)                           NOT NULL,
    AGENCY_INCIDENT_ID NUMBER(10)                          NOT NULL,
    CHARGE_SEQ         NUMBER(6)                           NOT NULL,
    PLEA_FINDING_CODE  VARCHAR2(12)                        NOT NULL,
    FINDING_CODE       VARCHAR2(12)                        NOT NULL,
    CREATE_DATETIME    TIMESTAMP (9) DEFAULT SYSTIMESTAMP  NOT NULL,
    CREATE_USER_ID     VARCHAR2(32) DEFAULT user           NOT NULL,
    MODIFY_DATETIME    TIMESTAMP (9) DEFAULT SYSTIMESTAMP,          
    MODIFY_USER_ID     VARCHAR2(32),                                
    OIC_OFFENCE_ID     NUMBER(10)                          NOT NULL,
    SEAL_FLAG          VARCHAR2(1),

     CONSTRAINT OIC_HEARING_RESULTS_PK PRIMARY KEY (OIC_HEARING_ID, RESULT_SEQ),

     CONSTRAINT OIC_HEARING_RESULTS_UK UNIQUE (OIC_HEARING_ID, AGENCY_INCIDENT_ID, CHARGE_SEQ)
);

CREATE INDEX OIC_HEARING_RESULTS_NI1 ON OIC_HEARING_RESULTS (AGENCY_INCIDENT_ID, CHARGE_SEQ);
CREATE INDEX OIC_HEARING_RESULTS_NI2 ON OIC_HEARING_RESULTS (OIC_OFFENCE_ID);


--INSERT INTO ASSESSMENTS (ASSESSMENT_ID, ASSESSMENT_CLASS, ASSESSMENT_CODE, CELL_SHARING_ALERT_FLAG, DESCRIPTION, LIST_SEQ, ACTIVE_FLAG, UPDATE_ALLOWED_FLAG, EFFECTIVE_DATE, MUTUAL_EXCLUSIVE_FLAG, DETERMINE_SUP_LEVEL_FLAG, REQUIRE_EVALUATION_FLAG, REQUIRE_APPROVAL_FLAG, REVIEW_CYCLE_DAYS, CASELOAD_TYPE, REVIEW_FLAG, SEARCH_CRITERIA_FLAG, OVERRIDEABLE_FLAG, CALCULATE_TOTAL_FLAG, SCREEN_CODE)                             VALUES (-2, 'TYPE', 'CATEGORY', 'N', 'Categorisation', 2, 'Y', 'Y', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'N', 'N', 'N', 'Y', 1, 'INST', 'Y', 'N', 'N', 'Y', 'ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,                     ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,            MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,                CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-3, 'TYPE', 'PAROLE',   'N', 'Parole',         3, 'Y', 'Y', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'N', 'N', 'N', 'Y', 1, 'INST', 'Y', 'N', 'N', 'Y', 'ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-4,'TYPE', null,'CSRREV',  'Y','CSR Review',                                     1,'Y','Y',to_date('01-01-2000','DD-MM-YYYY'),null,                              'N','N','N','Y',90,  'INST','Y','N','N',       null,'Y','ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-5,'TYPE', null,'CSRDO',   'Y','CSR Locate',                                     3,'N','Y',to_date('01-01-2000','DD-MM-YYYY'),to_date('23-05-2009','DD-MM-YYYY'),'N','N','N','Y',null,'INST','N','N','N',       null,'Y',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-6,'TYPE', null,'CSR1',    'Y','CSR Reception',                                  1,'Y','Y',to_date('01-01-2000','DD-MM-YYYY'),null,                              'Y','N','Y','Y',null,'INST','N','N','N','INCLUSIVE','Y','ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-7,'TYPE', null,'CSRH',    'N','CSR Health',                                     2,'N','Y',to_date('01-01-2000','DD-MM-YYYY'),to_date('23-05-2009','DD-MM-YYYY'),'N','N','N','Y',null,'INST','Y','N','N',       null,'Y',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-8,'TYPE', null,'CSRF',    'Y','CSR Full',                                       1,'Y','Y',to_date('01-01-2000','DD-MM-YYYY'),null,                              'N','N','N','Y',30,  'INST','Y','N','N',       null,'Y','ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-1,  'TYPE', null,'CSR',     'Y','CSR Rating',                                     1,'Y','Y',to_date('01-01-2000','DD-MM-YYYY'),null,                              'N','N','N','Y',1,   'INST','Y','N','N',       null,'Y','ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-2,  'TYPE', null,'CATEGORY','N','Categorisation',                                 1,'Y','Y',to_date('01-01-2000','DD-MM-YYYY'),null,                              'Y','Y','Y','Y',180, 'INST','Y','N','N','INCLUSIVE','Y','ASSESS');
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-9,'SECT', -2,  'COMPLETE','N','Section 2: Assessment Completion',               7,'Y','Y',null,                              null,                              'N','N','N', 'N',null,null, 'N','N','N',       null,'N',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-10,'TYPE',null,'CSRA',    'N','Medium',                                      null,'Y','Y',to_date('14-05-2010','DD-MM-YYYY'),null,                              'N','Y','N','Y',  14,null,  'N','N','N',       null,'Y',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-11,'SECT', -4,'CSRREV1', 'N','Section 1:Cell Sharing Risk Review',             1,'Y','Y',null,                              null,                              'N','N','N','N',null,null,  'N','N','N',       null,'N',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-12,'SECT', -8,'1',       'N','Section 1: Documentation Review - please select',1,'Y','Y',null,                              null,                              'N','N','N','N',null,null,  'N','N','N',null,       'N',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-13,'CAT',  -12,'ACCT4',   'N','F2052SH/ACCT (either open or closed)',           3,'Y','Y',null,                              null,                              'N','N','N','N',null,null,  'N','N','N','INCLUSIVE','N',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (-14,'CAT',  -12,'WARR',    'N','Warrant',                                        2,'Y','Y',null,                              null,                              'N','N','N','N',null,null,  'N','N','N','INCLUSIVE','N',null);
INSERT INTO ASSESSMENTS (ASSESSMENT_ID,ASSESSMENT_CLASS,PARENT_ASSESSMENT_ID,ASSESSMENT_CODE,CELL_SHARING_ALERT_FLAG,DESCRIPTION,LIST_SEQ,ACTIVE_FLAG,UPDATE_ALLOWED_FLAG,EFFECTIVE_DATE,EXPIRY_DATE,MUTUAL_EXCLUSIVE_FLAG,DETERMINE_SUP_LEVEL_FLAG,REQUIRE_EVALUATION_FLAG,REQUIRE_APPROVAL_FLAG,REVIEW_CYCLE_DAYS,CASELOAD_TYPE,REVIEW_FLAG,SEARCH_CRITERIA_FLAG,OVERRIDEABLE_FLAG,ASSESSMENT_TYPE,CALCULATE_TOTAL_FLAG,SCREEN_CODE) VALUES (9688,'TYPE',  null,'CATEGORY',    'N','Categorisation',                                        2,'Y','Y',null,                              null,                              'N','N','N','N',null,null,  'N','N','N',null,'N',null);

-------------------------------------------------------
-- Seed data for Appointments (APP) Scheduled Events --
-------------------------------------------------------

-- OFFENDER_IND_SCHEDULES (record of individual scheduled events, incl. appointments)
-- NB: Dates deliberately out of sequence (to allow default sorting to be verified)
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-1,  -1, TO_DATE('2017-09-15', 'YYYY-MM-DD'), TO_DATE('2017-09-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI', 'LEI', -29, null, null, 'comment1');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-2,  -1, TO_DATE('2017-08-15', 'YYYY-MM-DD'), TO_DATE('2017-08-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-08-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI', 'LEI', -29, null, null, 'comment2');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-3,  -1, TO_DATE('2017-08-12', 'YYYY-MM-DD'), TO_DATE('2017-08-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-08-15 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'CHAP', 'SCH', 'LEI', 'LEI', null, null, null, 'comment3');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-4,  -1, TO_DATE('2017-09-18', 'YYYY-MM-DD'), TO_DATE('2017-09-18 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-18 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'IMM',  'SCH', null, null, null, -1, null, 'comment4');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-5,  -1, TO_DATE('2017-07-22', 'YYYY-MM-DD'), TO_DATE('2017-07-22 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-22 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI',  'LEI', -27, null, null, 'comment5');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-6,  -1, TO_DATE('2017-06-15', 'YYYY-MM-DD'), TO_DATE('2017-06-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-06-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEPS', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment6');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-7,  -1, TO_DATE('2017-05-15', 'YYYY-MM-DD'), TO_DATE('2017-05-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment7');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-8,  -1, TO_DATE('2017-04-15', 'YYYY-MM-DD'), TO_DATE('2017-04-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-04-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', null, null, -29, null, null, 'comment8');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-9,  -1, TO_DATE('2017-03-15', 'YYYY-MM-DD'), TO_DATE('2017-03-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-03-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment9');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-10, -1, TO_DATE('2017-02-15', 'YYYY-MM-DD'), TO_DATE('2017-02-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-02-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', null, null, null, null, '29216', 'comment10');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-11, -1, TO_DATE('2017-01-15', 'YYYY-MM-DD'), TO_DATE('2017-01-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-01-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment11');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-13, -1, TO_DATE('2017-11-15', 'YYYY-MM-DD'), TO_DATE('2017-11-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-11-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment13');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-14, -1, TO_DATE('2017-12-15', 'YYYY-MM-DD'), TO_DATE('2017-12-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-12-15 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment14');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-15, -1, TO_DATE('2017-12-25', 'YYYY-MM-DD'), TO_DATE('2017-12-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-12-25 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'CHAP', 'SCH', 'LEI',  'LEI', -25, null, null, 'comment15');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-16, -2, TO_DATE('2017-05-12', 'YYYY-MM-DD'), TO_DATE('2017-05-12 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'IMM',  'SCH', 'LEI',  'LEI', -28, null, null, 'comment16');

INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-12, -1, TO_DATE('2017-10-15', 'YYYY-MM-DD'), TO_DATE('2017-10-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-10-15 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment12');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-24, -2, TO_DATE('2017-10-15', 'YYYY-MM-DD'), TO_DATE('2017-10-15 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-10-15 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI',  'LEI', -29, null, null, 'comment24');

-- These appointments defined for current day, this week and next week (to test 'today', 'thisWeek' and 'nextWeek' endpoint actions).
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-17, -3, trunc(sysdate),                     trunc(sysdate) + INTERVAL '3' HOUR, trunc(sysdate) + INTERVAL '3' HOUR, 'INT_MOV', 'APP', 'MEDE', 'SCH', 'LEI', 'LEI', -29, null, null, 'comment17');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-18, -3, trunc(sysdate),                     trunc(sysdate) + INTERVAL '4' HOUR, trunc(sysdate) + INTERVAL '4' HOUR, 'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment18');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-19, -3, trunc(sysdate) + INTERVAL '1' DAY,  trunc(sysdate) + INTERVAL '1' DAY,  trunc(sysdate) + INTERVAL '1' DAY,  'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment19');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-20, -3, trunc(sysdate) + INTERVAL '7' DAY,  trunc(sysdate) + INTERVAL '7' DAY,  trunc(sysdate) + INTERVAL '7' DAY,  'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment20');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-21, -3, trunc(sysdate) + INTERVAL '12' DAY, trunc(sysdate) + INTERVAL '12' DAY, trunc(sysdate) + INTERVAL '12' DAY, 'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment21');
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-22, -3, trunc(sysdate) + INTERVAL '17' DAY, trunc(sysdate) + INTERVAL '17' DAY, trunc(sysdate) + INTERVAL '17' DAY, 'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment22');
-- extra event today for different offender to test groups
INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-23, -5, trunc(sysdate),                     trunc(sysdate) + INTERVAL '1' HOUR, trunc(sysdate) + INTERVAL '1' HOUR, 'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment23');

INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_AGY_LOC_ID, TO_INTERNAL_LOCATION_ID, TO_ADDRESS_ID, TO_CITY_CODE, COMMENT_TEXT) VALUES (-25, -5, trunc(sysdate),                     trunc(sysdate) + 10/24,             trunc(sysdate) + 12/24,             'INT_MOV', 'APP', 'EDUC', 'SCH', 'LEI', 'LEI', -28, null, null, 'comment23');

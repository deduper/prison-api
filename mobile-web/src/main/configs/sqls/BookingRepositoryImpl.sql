GET_BOOKING_SENTENCE_DETAIL {
  SELECT OB.OFFENDER_BOOK_ID,
    (SELECT MIN(OST.START_DATE)
     FROM OFFENDER_SENTENCE_TERMS OST
     WHERE OST.SENTENCE_TERM_CODE = 'IMP'
     AND OST.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OST.OFFENDER_BOOK_ID) SENTENCE_START_DATE,
    SED SENTENCE_EXPIRY_DATE,
    LED LICENCE_EXPIRY_DATE,
    PED PAROLE_ELIGIBILITY_DATE,
    HDCED HOME_DET_CURF_ELIGIBILITY_DATE,
    HDCAD_OVERRIDED_DATE HOME_DET_CURF_ACTUAL_DATE,
    APD_OVERRIDED_DATE ACTUAL_PAROLE_DATE,
    ETD EARLY_TERM_DATE,
    MTD MID_TERM_DATE,
    LTD LATE_TERM_DATE,
    TARIFF_DATE,
    ARD_OVERRIDED_DATE,
    ARD_CALCULATED_DATE,
    CRD_OVERRIDED_DATE,
    CRD_CALCULATED_DATE,
    NPD_OVERRIDED_DATE,
    NPD_CALCULATED_DATE,
    PRRD_OVERRIDED_DATE,
    PRRD_CALCULATED_DATE,
    (SELECT SUM(ADJUST_DAYS)
     FROM OFFENDER_KEY_DATE_ADJUSTS OKDA
     WHERE OKDA.SENTENCE_ADJUST_CODE = 'ADA'
     AND OKDA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OKDA.OFFENDER_BOOK_ID) ADDITIONAL_DAYS_AWARDED
  FROM
    (SELECT OSC.OFFENDER_BOOK_ID,
            CALCULATION_DATE,
            COALESCE(SED_OVERRIDED_DATE, SED_CALCULATED_DATE) SED,
            COALESCE(LED_OVERRIDED_DATE, LED_CALCULATED_DATE) LED,
            COALESCE(PED_OVERRIDED_DATE, PED_CALCULATED_DATE) PED,
            COALESCE(HDCED_OVERRIDED_DATE, HDCED_CALCULATED_DATE) HDCED,
            COALESCE(ETD_OVERRIDED_DATE, ETD_CALCULATED_DATE) ETD,
            COALESCE(MTD_OVERRIDED_DATE, MTD_CALCULATED_DATE) MTD,
            COALESCE(LTD_OVERRIDED_DATE, LTD_CALCULATED_DATE) LTD,
            COALESCE(TARIFF_OVERRIDED_DATE, TARIFF_CALCULATED_DATE) TARIFF_DATE,
            HDCAD_OVERRIDED_DATE,
            APD_OVERRIDED_DATE,
            ARD_OVERRIDED_DATE,
            ARD_CALCULATED_DATE,
            CRD_OVERRIDED_DATE,
            CRD_CALCULATED_DATE,
            NPD_OVERRIDED_DATE,
            NPD_CALCULATED_DATE,
            PRRD_OVERRIDED_DATE,
            PRRD_CALCULATED_DATE
     FROM OFFENDER_SENT_CALCULATIONS OSC
       INNER JOIN (SELECT OFFENDER_BOOK_ID, MAX(CALCULATION_DATE) MAX_CALC_DATE
                   FROM OFFENDER_SENT_CALCULATIONS
                   GROUP BY OFFENDER_BOOK_ID) LATEST_OSC
         ON OSC.OFFENDER_BOOK_ID = LATEST_OSC.OFFENDER_BOOK_ID
            AND OSC.CALCULATION_DATE = LATEST_OSC.MAX_CALC_DATE) CALC_DATES
    RIGHT JOIN OFFENDER_BOOKINGS OB ON CALC_DATES.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

GET_OFFENDER_SENTENCE_DETAIL {
  SELECT OB.OFFENDER_BOOK_ID,
    O.OFFENDER_ID_DISPLAY                          OFFENDER_NO,
    O.FIRST_NAME,
    O.LAST_NAME,
    O.BIRTH_DATE                                        DATE_OF_BIRTH,
    OB.agy_loc_id                                  agency_location_id,
    AL.description                                 agency_location_desc,
    AIL.DESCRIPTION                                internal_location_desc,
    (SELECT *
     FROM (SELECT IMAGE_ID
           FROM IMAGES
           WHERE ACTIVE_FLAG = 'Y'
                 AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                 AND IMAGE_OBJECT_ID = OB.OFFENDER_BOOK_ID
                 AND IMAGE_VIEW_TYPE = 'FACE'
                 AND ORIENTATION_TYPE = 'FRONT'
           ORDER BY CREATE_DATETIME DESC)
     WHERE ROWNUM <= 1) AS FACIAL_IMAGE_ID,
    COALESCE(ord.release_date, ord.auto_release_date) CONFIRMED_RELEASE_DATE,
    (SELECT MIN(OST.START_DATE)
     FROM OFFENDER_SENTENCE_TERMS OST
     WHERE OST.SENTENCE_TERM_CODE = 'IMP'
           AND OST.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OST.OFFENDER_BOOK_ID) SENTENCE_START_DATE,
    SED SENTENCE_EXPIRY_DATE,
    LED LICENCE_EXPIRY_DATE,
    PED PAROLE_ELIGIBILITY_DATE,
    HDCED HOME_DET_CURF_ELIGIBILITY_DATE,
    HDCAD_OVERRIDED_DATE HOME_DET_CURF_ACTUAL_DATE,
    APD_OVERRIDED_DATE ACTUAL_PAROLE_DATE,
    ETD EARLY_TERM_DATE,
    MTD MID_TERM_DATE,
    LTD LATE_TERM_DATE,
    TARIFF_DATE,
    ARD_OVERRIDED_DATE,
    ARD_CALCULATED_DATE,
    CRD_OVERRIDED_DATE,
    CRD_CALCULATED_DATE,
    NPD_OVERRIDED_DATE,
    NPD_CALCULATED_DATE,
    PRRD_OVERRIDED_DATE,
    PRRD_CALCULATED_DATE,
    (SELECT SUM(ADJUST_DAYS)
     FROM OFFENDER_KEY_DATE_ADJUSTS OKDA
     WHERE OKDA.SENTENCE_ADJUST_CODE = 'ADA'
           AND OKDA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OKDA.OFFENDER_BOOK_ID) ADDITIONAL_DAYS_AWARDED
  FROM
    (SELECT OSC.OFFENDER_BOOK_ID,
       CALCULATION_DATE,
       COALESCE(SED_OVERRIDED_DATE, SED_CALCULATED_DATE) SED,
       COALESCE(LED_OVERRIDED_DATE, LED_CALCULATED_DATE) LED,
       COALESCE(PED_OVERRIDED_DATE, PED_CALCULATED_DATE) PED,
       COALESCE(HDCED_OVERRIDED_DATE, HDCED_CALCULATED_DATE) HDCED,
       COALESCE(ETD_OVERRIDED_DATE, ETD_CALCULATED_DATE) ETD,
       COALESCE(MTD_OVERRIDED_DATE, MTD_CALCULATED_DATE) MTD,
       COALESCE(LTD_OVERRIDED_DATE, LTD_CALCULATED_DATE) LTD,
       COALESCE(TARIFF_OVERRIDED_DATE, TARIFF_CALCULATED_DATE) TARIFF_DATE,
       HDCAD_OVERRIDED_DATE,
       APD_OVERRIDED_DATE,
       ARD_OVERRIDED_DATE,
       ARD_CALCULATED_DATE,
       CRD_OVERRIDED_DATE,
       CRD_CALCULATED_DATE,
       NPD_OVERRIDED_DATE,
       NPD_CALCULATED_DATE,
       PRRD_OVERRIDED_DATE,
       PRRD_CALCULATED_DATE
     FROM OFFENDER_SENT_CALCULATIONS OSC
       INNER JOIN (SELECT OFFENDER_BOOK_ID, MAX(CALCULATION_DATE) MAX_CALC_DATE
                   FROM OFFENDER_SENT_CALCULATIONS
                   GROUP BY OFFENDER_BOOK_ID) LATEST_OSC
         ON OSC.OFFENDER_BOOK_ID = LATEST_OSC.OFFENDER_BOOK_ID
            AND OSC.CALCULATION_DATE = LATEST_OSC.MAX_CALC_DATE) CALC_DATES
    RIGHT JOIN OFFENDER_BOOKINGS OB ON CALC_DATES.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    INNER JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = OB.AGY_LOC_ID
    left join offender_release_details ord on ord.offender_book_id = ob.offender_book_id
    WHERE ob.ACTIVE_FLAG = 'Y'
}

GET_BOOKING_ACTIVITIES {
  SELECT OPP.OFFENDER_BOOK_ID BOOKING_ID,
	       'INT_MOV' EVENT_CLASS,
	       COALESCE(OCA.EVENT_STATUS, 'SCH') EVENT_STATUS,
         'PRISON_ACT' EVENT_TYPE,
         RD1.DESCRIPTION EVENT_TYPE_DESC,
	       CA.COURSE_ACTIVITY_TYPE EVENT_SUB_TYPE,
	       RD2.DESCRIPTION EVENT_SUB_TYPE_DESC,
	       CS.SCHEDULE_DATE EVENT_DATE,
	       CS.START_TIME,
	       CS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.STREET) EVENT_LOCATION,
         'PA' EVENT_SOURCE,
         CA.CODE EVENT_SOURCE_CODE,
         CA.DESCRIPTION EVENT_SOURCE_DESC
  FROM OFFENDER_PROGRAM_PROFILES OPP
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN COURSE_ACTIVITIES CA ON CA.CRS_ACTY_ID = OPP.CRS_ACTY_ID
    INNER JOIN COURSE_SCHEDULES CS ON OPP.CRS_ACTY_ID = CS.CRS_ACTY_ID
      AND CS.SCHEDULE_DATE >= TRUNC(OPP.OFFENDER_START_DATE)
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(OPP.OFFENDER_END_DATE, CA.SCHEDULE_END_DATE, CS.SCHEDULE_DATE)
      AND CS.SCHEDULE_DATE >= TRUNC(COALESCE(:fromDate, CS.SCHEDULE_DATE))
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(:toDate, CS.SCHEDULE_DATE)
    LEFT JOIN OFFENDER_COURSE_ATTENDANCES OCA ON OCA.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID
      AND TRUNC(OCA.EVENT_DATE) = TRUNC(CS.SCHEDULE_DATE)
      AND OCA.CRS_SCH_ID = CS.CRS_SCH_ID
    LEFT JOIN REFERENCE_CODES RD1 ON RD1.CODE = 'PRISON_ACT' AND RD1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = CA.COURSE_ACTIVITY_TYPE AND RD2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON CA.INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON CA.AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON CA.SERVICES_ADDRESS_ID = ADDR.ADDRESS_ID
  WHERE OPP.OFFENDER_BOOK_ID = :bookingId
    AND OPP.OFFENDER_PROGRAM_STATUS = 'ALLOC'
    AND COALESCE(OPP.SUSPENDED_FLAG, 'N') = 'N'
    AND CA.ACTIVE_FLAG = 'Y'
    AND CA.COURSE_ACTIVITY_TYPE IS NOT NULL
    AND CS.CATCH_UP_CRS_SCH_ID IS NULL
}

GET_BOOKING_IEP_DETAILS {
  SELECT OIL.OFFENDER_BOOK_ID BOOKING_ID,
         IEP_DATE,
         IEP_TIME,
         OIL.AGY_LOC_ID AGENCY_ID,
         COALESCE(RC.DESCRIPTION, OIL.IEP_LEVEL) IEP_LEVEL,
         COMMENT_TEXT,
         USER_ID
  FROM OFFENDER_IEP_LEVELS OIL
    INNER JOIN OFFENDER_BOOKINGS OB ON OIL.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RC ON RC.CODE = OIL.IEP_LEVEL AND RC.DOMAIN = 'IEP_LEVEL'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
  ORDER BY OIL.IEP_DATE DESC, OIL.IEP_LEVEL_SEQ DESC
}

  GET_BOOKING_IEP_DETAILS_BY_IDS {
  SELECT OIL.OFFENDER_BOOK_ID BOOKING_ID,
    IEP_DATE,
    IEP_TIME,
         OIL.AGY_LOC_ID AGENCY_ID,
         COALESCE(RC.DESCRIPTION, OIL.IEP_LEVEL) IEP_LEVEL,
    COMMENT_TEXT,
    USER_ID
  FROM OFFENDER_IEP_LEVELS OIL
    INNER JOIN OFFENDER_BOOKINGS OB ON OIL.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RC ON RC.CODE = OIL.IEP_LEVEL AND RC.DOMAIN = 'IEP_LEVEL'
  WHERE OB.OFFENDER_BOOK_ID IN (:bookingIds)
  ORDER BY OB.OFFENDER_BOOK_ID, OIL.IEP_DATE DESC, OIL.IEP_TIME DESC, OIL.IEP_LEVEL_SEQ DESC
}

CHECK_BOOKING_AGENCIES {
  SELECT OFFENDER_BOOK_ID
  FROM OFFENDER_BOOKINGS
  WHERE ACTIVE_FLAG = 'Y'
  AND OFFENDER_BOOK_ID = :bookingId
  AND AGY_LOC_ID IN (:agencyIds)
}

GET_OFFENDER_BOOKING_AGENCY {
  SELECT AGY_LOC_ID
  FROM OFFENDER_BOOKINGS
  WHERE ACTIVE_FLAG = 'Y'
        AND OFFENDER_BOOK_ID = :bookingId
}

GET_BOOKING_VISITS {
  SELECT VIS.OFFENDER_BOOK_ID BOOKING_ID,
	     'INT_MOV' EVENT_CLASS,
	     'SCH' EVENT_STATUS,
         'VISIT' EVENT_TYPE,
         RC1.DESCRIPTION EVENT_TYPE_DESC,
	     'VISIT' EVENT_SUB_TYPE,
	     RC2.DESCRIPTION EVENT_SUB_TYPE_DESC,
	     VIS.VISIT_DATE EVENT_DATE,
	     VIS.START_TIME,
	     VIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION) EVENT_LOCATION,
         'VIS' EVENT_SOURCE,
         VIS.VISIT_TYPE EVENT_SOURCE_CODE,
         RC3.DESCRIPTION EVENT_SOURCE_DESC
  FROM OFFENDER_VISITS VIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = VIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = 'VISIT' AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = 'VISIT' AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = VIS.VISIT_TYPE AND RC3.DOMAIN = 'VISIT_TYPE'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON VIS.VISIT_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON VIS.AGY_LOC_ID = AGY.AGY_LOC_ID
  WHERE VIS.OFFENDER_BOOK_ID = :bookingId
    AND VIS.VISIT_STATUS = 'SCH'
    AND VIS.VISIT_DATE >= TRUNC(COALESCE(:fromDate, VIS.VISIT_DATE))
    AND TRUNC(VIS.VISIT_DATE) <= COALESCE(:toDate, VIS.VISIT_DATE)
}

GET_LAST_BOOKING_VISIT {
SELECT * FROM (SELECT 
    VISITOR.OUTCOME_REASON_CODE CANCELLATION_REASON,
    RC5.DESCRIPTION CANCEL_REASON_DESCRIPTION,
    VISITOR.EVENT_STATUS,
    RC2.DESCRIPTION EVENT_STATUS_DESCRIPTION,
    NVL(VISITOR.EVENT_OUTCOME,'ATT') EVENT_OUTCOME,
    RC4.DESCRIPTION EVENT_OUTCOME_DESCRIPTION,
    VISIT.START_TIME,
    VISIT.END_TIME,
    COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION) LOCATION,
    VISIT.VISIT_TYPE,
    RC3.DESCRIPTION VISIT_TYPE_DESCRIPTION,
    P.FIRST_NAME || ' ' || P.LAST_NAME LEAD_VISITOR,
    OCP.RELATIONSHIP_TYPE RELATIONSHIP,
    RC1.DESCRIPTION RELATIONSHIP_DESCRIPTION
  FROM OFFENDER_VISITS VISIT
    INNER JOIN OFFENDER_BOOKINGS BOOKING ON BOOKING.OFFENDER_BOOK_ID = VISIT.OFFENDER_BOOK_ID AND BOOKING.ACTIVE_FLAG = 'Y'
    LEFT JOIN OFFENDER_VISIT_VISITORS VISITOR ON VISIT.OFFENDER_VISIT_ID = VISITOR.OFFENDER_VISIT_ID AND VISITOR.GROUP_LEADER_FLAG = 'Y' AND VISITOR.PERSON_ID IS NOT NULL 
    LEFT JOIN OFFENDER_CONTACT_PERSONS OCP ON VISITOR.PERSON_ID = OCP.PERSON_ID AND VISIT.OFFENDER_BOOK_ID = OCP.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.DOMAIN = 'RELATIONSHIP' AND RC1.CODE = OCP.RELATIONSHIP_TYPE
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.DOMAIN = 'EVENT_STS' AND RC2.CODE = VISITOR.EVENT_STATUS
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.DOMAIN = 'VISIT_TYPE' AND RC3.CODE = VISIT.VISIT_TYPE
    LEFT JOIN REFERENCE_CODES RC4 ON RC4.DOMAIN = 'OUTCOMES' AND RC4.CODE = NVL(VISITOR.EVENT_OUTCOME,'ATT')
    LEFT JOIN REFERENCE_CODES RC5 ON RC5.DOMAIN = 'MOVE_CANC_RS' AND RC5.CODE = VISITOR.OUTCOME_REASON_CODE
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON VISIT.VISIT_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON VISIT.AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN PERSONS P ON P.PERSON_ID = VISITOR.PERSON_ID
  WHERE VISIT.OFFENDER_BOOK_ID = :bookingId
    AND VISIT.START_TIME < :cutoffDate
  ORDER BY VISIT.START_TIME DESC, VISIT.OFFENDER_VISIT_ID DESC)
WHERE ROWNUM = 1
}

GET_BOOKING_APPOINTMENTS {
  SELECT OIS.OFFENDER_BOOK_ID BOOKING_ID,
	       OIS.EVENT_CLASS,
	       OIS.EVENT_STATUS,
         OIS.EVENT_TYPE,
         RC1.DESCRIPTION EVENT_TYPE_DESC,
	       OIS.EVENT_SUB_TYPE,
	       RC2.DESCRIPTION EVENT_SUB_TYPE_DESC,
	       OIS.EVENT_DATE,
	       OIS.START_TIME,
	       OIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.STREET, RC3.DESCRIPTION) EVENT_LOCATION,
         'APP' EVENT_SOURCE,
         'APP' EVENT_SOURCE_CODE,
         OIS.COMMENT_TEXT EVENT_SOURCE_DESC
  FROM OFFENDER_IND_SCHEDULES OIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OIS.EVENT_TYPE AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OIS.EVENT_SUB_TYPE AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OIS.TO_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON OIS.TO_AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON OIS.TO_ADDRESS_ID = ADDR.ADDRESS_ID
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = OIS.TO_CITY_CODE AND RC3.DOMAIN = 'CITY'
  WHERE OIS.OFFENDER_BOOK_ID = :bookingId
    AND OIS.EVENT_TYPE = 'APP'
    AND OIS.EVENT_STATUS = 'SCH'
    AND OIS.EVENT_DATE >= TRUNC(COALESCE(:fromDate, OIS.EVENT_DATE))
    AND TRUNC(OIS.EVENT_DATE) <= COALESCE(:toDate, OIS.EVENT_DATE)
}

GET_BOOKING_APPOINTMENT {
  SELECT OIS.OFFENDER_BOOK_ID BOOKING_ID,
         OIS.EVENT_CLASS,
         OIS.EVENT_STATUS,
         OIS.EVENT_TYPE,
         RC1.DESCRIPTION EVENT_TYPE_DESC,
         OIS.EVENT_SUB_TYPE,
         RC2.DESCRIPTION EVENT_SUB_TYPE_DESC,
         OIS.EVENT_DATE,
         OIS.START_TIME,
         OIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.STREET, RC3.DESCRIPTION) EVENT_LOCATION,
         'APP' EVENT_SOURCE,
         'APP' EVENT_SOURCE_CODE,
         OIS.COMMENT_TEXT EVENT_SOURCE_DESC
  FROM OFFENDER_IND_SCHEDULES OIS
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OIS.EVENT_TYPE AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OIS.EVENT_SUB_TYPE AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OIS.TO_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON OIS.TO_AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON OIS.TO_ADDRESS_ID = ADDR.ADDRESS_ID
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = OIS.TO_CITY_CODE AND RC3.DOMAIN = 'CITY'
  WHERE OIS.OFFENDER_BOOK_ID = :bookingId
    AND OIS.EVENT_ID = :eventId
    AND OIS.EVENT_TYPE = 'APP'
    AND OIS.EVENT_STATUS = 'SCH'
}

INSERT_APPOINTMENT {
  INSERT INTO OFFENDER_IND_SCHEDULES (EVENT_ID, OFFENDER_BOOK_ID, EVENT_DATE, START_TIME, END_TIME, COMMENT_TEXT,
    EVENT_CLASS, EVENT_TYPE, EVENT_SUB_TYPE, EVENT_STATUS, AGY_LOC_ID, TO_INTERNAL_LOCATION_ID)
  VALUES (EVENT_ID.NEXTVAL, :bookingId, :eventDate, :startTime, :endTime, :comment,
    'INT_MOV', 'APP', :eventSubType, 'SCH', :agencyId, :locationId)
}

FIND_BOOKING_ID_BY_OFFENDER_NO {
  SELECT B.OFFENDER_BOOK_ID
  FROM OFFENDER_BOOKINGS B
     JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  WHERE B.ACTIVE_FLAG = 'Y' AND O.OFFENDER_ID_DISPLAY = :offenderNo
}

GET_LATEST_BOOKING_BY_BOOKING_ID {
  SELECT
    O.OFFENDER_ID_DISPLAY             OFFENDER_NO,
    UPPER(O.TITLE)                    TITLE,
    UPPER(O.SUFFIX)                   SUFFIX,
    UPPER(O.FIRST_NAME)               FIRST_NAME,
    UPPER(CONCAT(O.MIDDLE_NAME,
      CASE WHEN MIDDLE_NAME_2 IS NOT NULL
        THEN CONCAT(' ', O.MIDDLE_NAME_2)
      ELSE '' END))                   MIDDLE_NAMES,
    UPPER(O.LAST_NAME)                LAST_NAME,
    O.BIRTH_DATE                      DATE_OF_BIRTH,
    OB.OFFENDER_BOOK_ID               BOOKING_ID,
    OB.ACTIVE_FLAG                    CURRENTLY_IN_PRISON,
    OB.AGY_LOC_ID                     AGENCY_LOCATION_ID,
    AL.DESCRIPTION                    AGENCY_LOCATION_DESC,
    OB.LIVING_UNIT_ID                 INTERNAL_LOCATION_ID,
    AIL.DESCRIPTION                   INTERNAL_LOCATION_DESC
  FROM OFFENDERS O
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_ID = O.OFFENDER_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = OB.AGY_LOC_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON AIL.INTERNAL_LOCATION_ID = OB.LIVING_UNIT_ID
  WHERE O.OFFENDER_ID_DISPLAY = (SELECT O2.OFFENDER_ID_DISPLAY
                                 FROM OFFENDERS O2
                                   INNER JOIN OFFENDER_BOOKINGS OB2 ON O2.OFFENDER_ID = OB2.OFFENDER_ID
                                 WHERE OB2.OFFENDER_BOOK_ID = :bookingId)
}

GET_LATEST_BOOKING_BY_OFFENDER_NO {
  SELECT
    O.OFFENDER_ID_DISPLAY             OFFENDER_NO,
    UPPER(O.TITLE)                    TITLE,
    UPPER(O.SUFFIX)                   SUFFIX,
    UPPER(O.FIRST_NAME)               FIRST_NAME,
    UPPER(CONCAT(O.MIDDLE_NAME,
      CASE WHEN MIDDLE_NAME_2 IS NOT NULL
        THEN CONCAT(' ', O.MIDDLE_NAME_2)
      ELSE '' END))                   MIDDLE_NAMES,
    UPPER(O.LAST_NAME)                LAST_NAME,
    O.BIRTH_DATE                      DATE_OF_BIRTH,
    OB.OFFENDER_BOOK_ID               BOOKING_ID,
    OB.ACTIVE_FLAG                    CURRENTLY_IN_PRISON,
    OB.AGY_LOC_ID                     AGENCY_LOCATION_ID,
    AL.DESCRIPTION                    AGENCY_LOCATION_DESC,
    OB.LIVING_UNIT_ID                 INTERNAL_LOCATION_ID,
    AIL.DESCRIPTION                   INTERNAL_LOCATION_DESC
  FROM OFFENDERS O
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_ID = O.OFFENDER_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = OB.AGY_LOC_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON AIL.INTERNAL_LOCATION_ID = OB.LIVING_UNIT_ID
  WHERE O.OFFENDER_ID_DISPLAY = :offenderNo
}

FIND_BOOKINGS_BY_PERSON_CONTACT {
  SELECT  OB.OFFENDER_BOOK_ID                            booking_id,
          O.OFFENDER_ID_DISPLAY                          offender_no,
    O.TITLE,
    O.SUFFIX,
    O.FIRST_NAME,
          CONCAT(O.middle_name, CASE WHEN middle_name_2 IS NOT NULL
            THEN concat(' ', O.middle_name_2)
                                ELSE '' END)                MIDDLE_NAMES,
    O.LAST_NAME,
    OB.ACTIVE_FLAG                                 currently_in_prison,
    OB.agy_loc_id                                  agency_location_id,
    AIL.description                                agency_location_desc,
    OB.LIVING_UNIT_ID                              internal_location_id,
    AIL.DESCRIPTION                                internal_location_desc
  FROM OFFENDER_BOOKINGS OB
    JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    JOIN OFFENDER_CONTACT_PERSONS OCP ON OCP.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    JOIN PERSONS P ON P.PERSON_ID = OCP.PERSON_ID
    JOIN PERSON_IDENTIFIERS PI ON PI.PERSON_ID = P.PERSON_ID AND PI.IDENTIFIER_TYPE = :identifierType
                                  AND PI.ID_SEQ = (SELECT MAX(ID_SEQ) FROM PERSON_IDENTIFIERS pi1 where pi1.PERSON_ID = PI.PERSON_ID AND pi1.IDENTIFIER_TYPE = PI.IDENTIFIER_TYPE )
  LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE PI.IDENTIFIER = :identifier
        AND OCP.RELATIONSHIP_TYPE = COALESCE(:relationshipType, OCP.RELATIONSHIP_TYPE)
  AND OB.ACTIVE_FLAG = 'Y'
}

FIND_BOOKINGS_BY_PERSON_ID_CONTACT {
SELECT  OB.OFFENDER_BOOK_ID                            booking_id,
        O.OFFENDER_ID_DISPLAY                          offender_no,
  O.TITLE,
  O.SUFFIX,
  O.FIRST_NAME,
        CONCAT(O.middle_name, CASE WHEN middle_name_2 IS NOT NULL
          THEN concat(' ', O.middle_name_2)
                              ELSE '' END)                MIDDLE_NAMES,
  O.LAST_NAME,
        OB.ACTIVE_FLAG                                 currently_in_prison,
        OB.agy_loc_id                                  agency_location_id,
        AIL.description                                agency_location_desc,
        OB.LIVING_UNIT_ID                              internal_location_id,
        AIL.DESCRIPTION                                internal_location_desc
FROM OFFENDER_BOOKINGS OB
  JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
  JOIN OFFENDER_CONTACT_PERSONS OCP ON OCP.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID AND OCP.PERSON_ID = :personId
  LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
WHERE OCP.RELATIONSHIP_TYPE = COALESCE(:relationshipType, OCP.RELATIONSHIP_TYPE)
      AND OB.ACTIVE_FLAG = 'Y'
}
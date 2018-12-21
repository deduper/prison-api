GET_RECENT_MOVEMENTS {
 SELECT OFFENDERS.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
        OEM.CREATE_DATETIME            AS CREATE_DATE_TIME,
        OEM.FROM_AGY_LOC_ID            AS FROM_AGENCY,
        OEM.TO_AGY_LOC_ID              AS TO_AGENCY,
        OEM.MOVEMENT_TYPE,
        OEM.DIRECTION_CODE
  FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
    INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN OFFENDERS               ON OFFENDERS.OFFENDER_ID = OB.OFFENDER_ID
  WHERE OEM.MOVEMENT_DATE = :movementDate
    AND OEM.CREATE_DATETIME >= :fromDateTime
    AND OEM.MOVEMENT_TYPE IN ('TRN','REL','ADM')
    AND OEM.MOVEMENT_SEQ = (SELECT MAX(OEM2.MOVEMENT_SEQ) FROM OFFENDER_EXTERNAL_MOVEMENTS OEM2
                            WHERE OEM2.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID)
    AND OB.AGY_LOC_ID <> 'ZZGHI'
}

GET_RECENT_MOVEMENTS_BY_OFFENDERS_AND_MOVEMENT_TYPES {
  SELECT OFFENDERS.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
        OEM.CREATE_DATETIME            AS CREATE_DATE_TIME,
        OEM.FROM_AGY_LOC_ID            AS FROM_AGENCY,
        OEM.TO_AGY_LOC_ID              AS TO_AGENCY,
        OEM.MOVEMENT_TIME,
        OEM.MOVEMENT_TYPE,
        OEM.DIRECTION_CODE,
        AL1.DESCRIPTION               AS FROM_AGENCY_DESCRIPTION,
        AL2.DESCRIPTION               AS TO_AGENCY_DESCRIPTION,
        RC1.DESCRIPTION               AS MOVEMENT_TYPE_DESCRIPTION,
        RC2.DESCRIPTION               AS MOVEMENT_REASON
  FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
    INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN OFFENDERS               ON OFFENDERS.OFFENDER_ID = OB.OFFENDER_ID
    LEFT JOIN AGENCY_LOCATIONS AL1 ON OEM.FROM_AGY_LOC_ID = AL1.AGY_LOC_ID
    LEFT JOIN AGENCY_LOCATIONS AL2 ON OEM.TO_AGY_LOC_ID = AL2.AGY_LOC_ID
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OEM.MOVEMENT_TYPE AND RC1.DOMAIN = 'MOVE_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OEM.MOVEMENT_REASON_CODE AND RC2.DOMAIN = 'MOVE_RSN'
  WHERE
    OEM.MOVEMENT_SEQ = (SELECT MAX(OEM2.MOVEMENT_SEQ) FROM OFFENDER_EXTERNAL_MOVEMENTS OEM2
                            WHERE OEM2.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID
                              AND OEM2.MOVEMENT_TYPE IN (:movementTypes))
    AND OB.AGY_LOC_ID <> 'ZZGHI'
    AND OFFENDERS.OFFENDER_ID_DISPLAY in (:offenderNumbers)
        AND OEM.MOVEMENT_TYPE IN (:movementTypes)
}

GET_RECENT_MOVEMENTS_BY_OFFENDERS {
    SELECT OFFENDERS.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
        OEM.CREATE_DATETIME            AS CREATE_DATE_TIME,
        OEM.MOVEMENT_TYPE,
        OEM.MOVEMENT_TIME,
        OEM.FROM_AGY_LOC_ID            AS FROM_AGENCY,
        OEM.TO_AGY_LOC_ID              AS TO_AGENCY,
        OEM.DIRECTION_CODE,
        AL1.DESCRIPTION               AS FROM_AGENCY_DESCRIPTION,
        AL2.DESCRIPTION               AS TO_AGENCY_DESCRIPTION,
        RC1.DESCRIPTION               AS MOVEMENT_TYPE_DESCRIPTION,
        RC2.DESCRIPTION               AS MOVEMENT_REASON
  FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
    INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN OFFENDERS               ON OFFENDERS.OFFENDER_ID = OB.OFFENDER_ID
    LEFT JOIN AGENCY_LOCATIONS AL1 ON OEM.FROM_AGY_LOC_ID = AL1.AGY_LOC_ID
    LEFT JOIN AGENCY_LOCATIONS AL2 ON OEM.TO_AGY_LOC_ID = AL2.AGY_LOC_ID
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OEM.MOVEMENT_TYPE AND RC1.DOMAIN = 'MOVE_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OEM.MOVEMENT_REASON_CODE AND RC2.DOMAIN = 'MOVE_RSN'
    WHERE OEM.MOVEMENT_SEQ = (SELECT MAX(OEM2.MOVEMENT_SEQ) FROM OFFENDER_EXTERNAL_MOVEMENTS OEM2
                            WHERE OEM2.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID)
    AND OB.AGY_LOC_ID <> 'ZZGHI'
    AND OFFENDERS.OFFENDER_ID_DISPLAY in (:offenderNumbers)
}


GET_ROLLCOUNT_MOVEMENTS {
SELECT
       DIRECTION_CODE, MOVEMENT_TYPE,
       FROM_AGY_LOC_ID AS FROM_AGENCY,
       TO_AGY_LOC_ID AS TO_AGENCY,
       OFFENDERS.OFFENDER_ID_DISPLAY  AS OFFENDER_NO
    FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
      INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
      INNER JOIN OFFENDERS               ON OFFENDERS.OFFENDER_ID = OB.OFFENDER_ID
    WHERE MOVEMENT_DATE = :movementDate
}

GET_ENROUTE_OFFENDER_COUNT {
  SELECT count(*)
  FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
         INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
  WHERE
      OEM.MOVEMENT_SEQ = (SELECT MAX(OEM2.MOVEMENT_SEQ) FROM OFFENDER_EXTERNAL_MOVEMENTS OEM2
                          WHERE OEM2.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID
                            AND OEM2.MOVEMENT_TYPE ='TRN')

    AND OB.AGY_LOC_ID = 'TRN'
    AND OB.ACTIVE_FLAG = 'N'
    AND OEM.TO_AGY_LOC_ID = :agencyId
    AND OEM.MOVEMENT_TYPE = 'TRN'
    AND OEM.DIRECTION_CODE ='OUT'
    AND OEM.ACTIVE_FLAG ='Y'
}

GET_ENROUTE_OFFENDER_MOVEMENTS {
  SELECT
    O.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
    OB.OFFENDER_BOOK_ID AS BOOKING_ID,
    O.FIRST_NAME FIRST_NAME,
    CONCAT (O.MIDDLE_NAME, CASE WHEN MIDDLE_NAME_2 IS NOT NULL THEN CONCAT (' ', O.MIDDLE_NAME_2) ELSE '' END) MIDDLE_NAMES,
    O.LAST_NAME LAST_NAME,
    O.BIRTH_DATE DATE_OF_BIRTH,
    OEM.FROM_AGY_LOC_ID            AS FROM_AGENCY,
    OEM.TO_AGY_LOC_ID              AS TO_AGENCY,
    OEM.MOVEMENT_TYPE,
    OEM.DIRECTION_CODE,
    OEM.MOVEMENT_TIME,
    OEM.MOVEMENT_DATE,
    AL1.DESCRIPTION               AS FROM_AGENCY_DESCRIPTION,
    AL2.DESCRIPTION               AS TO_AGENCY_DESCRIPTION,
    RC1.DESCRIPTION               AS MOVEMENT_TYPE_DESCRIPTION,
    OEM.MOVEMENT_REASON_CODE      AS MOVEMENT_REASON,
    RC2.DESCRIPTION               AS MOVEMENT_REASON_DESCRIPTION
  FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
    INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
    INNER JOIN OFFENDERS O              ON O.OFFENDER_ID = OB.OFFENDER_ID
    LEFT JOIN AGENCY_LOCATIONS AL1 ON OEM.FROM_AGY_LOC_ID = AL1.AGY_LOC_ID
    LEFT JOIN AGENCY_LOCATIONS AL2 ON OEM.TO_AGY_LOC_ID = AL2.AGY_LOC_ID
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OEM.MOVEMENT_TYPE AND RC1.DOMAIN = 'MOVE_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OEM.MOVEMENT_REASON_CODE AND RC2.DOMAIN = 'MOVE_RSN'
  WHERE
    OEM.MOVEMENT_SEQ = (SELECT MAX(OEM2.MOVEMENT_SEQ) FROM OFFENDER_EXTERNAL_MOVEMENTS OEM2
                      WHERE OEM2.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID
                        AND OEM2.MOVEMENT_TYPE ='TRN')

    AND OB.AGY_LOC_ID = 'TRN'
    AND OB.ACTIVE_FLAG = 'N'
    AND OEM.TO_AGY_LOC_ID = :agencyId
    AND OEM.MOVEMENT_TYPE = 'TRN'
    AND OEM.DIRECTION_CODE ='OUT'
    AND OEM.ACTIVE_FLAG ='Y'
}

GET_OFFENDER_MOVEMENTS_IN {
SELECT
       O.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
       O.FIRST_NAME AS FIRST_NAME,
       CONCAT (O.MIDDLE_NAME, CASE WHEN MIDDLE_NAME_2 IS NOT NULL THEN CONCAT (' ', O.MIDDLE_NAME_2) ELSE '' END) AS MIDDLE_NAMES,
       O.LAST_NAME AS LAST_NAME,
       O.BIRTH_DATE AS DATE_OF_BIRTH,
       OEM.MOVEMENT_TIME,
       AL.DESCRIPTION AS FROM_AGENCY_DESCRIPTION,
       COALESCE(AIL.USER_DESC, AIL.DESCRIPTION) AS LOCATION
FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
       INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
       INNER JOIN OFFENDERS O              ON O.OFFENDER_ID = OB.OFFENDER_ID
       LEFT OUTER JOIN AGENCY_LOCATIONS AL ON OEM.FROM_AGY_LOC_ID = AL.AGY_LOC_ID
       LEFT OUTER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
WHERE
      OEM.TO_AGY_LOC_ID = :agencyId
  AND OEM.DIRECTION_CODE ='IN'
  AND OEM.ACTIVE_FLAG ='Y'
  AND OEM.MOVEMENT_DATE = :movementDate
}

GET_ROLL_COUNT {
SELECT
  AIL4.INTERNAL_LOCATION_ID                             AS LIVING_UNIT_ID,
  COALESCE(AIL4.USER_DESC, AIL4.INTERNAL_LOCATION_CODE) AS LIVING_UNIT_DESC,
  VR.BEDS_IN_USE,
  VR.CURRENTLY_IN_CELL,
  VR.OUT_OF_LIVING_UNITS,
  VR.CURRENTLY_OUT,
  AIL4.OPERATION_CAPACITY                               AS OPERATIONAL_CAPACITY,
  AIL4.OPERATION_CAPACITY - VR.BEDS_IN_USE              AS NET_VACANCIES,
  AIL4.CAPACITY                                         AS MAXIMUM_CAPACITY,
  AIL4.CAPACITY - VR.BEDS_IN_USE                        AS AVAILABLE_PHYSICAL,
 (SELECT COUNT(1)
   FROM AGENCY_INTERNAL_LOCATIONS AIL2
     INNER JOIN LIVING_UNITS_MV LU2 ON AIL2.INTERNAL_LOCATION_ID = LU2.LIVING_UNIT_ID
   WHERE AIL2.AGY_LOC_ID = VR.AGY_LOC_ID
     AND LU2.ROOT_LIVING_UNIT_ID = AIL4.INTERNAL_LOCATION_ID
     AND SYSDATE BETWEEN DEACTIVATE_DATE AND COALESCE(REACTIVATE_DATE,SYSDATE)) AS OUT_OF_ORDER
FROM
  (SELECT
     LU.AGY_LOC_ID,
     LU.ROOT_LIVING_UNIT_ID,
     SUM(DECODE(OB.LIVING_UNIT_ID, NULL, 0, 1)) AS BEDS_IN_USE,
     SUM(DECODE(OB.AGENCY_IML_ID, NULL, DECODE (OB.IN_OUT_STATUS, 'IN', 1, 0), 0)) AS CURRENTLY_IN_CELL,
     SUM(DECODE(OB.AGENCY_IML_ID, NULL, 0, DECODE (OB.IN_OUT_STATUS, 'IN', 1, 0))) AS OUT_OF_LIVING_UNITS,
     SUM(DECODE(OB.IN_OUT_STATUS, 'OUT', 1, 0)) AS CURRENTLY_OUT
   FROM LIVING_UNITS_MV LU
     LEFT JOIN OFFENDER_BOOKINGS OB ON LU.LIVING_UNIT_ID = OB.LIVING_UNIT_ID AND LU.AGY_LOC_ID = OB.AGY_LOC_ID
   GROUP BY LU.AGY_LOC_ID, LU.ROOT_LIVING_UNIT_ID
  ) VR
  INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL4 ON AIL4.INTERNAL_LOCATION_ID = VR.ROOT_LIVING_UNIT_ID
WHERE AIL4.CERTIFIED_FLAG = :certifiedFlag
  AND AIL4.UNIT_TYPE IS NOT NULL
  AND AIL4.AGY_LOC_ID = :agencyId
  AND AIL4.ACTIVE_FLAG = 'Y'
  AND ((AIL4.PARENT_INTERNAL_LOCATION_ID IS NULL AND :livingUnitId IS NULL) OR AIL4.PARENT_INTERNAL_LOCATION_ID = :livingUnitId)
ORDER BY LIVING_UNIT_DESC
}

GET_OFFENDERS_OUT_TODAY {
SELECT  /*+ index(OEM, OFFENDER_EXT_MOVEMENTS_X01) */
  DIRECTION_CODE,
  MOVEMENT_DATE,
  FROM_AGY_LOC_ID AS FROM_AGENCY,
  OFFENDERS.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
  OFFENDERS.FIRST_NAME,
  OFFENDERS.LAST_NAME,
  OFFENDERS.BIRTH_DATE AS DATE_OF_BIRTH,
  RC2.DESCRIPTION AS MOVEMENT_REASON_DESCRIPTION,
  OEM.MOVEMENT_TIME

FROM OFFENDER_EXTERNAL_MOVEMENTS OEM
       INNER JOIN OFFENDER_BOOKINGS OB    ON OB.OFFENDER_BOOK_ID = OEM.OFFENDER_BOOK_ID AND OB.BOOKING_SEQ = 1
       INNER JOIN OFFENDERS               ON OFFENDERS.OFFENDER_ID = OB.OFFENDER_ID
       LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OEM.MOVEMENT_REASON_CODE AND RC2.DOMAIN = 'MOVE_RSN'
WHERE
      OEM.MOVEMENT_DATE = :movementDate AND
      OEM.DIRECTION_CODE = 'OUT' AND
      OEM.FROM_AGY_LOC_ID = :agencyId
}

GET_OFFENDERS_IN_RECEPTION {
SELECT
  VR.OFFENDER_NO,
  VR.FIRST_NAME,
  VR.LAST_NAME,
  VR.DATE_OF_BIRTH
FROM
  (SELECT
     LU.AGY_LOC_ID,
     LU.ROOT_LIVING_UNIT_ID,
     O.OFFENDER_ID_DISPLAY  AS OFFENDER_NO,
     O.FIRST_NAME AS FIRST_NAME,
     O.LAST_NAME AS LAST_NAME,
     O.BIRTH_DATE AS DATE_OF_BIRTH,
     DECODE(OB.AGENCY_IML_ID, NULL, DECODE (OB.IN_OUT_STATUS, 'IN', 1, 0), 0) AS STATUS_IN
   FROM LIVING_UNITS_MV LU
          INNER JOIN OFFENDER_BOOKINGS OB ON LU.LIVING_UNIT_ID = OB.LIVING_UNIT_ID AND LU.AGY_LOC_ID = OB.AGY_LOC_ID
          INNER JOIN OFFENDERS O ON O.OFFENDER_ID = OB.OFFENDER_ID

  ) VR
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL4 ON AIL4.INTERNAL_LOCATION_ID = VR.ROOT_LIVING_UNIT_ID
WHERE AIL4.CERTIFIED_FLAG = 'N'
  AND AIL4.UNIT_TYPE IS NOT NULL
  AND AIL4.AGY_LOC_ID = :agencyId
  AND STATUS_IN = 1
  AND AIL4.ACTIVE_FLAG = 'Y'
}
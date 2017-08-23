FIND_INMATE_DETAIL {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         (SELECT OI.OFFENDER_IMAGE_ID
          FROM OFFENDER_IMAGES OI
          WHERE OI.ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND OI.OFFENDER_BOOK_ID = B.OFFENDER_BOOK_ID
                AND OI.IMAGE_VIEW_TYPE = 'FACE'
                AND OI.ORIENTATION_TYPE = 'FRONT'
                AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                       FROM OFFENDER_IMAGES
                                       WHERE ACTIVE_FLAG = 'Y'
                                             AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                             AND OFFENDER_BOOK_ID = OI.OFFENDER_BOOK_ID
                                             AND IMAGE_VIEW_TYPE = 'FACE'
                                             AND ORIENTATION_TYPE = 'FRONT')) AS FACE_IMAGE_ID,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
         (SELECT OKW.OFFICER_ID
          FROM OFFENDER_KEY_WORKERS OKW
          WHERE B.OFFENDER_BOOK_ID = OKW.OFFENDER_BOOK_ID
          AND OKW.ACTIVE_FLAG = 'Y' AND (OKW.EXPIRY_DATE is null OR OKW.EXPIRY_DATE >= sysdate)) AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
  AND EXISTS (select 1 from CASELOAD_AGENCY_LOCATIONS C WHERE B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadId))
}

FIND_ALL_INMATES {
      SELECT
        B.OFFENDER_BOOK_ID,
        B.BOOKING_NO,
        O.OFFENDER_ID_DISPLAY,
        B.AGY_LOC_ID,
        O.FIRST_NAME,
        O.MIDDLE_NAME,
        O.LAST_NAME,
        O.BIRTH_DATE,
        TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
        (SELECT WM_CONCAT(DISTINCT(ALERT_TYPE))
         FROM OFFENDER_ALERTS A
         WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID
               AND A.ALERT_STATUS = 'ACTIVE') AS ALERT_TYPES,
        (SELECT WM_CONCAT(concat(AO.LAST_NAME, concat(' ', AO.FIRST_NAME)))
         FROM OFFENDERS AO
         WHERE  AO.ROOT_OFFENDER_ID = B.ROOT_OFFENDER_ID
                AND AO.OFFENDER_ID != B.OFFENDER_ID) AS ALIASES,
        B.LIVING_UNIT_ID,
        AIL.DESCRIPTION AS LIVING_UNIT_DESC,
        (
          SELECT OI.OFFENDER_IMAGE_ID
          FROM OFFENDER_IMAGES OI
          WHERE OI.ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND OI.OFFENDER_BOOK_ID = B.OFFENDER_BOOK_ID
                AND OI.IMAGE_VIEW_TYPE = 'FACE'
                AND OI.ORIENTATION_TYPE = 'FRONT'
                AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                       FROM OFFENDER_IMAGES
                                       WHERE ACTIVE_FLAG = 'Y'
                                             AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                             AND OFFENDER_BOOK_ID = OI.OFFENDER_BOOK_ID
                                             AND IMAGE_VIEW_TYPE = 'FACE'
                                             AND ORIENTATION_TYPE = 'FRONT')
    ) AS FACE_IMAGE_ID,
    NULL AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND EXISTS (select 1 from CASELOAD_AGENCY_LOCATIONS C WHERE B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadId))
}

FIND_INMATES_BY_LOCATION {
  SELECT B.OFFENDER_BOOK_ID,
    B.BOOKING_NO,
    O.OFFENDER_ID_DISPLAY,
    B.AGY_LOC_ID,
    O.FIRST_NAME,
    O.MIDDLE_NAME,
    O.LAST_NAME,
    O.BIRTH_DATE,
    TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
    (SELECT WM_CONCAT(concat(AO.LAST_NAME, concat(' ', AO.FIRST_NAME)))
     FROM OFFENDERS AO
     WHERE  AO.ROOT_OFFENDER_ID = B.ROOT_OFFENDER_ID
            AND AO.OFFENDER_ID != B.OFFENDER_ID) AS ALIASES,
    B.LIVING_UNIT_ID,
    (
      SELECT OI.OFFENDER_IMAGE_ID
      FROM OFFENDER_IMAGES OI
      WHERE OI.ACTIVE_FLAG = 'Y'
            AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
            AND OI.OFFENDER_BOOK_ID = B.OFFENDER_BOOK_ID
            AND OI.IMAGE_VIEW_TYPE = 'FACE'
            AND OI.ORIENTATION_TYPE = 'FRONT'
            AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                   FROM OFFENDER_IMAGES
                                   WHERE ACTIVE_FLAG = 'Y'
                                         AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                         AND OFFENDER_BOOK_ID = OI.OFFENDER_BOOK_ID
                                         AND IMAGE_VIEW_TYPE = 'FACE'
                                         AND ORIENTATION_TYPE = 'FRONT')
    ) AS FACE_IMAGE_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
    LEFT JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  WHERE B.ACTIVE_FLAG = 'Y'
        AND B.LIVING_UNIT_ID IN (
    SELECT INTERNAL_LOCATION_ID
    FROM AGENCY_INTERNAL_LOCATIONS START WITH INTERNAL_LOCATION_ID = :locationId
    CONNECT BY PRIOR INTERNAL_LOCATION_ID = PARENT_INTERNAL_LOCATION_ID
  )

}

FIND_PHYSICAL_CHARACTERISTICS_BY_BOOKING {
  select PT.DESCRIPTION AS CHARACTERISTIC, COALESCE(PC.DESCRIPTION, P.PROFILE_CODE) AS DETAIL,
         (SELECT OI.OFFENDER_IMAGE_ID
          FROM OFFENDER_IMAGES OI
          WHERE OI.ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND OI.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
                AND OI.IMAGE_VIEW_TYPE = P.PROFILE_TYPE
                AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                       FROM OFFENDER_IMAGES
                                       WHERE ACTIVE_FLAG = 'Y'
                                             AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                             AND OFFENDER_BOOK_ID = OI.OFFENDER_BOOK_ID
                                             AND IMAGE_VIEW_TYPE = P.PROFILE_TYPE) ) AS IMAGE_ID
  from OFFENDER_PROFILE_DETAILS P
    JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
    JOIN PROFILE_TYPES PT ON PT.PROFILE_TYPE = P.PROFILE_TYPE AND PROFILE_CATEGORY = 'PA'
    LEFT JOIN PROFILE_CODES PC ON PC.PROFILE_TYPE = PT.PROFILE_TYPE AND PC.PROFILE_CODE = P.PROFILE_CODE
  where P.OFFENDER_BOOK_ID = :bookingId and P.PROFILE_CODE is not null
}

FIND_PHYSICAL_MARKS_BY_BOOKING {
SELECT (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.MARK_TYPE AND DOMAIN='MARK_TYPE') AS TYPE,
       (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.SIDE_CODE AND DOMAIN='SIDE') AS SIDE,
       (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.BODY_PART_CODE AND DOMAIN='BODY_PART') AS BODY_PART,
       (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.PART_ORIENTATION_CODE AND DOMAIN='PART_ORIENT') AS ORENTIATION,
  M.COMMENT_TEXT,
       (SELECT I.OFFENDER_IMAGE_ID
        FROM OFFENDER_IMAGES I
        WHERE B.OFFENDER_BOOK_ID = I.OFFENDER_BOOK_ID
              AND I.ACTIVE_FLAG = 'Y'
              AND M.MARK_TYPE = I.IMAGE_VIEW_TYPE
             AND M.BODY_PART_CODE = I.ORIENTATION_TYPE
       ) AS IMAGE_ID
FROM OFFENDER_IDENTIFYING_MARKS M
  JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = M.OFFENDER_BOOK_ID
WHERE B.OFFENDER_BOOK_ID = :bookingId
      AND B.ACTIVE_FLAG = 'Y'
      AND M.BODY_PART_CODE != 'CONV'
}

FIND_MY_ASSIGNMENTS {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         B.AGY_LOC_ID,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(sysdate, O.BIRTH_DATE)/12) AS AGE,
        (SELECT WM_CONCAT(DISTINCT(ALERT_TYPE))
         FROM OFFENDER_ALERTS A
         WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID
               AND A.ALERT_STATUS = 'ACTIVE') AS ALERT_TYPES,
        (SELECT WM_CONCAT(concat(AO.LAST_NAME, concat(' ', AO.FIRST_NAME)))
         FROM OFFENDERS AO
         WHERE  AO.ROOT_OFFENDER_ID = B.ROOT_OFFENDER_ID
                AND AO.OFFENDER_ID != B.OFFENDER_ID) AS ALIASES,
         B.LIVING_UNIT_ID,
         AIL.DESCRIPTION AS LIVING_UNIT_DESC,
         (SELECT OI.OFFENDER_IMAGE_ID
          FROM OFFENDER_IMAGES OI
          WHERE OI.ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND OI.OFFENDER_BOOK_ID = B.OFFENDER_BOOK_ID
                AND OI.IMAGE_VIEW_TYPE = 'FACE'
                AND OI.ORIENTATION_TYPE = 'FRONT'
                AND CREATE_DATETIME = (SELECT MAX(CREATE_DATETIME)
                                       FROM OFFENDER_IMAGES
                                       WHERE ACTIVE_FLAG = 'Y'
                                             AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                                             AND OFFENDER_BOOK_ID = OI.OFFENDER_BOOK_ID
                                             AND IMAGE_VIEW_TYPE = 'FACE'
                                             AND ORIENTATION_TYPE = 'FRONT')) AS FACE_IMAGE_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID = :caseLoadId
    INNER JOIN OFFENDER_KEY_WORKERS OKW ON OKW.OFFENDER_BOOK_ID = B.OFFENDER_BOOK_ID
      AND OKW.ACTIVE_FLAG = 'Y'
      AND (OKW.EXPIRY_DATE is null OR OKW.EXPIRY_DATE >= sysdate)
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND OKW.OFFICER_ID = :staffId
}

FIND_INMATE_ALIASES {
  SELECT O.LAST_NAME,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.BIRTH_DATE,
         TRUNC(MONTHS_BETWEEN(SYSDATE, O.BIRTH_DATE)/12) AS AGE,
         RCE.DESCRIPTION AS ETHNICITY,
         RCS.DESCRIPTION AS SEX,
         RCNT.DESCRIPTION AS ALIAS_TYPE
  FROM OFFENDERS O
         INNER JOIN OFFENDER_BOOKINGS OB ON O.ROOT_OFFENDER_ID = OB.ROOT_OFFENDER_ID
           AND O.OFFENDER_ID != OB.OFFENDER_ID
         LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE
           AND RCE.DOMAIN = 'ETHNICITY'
         LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE
           AND RCS.DOMAIN = 'SEX'
         LEFT JOIN REFERENCE_CODES RCNT ON O.ALIAS_NAME_TYPE = RCNT.CODE
           AND RCNT.DOMAIN = 'NAME_TYPE'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

FIND_AGENCIES_BY_USERNAME {
    SELECT DISTINCT A.AGY_LOC_ID,
           A.DESCRIPTION,
           A.AGENCY_LOCATION_TYPE
    FROM AGENCY_LOCATIONS A
        INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON A.AGY_LOC_ID = C.AGY_LOC_ID
     WHERE A.ACTIVE_FLAG = 'Y'
       AND A.AGY_LOC_ID NOT IN ('OUT', 'TRN')
       AND C.CASELOAD_ID IN (
           SELECT UCR.CASELOAD_ID
           FROM USER_CASELOAD_ROLES UCR
           WHERE UCR.USERNAME = :username)
}

FIND_PRISON_ADDRESSES_PHONE_NUMBERS {
  SELECT
  al.AGY_LOC_ID agency_id,
  ad.address_type,
  ad.PREMISE,
  ad.STREET,
  ad.LOCALITY,
  city.DESCRIPTION CITY,
  country.DESCRIPTION COUNTRY,
  ad.POSTAL_CODE,
  p.PHONE_TYPE,
  p.PHONE_NO,
  p.EXT_NO
FROM AGENCY_LOCATIONS al LEFT JOIN ADDRESSES ad ON ad.owner_class = 'AGY'
                                                   AND ad.owner_code = al.agy_loc_id
  LEFT JOIN PHONES p ON p.owner_class = 'ADDR'
                        AND p.owner_id = ad.address_id
  LEFT JOIN REFERENCE_CODES city ON city.CODE = ad.CITY_CODE and city.DOMAIN = 'CITY'
  LEFT JOIN REFERENCE_CODES country ON country.CODE = ad.COUNTRY_CODE and country.DOMAIN = 'COUNTRY'
WHERE al.ACTIVE_FLAG = 'Y'
      AND al.AGY_LOC_ID NOT IN ('OUT', 'TRN')
      AND al.AGENCY_LOCATION_TYPE = 'INST'
      AND ad.PRIMARY_FLAG = 'Y'
      AND (:agencyId is NULL OR al.AGY_LOC_ID = :agencyId)
}

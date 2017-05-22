FIND_LOCATIONS_BY_AGENCY_ID {
	 -- Internal Agency Locations (PILOT VERSION)
	 --  This clause is for the pilot only
	-- AND A.INTERNAL_LOCATION_TYPE != 'BLOCK' --  This clause is for the pilot only
	 SELECT A.INTERNAL_LOCATION_ID,
	  		  A.AGY_LOC_ID,
	  		  A.INTERNAL_LOCATION_TYPE,
	  		  A.DESCRIPTION,
	  		  A.PARENT_INTERNAL_LOCATION_ID,
	  		  A.NO_OF_OCCUPANT
	   FROM	AGENCY_INTERNAL_LOCATIONS A JOIN CASELOAD_AGENCY_LOCATIONS C
			 ON A.AGY_LOC_ID = C.AGY_LOC_ID
	  WHERE	A.ACTIVE_FLAG = 'Y'
			    AND A.AGY_LOC_ID = :agencyId
          AND C.CASELOAD_ID = :caseLoadId
}

FIND_ALL_LOCATIONS {
	 -- Internal Agency Locations (PILOT VERSION)
	 SELECT A.INTERNAL_LOCATION_ID,
	  		  A.INTERNAL_LOCATION_TYPE,
	  		  A.DESCRIPTION,
	  		  A.PARENT_INTERNAL_LOCATION_ID,
	  		  A.NO_OF_OCCUPANT
	   FROM	AGENCY_INTERNAL_LOCATIONS A JOIN CASELOAD_AGENCY_LOCATIONS C
					ON A.AGY_LOC_ID = C.AGY_LOC_ID
	  WHERE	A.ACTIVE_FLAG = 'Y'
          AND C.CASELOAD_ID = :caseLoadId
}

FIND_LOCATION {
	 -- Internal Agency Locations (PILOT VERSION)
	 SELECT A.INTERNAL_LOCATION_ID,
	  		  A.INTERNAL_LOCATION_TYPE,
	  		  A.DESCRIPTION,
	  		  A.PARENT_INTERNAL_LOCATION_ID,
	  		  A.NO_OF_OCCUPANT
	   FROM	AGENCY_INTERNAL_LOCATIONS A JOIN CASELOAD_AGENCY_LOCATIONS C
			 ON A.AGY_LOC_ID = C.AGY_LOC_ID
	  WHERE	A.INTERNAL_LOCATION_ID = :locationId
	        AND A.ACTIVE_FLAG = 'Y'
          AND C.CASELOAD_ID = :caseLoadId
}

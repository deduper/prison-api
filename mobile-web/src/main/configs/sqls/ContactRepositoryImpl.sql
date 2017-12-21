FIND_NEXT_OF_KIN {

  SELECT O.OFFENDER_CONTACT_PERSON_ID RELATIONSHIP_ID,
         P.PERSON_ID,
         P.LAST_NAME,
         P.FIRST_NAME,
         P.MIDDLE_NAME,
         O.CONTACT_TYPE,
         RC.DESCRIPTION AS CONTACT_DESCRIPTION,
         O.RELATIONSHIP_TYPE,
         RR.DESCRIPTION AS RELATIONSHIP_DESCRIPTION,
         O.EMERGENCY_CONTACT_FLAG
  FROM OFFENDER_CONTACT_PERSONS O 
    INNER JOIN PERSONS P ON P.PERSON_ID = O.PERSON_ID
    LEFT JOIN REFERENCE_CODES RC ON O.CONTACT_TYPE = RC.CODE and RC.DOMAIN = 'CONTACTS'
    LEFT JOIN REFERENCE_CODES RR ON O.RELATIONSHIP_TYPE = RR.CODE and RR.DOMAIN = 'RELATIONSHIP'
  WHERE O.OFFENDER_BOOK_ID = :bookingId
    AND O.NEXT_OF_KIN_FLAG = 'Y'
    AND O.ACTIVE_FLAG = 'Y'
  ORDER BY O.EMERGENCY_CONTACT_FLAG DESC, P.LAST_NAME ASC
}


RELATIONSHIP_TO_OFFENDER {
  SELECT
    O.OFFENDER_CONTACT_PERSON_ID RELATIONSHIP_ID,
    P.PERSON_ID,
    P.LAST_NAME,
    P.FIRST_NAME,
    P.MIDDLE_NAME,
    O.CONTACT_TYPE,
    RC.DESCRIPTION AS CONTACT_DESCRIPTION,
    O.RELATIONSHIP_TYPE,
    RR.DESCRIPTION AS RELATIONSHIP_DESCRIPTION,
    O.EMERGENCY_CONTACT_FLAG
  FROM OFFENDER_CONTACT_PERSONS O
    INNER JOIN PERSONS P ON P.PERSON_ID = O.PERSON_ID
    LEFT JOIN REFERENCE_CODES RC ON O.CONTACT_TYPE = RC.CODE and RC.DOMAIN = 'CONTACTS'
    LEFT JOIN REFERENCE_CODES RR ON O.RELATIONSHIP_TYPE = RR.CODE and RR.DOMAIN = 'RELATIONSHIP'
  WHERE  O.OFFENDER_BOOK_ID = :bookingId
  AND    O.ACTIVE_FLAG = 'Y'
  AND    (O.RELATIONSHIP_TYPE = :relationshipType OR :relationshipType is null)
}

CREATE_OFFENDER_CONTACT_PERSONS {
  INSERT INTO OFFENDER_CONTACT_PERSONS
    (OFFENDER_CONTACT_PERSON_ID,
     OFFENDER_BOOK_ID,
     PERSON_ID,
     CONTACT_TYPE,
     RELATIONSHIP_TYPE,
     EMERGENCY_CONTACT_FLAG,
     NEXT_OF_KIN_FLAG,
     ACTIVE_FLAG
     ) VALUES
    (OFFENDER_CONTACT_PERSON_ID.NEXTVAL,
     :bookingId,
     :personId,
     :contactType,
     :relationshipType,
     :emergencyContactFlag,
     :nextOfKinFlag,
     :activeFlag)
}

UPDATE_OFFENDER_CONTACT_PERSONS_SAME_REL_TYPE {
  UPDATE OFFENDER_CONTACT_PERSONS
     SET PERSON_ID = :personId
  WHERE OFFENDER_CONTACT_PERSON_ID = :bookingContactPersonId
}

GET_PERSON_BY_ID {
  SELECT PERSON_ID, FIRST_NAME, LAST_NAME
    FROM PERSONS
    WHERE PERSON_ID = :personId
}

GET_PERSON_BY_REF {
  SELECT P.PERSON_ID, P.FIRST_NAME, P.LAST_NAME
  FROM PERSONS P JOIN PERSON_IDENTIFIERS PI
      ON PI.PERSON_ID = P.PERSON_ID AND PI.IDENTIFIER_TYPE = :identifierType
       AND PI.ID_SEQ = (SELECT MAX(ID_SEQ) FROM PERSON_IDENTIFIERS pi1 where pi1.PERSON_ID = PI.PERSON_ID AND pi1.IDENTIFIER_TYPE = PI.IDENTIFIER_TYPE )
  WHERE PI.IDENTIFIER = :identifier
}

CREATE_PERSON {
  INSERT INTO PERSONS (PERSON_ID,LAST_NAME,FIRST_NAME)
  VALUES (PERSON_ID.NEXTVAL,
          :lastName,
          :firstName)
}

UPDATE_PERSON {
  UPDATE PERSONS
  SET LAST_NAME = :lastName,
      FIRST_NAME = :firstName
  WHERE PERSON_ID = :personId
}

CREATE_PERSON_IDENTIFIER {
  INSERT INTO PERSON_IDENTIFIERS (PERSON_ID,ID_SEQ,IDENTIFIER_TYPE,IDENTIFIER)
  VALUES (:personId,
          :seqNo,
          :identifierType,
          :identifier)
}

GET_MAX_IDENTIFIER_SEQ {
  SELECT COALESCE(MAX(ID_SEQ),0) FROM PERSON_IDENTIFIERS
  WHERE PERSON_ID = :personId
  AND IDENTIFIER_TYPE = :identifierType
}

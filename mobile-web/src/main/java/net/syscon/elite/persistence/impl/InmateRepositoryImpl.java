package net.syscon.elite.persistence.impl;

import jersey.repackaged.com.google.common.collect.ImmutableMap;
import net.syscon.elite.persistence.InmateRepository;
import net.syscon.elite.persistence.UserRepository;
import net.syscon.elite.persistence.mapping.FieldMapper;
import net.syscon.elite.persistence.mapping.Row2BeanRowMapper;
import net.syscon.elite.web.api.model.*;
import net.syscon.elite.web.api.resource.BookingResource;
import net.syscon.elite.web.api.resource.LocationsResource;
import net.syscon.util.DateFormatProvider;
import net.syscon.util.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Repository
public class InmateRepositoryImpl extends RepositoryBase implements InmateRepository {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Inject
	private UserRepository userRepository;


	private final Map<String, FieldMapper> assignedInmateMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("OFFENDER_BOOK_ID", 	new FieldMapper("bookingId"))
		.put("BOOKING_NO", 			new FieldMapper("bookingNo"))
		.put("OFFENDER_ID_DISPLAY", new FieldMapper("offenderNo"))
		.put("AGY_LOC_ID", 			new FieldMapper("agencyId"))
		.put("FIRST_NAME", 			new FieldMapper("firstName"))
		.put("MIDDLE_NAME", 		new FieldMapper("middleName"))
		.put("LAST_NAME", 			new FieldMapper("lastName"))
		.put("ALERT_TYPES", 		new FieldMapper("alertsCodes", value -> Arrays.asList(value.toString().split(",")), null))
		.put("LIVING_UNIT_ID", 		new FieldMapper("assignedLivingUnitId"))
		.put("FACE_IMAGE_ID",       new FieldMapper("facialImageId"))
	.build();

	private final Map<String, FieldMapper> inmateDetailsMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("OFFENDER_BOOK_ID", 	new FieldMapper("bookingId"))
		.put("BOOKING_NO", 			new FieldMapper("bookingNo"))
		.put("OFFENDER_ID_DISPLAY", new FieldMapper("offenderNo"))
		.put("AGY_LOC_ID", 			new FieldMapper("agencyId"))
		.put("FIRST_NAME", 			new FieldMapper("firstName"))
		.put("LAST_NAME", 			new FieldMapper("lastName"))
		.put("ALERT_TYPES", 		new FieldMapper("alertsCodes", value -> Arrays.asList(value.toString().split(",")), null))
		.put("LIVING_UNIT_ID", 		new FieldMapper("assignedLivingUnitId"))
		.put("FACE_IMAGE_ID",       new FieldMapper("facialImageId"))
		.put("BIRTH_DATE", 			new FieldMapper("birthDate", value -> DateFormatProvider.get("yyyy-MM-dd").format((Date)value), null))
		.put("AGE",                 new FieldMapper("age"))
		.put("ASSIGNED_OFFEICER_ID",                 new FieldMapper("assignedOfficerUserId"))
	.build();

	private final Map<String, FieldMapper> physicalAttributesMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("SEX_CODE",   new FieldMapper("gender"))
		.put("RACE_CODE",  new FieldMapper("ethnicity"))
		.put("HEIGHT_FT",  new FieldMapper("detail"))
		.put("HEIGHT_IN",  new FieldMapper("heightInches"))
		.put("HEIGHT_CM",  new FieldMapper("heightMeters", value -> ((Number) value).doubleValue() / 100.0, null))
		.put("WEIGHT_LBS", new FieldMapper("weightPounds"))
		.put("WEIGHT_KG",  new FieldMapper("weightKg"))
	.build();

	private final Map<String, FieldMapper> physicalCharacteristicsMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("CHARACTERISTIC", 	new FieldMapper("characteristic"))
		.put("DETAIL",          new FieldMapper("detail"))
		.put("IMAGE_ID", new FieldMapper("imageId"))
	.build();

	final Map<String, FieldMapper> physicalMarkMapping = new ImmutableMap.Builder<String, FieldMapper>()
		.put("COMMENT_TEXT",	new FieldMapper("comment"))
	.build();
	
	final Map<String, FieldMapper> assessmentMapping = new ImmutableMap.Builder<String, FieldMapper>()
			.put("ASSESSMENT_CODE",	new FieldMapper("assessmentCode"))
			.put("ASSESSMENT_DESCRIPTION",	new FieldMapper("assessmentDesc"))
			.put("CLASSIFICATION", 	new FieldMapper("classification"))
			.build();

	final Map<String, FieldMapper> aliasMapping = new ImmutableMap.Builder<String, FieldMapper>()
			.put("LAST_NAME",	new FieldMapper("lastName"))
			.put("FIRST_NAME",	new FieldMapper("firstName"))
			.put("MIDDLE_NAME",	new FieldMapper("middleName"))
			.put("BIRTH_DATE",	new FieldMapper("dob"))
			.put("AGE",			new FieldMapper("age"))
			.put("ETHNICITY",	new FieldMapper("ethinicity"))
			.put("ALIAS_TYPE",	new FieldMapper("nameType"))
			.build();



	@Override
	public List<AssignedInmate> findInmatesByLocation(final Long locationId, String query, String orderByField, LocationsResource.Order order, final int offset, final int limit) {
		final String sql = new QueryBuilder.Builder(getQuery("FIND_INMATES_BY_LOCATION"), assignedInmateMapping).
				addRowCount().
				addQuery(query).
				addOrderBy(order == LocationsResource.Order.asc, orderByField).
				addPagedQuery()
				.build();
		final RowMapper<AssignedInmate> assignedInmateRowMapper = Row2BeanRowMapper.makeMapping(sql, AssignedInmate.class, assignedInmateMapping);
		final List<AssignedInmate> inmates = jdbcTemplate.query(sql, createParams("locationId", locationId, "caseLoadId", getCurrentCaseLoad(), "offset", offset, "limit", limit), assignedInmateRowMapper);
		return inmates;
	}

	@Override
	public List<AssignedInmate> findAllInmates(final String query, final int offset, final int limit, final String orderBy, BookingResource.Order order) {
		final String sql = new QueryBuilder.Builder(getQuery("FIND_ALL_INMATES"), assignedInmateMapping).
				addRowCount().
				addQuery(query).
				addOrderBy(order == BookingResource.Order.asc, orderBy).
				addPagedQuery()
				.build();

		final RowMapper<AssignedInmate> assignedInmateRowMapper = Row2BeanRowMapper.makeMapping(sql, AssignedInmate.class, assignedInmateMapping);
		final List<AssignedInmate> inmates = jdbcTemplate.query(sql, createParams("caseLoadId", getCurrentCaseLoad(), "offset", offset, "limit", limit), assignedInmateRowMapper);
		return inmates;
	}

	private List<PhysicalMark> findPhysicalMarks(final Long bookingId) {
		final String sql = getQuery("FIND_PHYSICAL_MARKS_BY_BOOKING");
		final RowMapper<PhysicalMark> physicalMarkRowMapper = Row2BeanRowMapper.makeMapping(sql, PhysicalMark.class, physicalMarkMapping);
		final List<PhysicalMark> physicalMarks = jdbcTemplate.query(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), physicalMarkRowMapper);
		return physicalMarks;
	}

	private List<PhysicalCharacteristic> findPhysicalCharacteristics(final Long bookingId) {
		final String sql = getQuery("FIND_PHYSICAL_CHARACTERISTICS_BY_BOOKING");
		final RowMapper<PhysicalCharacteristic> physicalCharacteristicsRowMapper = Row2BeanRowMapper.makeMapping(sql, PhysicalCharacteristic.class, physicalCharacteristicsMapping);
		final List<PhysicalCharacteristic> physicalCharacteristics = jdbcTemplate.query(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), physicalCharacteristicsRowMapper);
		return physicalCharacteristics;
	}

	private PhysicalAttributes findPhysicalAttributes(final Long bookingId) {
		final String sql = getQuery("FIND_PHYSICAL_ATTRIBUTES_BY_BOOKING");
		final RowMapper<PhysicalAttributes> physicalAttributesRowMapper = Row2BeanRowMapper.makeMapping(sql, PhysicalAttributes.class, physicalAttributesMapping);
		final PhysicalAttributes physicalAttributes = jdbcTemplate.queryForObject(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), physicalAttributesRowMapper);
		return physicalAttributes;
	}
	
	private List<Assessment> findAssessments(final long bookingId) {
		final String sql = getQuery("FIND_ACTIVE_APPROVED_ASSESSMENT");
		final RowMapper<Assessment> assessmentAttributesRowMapper = Row2BeanRowMapper.makeMapping(sql, Assessment.class, assessmentMapping);
		final List<Assessment> assessments = jdbcTemplate.query(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), assessmentAttributesRowMapper);
		return assessments;
	}


	@Override
	public InmateDetails findInmate(final Long bookingId) {
		final String sql = getQuery("FIND_INMATE_DETAIL");
		try {
			final RowMapper<InmateDetails> inmateDetailRowMapper = Row2BeanRowMapper.makeMapping(sql, InmateDetails.class, inmateDetailsMapping);
			final InmateDetails inmate = jdbcTemplate.queryForObject(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), inmateDetailRowMapper);
			if (inmate != null) {
				inmate.setPhysicalAttributes(findPhysicalAttributes(inmate.getBookingId()));
				inmate.setPhysicalCharacteristics(this.findPhysicalCharacteristics(inmate.getBookingId()));
				inmate.setPhysicalMarks(this.findPhysicalMarks(inmate.getBookingId()));
				inmate.setAssessments(findAssessments(inmate.getBookingId()));
			}
			return inmate;
		} catch (final EmptyResultDataAccessException ex) {
			log.error(ex.getMessage(), ex);
			throw ex;
		}
	}
	@Override
	public List<Alias> findInmateAliases(final long bookingId, String orderByField, BookingResource.Order order, final int offset, final int limit) {
		final String sql = new QueryBuilder.Builder(getQuery("FIND_INMATE_ALIASES"), aliasMapping)
											.addOrderBy("asc".equals(order.toString())?true:false, (null==orderByField || "".equals("orderByField"))?"firstName":orderByField)
											.build();
		final RowMapper<Alias> aliasAttributesRowMapper = Row2BeanRowMapper.makeMapping(sql, Alias.class, aliasMapping);
		final List<Alias> aliases = jdbcTemplate.query(sql, createParams("bookingId", bookingId, "caseLoadId", getCurrentCaseLoad()), aliasAttributesRowMapper);
		return aliases;
	}

}



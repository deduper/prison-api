package net.syscon.elite.service.impl;

import net.syscon.elite.persistence.repository.AgencyRepository;
import net.syscon.elite.persistence.repository.LocationRepository;
import net.syscon.elite.service.AgencyLocationService;
import net.syscon.elite.web.api.model.Agency;
import net.syscon.elite.web.api.model.Location;

import javax.inject.Inject;
import javax.transaction.Transactional;
import java.util.List;


@Transactional
public class AgencyLocationServiceImpl implements AgencyLocationService {

	private AgencyRepository agencyRepository;
	private LocationRepository locationRepository;

	@Inject
	public void setAgencyRepository(final AgencyRepository agencyRepository) { this.agencyRepository = agencyRepository; }

	@Inject
	public void setLocationRepository(final LocationRepository locationRepository) { this.locationRepository = locationRepository;}


	@Override
	public Agency getAgency(String agencyId) {

		return null;
	}

	@Override
	public List<Agency> getAgencies(final int offset, final int limit) {
		return agencyRepository.findAll(offset, limit);
	}

	@Override
	public List<Location> getLocationsFromAgency(String agencyId, int offset, int limit) {
		return locationRepository.findLocationsByAgencyId(agencyId, offset, limit);
	}


}

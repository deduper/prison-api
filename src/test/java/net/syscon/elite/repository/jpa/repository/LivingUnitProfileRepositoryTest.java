package net.syscon.elite.repository.jpa.repository;

import net.syscon.elite.repository.jpa.model.HousingAttributeReferenceCode;
import net.syscon.elite.repository.jpa.model.LivingUnitProfile;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@DataJpaTest
@ActiveProfiles("test")
@RunWith(SpringRunner.class)
@AutoConfigureTestDatabase(replace = NONE)
public class LivingUnitProfileRepositoryTest {

    @Autowired
    private LivingUnitProfileRepository repository;

    @Test
    public void findAllByLivingUnitAndAgencyIdAndDescription() {
        final var expected = List.of(
                                LivingUnitProfile.builder()
                                    .livingUnitId(-1L)
                                    .agencyLocationId("LEI")
                                    .description("LEI-1-1-01")
                                    .profileId(-1L)
                                    .housingAttributeReferenceCode(new HousingAttributeReferenceCode("DO", "Double Occupancy"))
                                    .build(),
                                LivingUnitProfile.builder()
                                    .livingUnitId(-1L)
                                    .agencyLocationId("LEI")
                                    .description("LEI-1-1-01")
                                    .profileId(-2L)
                                    .housingAttributeReferenceCode(new HousingAttributeReferenceCode("LC", "Listener Cell"))
                                    .build());

        final var profiles = repository.findAllByLivingUnitIdAndAgencyLocationIdAndDescription(-1L, "LEI", "LEI-1-1-01");

        assertThat(profiles).isEqualTo(expected);
    }

}

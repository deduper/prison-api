package net.syscon.elite.repository;

import net.syscon.elite.api.model.ReferenceCode;
import net.syscon.elite.api.model.ReferenceDomain;
import net.syscon.elite.api.support.Order;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.web.config.CacheConfig;
import net.syscon.elite.web.config.PersistenceConfigs;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@ActiveProfiles("nomis-hsqldb")
@RunWith(SpringRunner.class)
@Transactional(propagation = Propagation.NOT_SUPPORTED)
@JdbcTest
@AutoConfigureTestDatabase(replace = NONE)
@ContextConfiguration(classes = { PersistenceConfigs.class, CacheConfig.class })
public class ReferenceCodeRepositoryTest {

    @Autowired
    private ReferenceCodeRepository repository;

    @Test
    public void testGetReferenceDomainExists() {
        Optional<ReferenceDomain> refDomain =
                repository.getReferenceDomain("NOTE_SOURCE");

        assertThat(refDomain.isPresent()).isTrue();
        assertThat(refDomain.get().getDomain()).isEqualTo("NOTE_SOURCE");
        assertThat(refDomain.get().getDescription()).isEqualTo("Case Note Sources");
    }

    @Test
    public void testGetReferenceDomainNotExists() {
        Optional<ReferenceDomain> refDomain =
                repository.getReferenceDomain("UNKNOWN");

        assertThat(refDomain.isPresent()).isFalse();
    }

    @Test
    public void testGetReferenceCodeByDomainAndCodeWithSubCodes() {
        Optional<ReferenceCode> refCode =
                repository.getReferenceCodeByDomainAndCode("ALERT", "A", true);

        assertThat(refCode.isPresent()).isTrue();
        assertThat(refCode.get().getSubCodes()).isNotNull();
        assertThat(refCode.get().getSubCodes()).isNotEmpty();
    }

    @Test
    public void testGetReferenceCodeByDomainAndCodeWithoutSubCodes() {
        Optional<ReferenceCode> refCode =
                repository.getReferenceCodeByDomainAndCode("ALERT", "A", false);

        assertThat(refCode.isPresent()).isTrue();
        assertThat(refCode.get().getSubCodes()).isNull();
    }

    // Tests (without retrieval of sub-codes) ordering by code (ascending) and 0-10 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithoutSubCodes1() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", false,"code", Order.ASC, 0, 10);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(10);
        assertThat(refCodes.getTotalRecords()).isEqualTo(58);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(10);

        // Verify sorting
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("COMMS");

        // Verify no sub-codes returned
        refCodes.getItems().forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has no sub-codes", rc.getCode()).isNullOrEmpty();
        });
    }

    // Tests (without retrieval of sub-codes) ordering by code (descending) and 15-30 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithoutSubCodes2() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", false,"code", Order.DESC, 15, 15);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(15);
        assertThat(refCodes.getTotalRecords()).isEqualTo(58);
        assertThat(refCodes.getPageOffset()).isEqualTo(15);
        assertThat(refCodes.getPageLimit()).isEqualTo(15);

        // Verify sorting
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("REQUIREMENT");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("PA");
        assertThat(refCodes.getItems().get(14).getCode()).isEqualTo("MIGRATION");

        // Verify no sub-codes returned
        refCodes.getItems().forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has no sub-codes", rc.getCode()).isNullOrEmpty();
        });
    }

    // Tests (with retrieval of sub-codes) ordering by code (ascending) and 0-10 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithSubCodes1() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", true,"code", Order.ASC, 0, 10);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(10);
        assertThat(refCodes.getTotalRecords()).isEqualTo(47);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(10);

        // Verify sorting of codes
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("CRT");

        // Verify sub-codes returned for all items
        verifySubCodesPresent(refCodes.getItems());

        // Verify quantity of sub-codes returned
        assertThat(refCodes.getItems().get(0).getSubCodes().size()).isEqualTo(22);
        assertThat(refCodes.getItems().get(8).getSubCodes().size()).isEqualTo(2);
        assertThat(refCodes.getItems().get(9).getSubCodes().size()).isEqualTo(15);

        // Verify sorting of sub-codes
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getCode()).isEqualTo("CPS");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(21).getCode()).isEqualTo("SOU");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getCode()).isEqualTo("APP");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(14).getCode()).isEqualTo("TRA");

        // Verify correct sub-code relationship to parent code
        verifySubCodeParentCodeRelationship(refCodes.getItems());
    }

    // Tests (with retrieval of sub-codes) ordering by code (descending) and 15-30 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithSubCodes2() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", true,"code", Order.DESC, 15, 16);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(16);
        assertThat(refCodes.getTotalRecords()).isEqualTo(47);
        assertThat(refCodes.getPageOffset()).isEqualTo(15);
        assertThat(refCodes.getPageLimit()).isEqualTo(16);

        // Verify sorting of codes
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("REC");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("MIGRATION");
        assertThat(refCodes.getItems().get(15).getCode()).isEqualTo("FILEINSP");

        // Verify sub-codes returned or not
        verifySubCodesPresent(refCodes.getItems());

        // Verify quantity of sub-codes returned
        assertThat(refCodes.getItems().get(0).getSubCodes().size()).isEqualTo(9);
        assertThat(refCodes.getItems().get(9).getSubCodes().size()).isEqualTo(1);
        assertThat(refCodes.getItems().get(15).getSubCodes().size()).isEqualTo(3);

        // Verify sorting of sub-codes
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getCode()).isEqualTo("RI");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(8).getCode()).isEqualTo("APPRECALL");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getCode()).isEqualTo("MISC");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(0).getCode()).isEqualTo("BYSPO");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(2).getCode()).isEqualTo("BYACO");

        // Verify correct sub-code relationship to parent code
        verifySubCodeParentCodeRelationship(refCodes.getItems());
    }

    // Tests (without retrieval of sub-codes) ordering by code (ascending) and 0-1000 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithoutSubCodes3() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", false,"code", Order.ASC, 0, 1000);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(58);
        assertThat(refCodes.getTotalRecords()).isEqualTo(58);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(1000);

        // Verify sorting
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("COMMS");
        assertThat(refCodes.getItems().get(57).getCode()).isEqualTo("VLU");

        // Verify no sub-codes returned
        refCodes.getItems().forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has no sub-codes", rc.getCode()).isNullOrEmpty();
        });
    }

    // Tests (with retrieval of sub-codes) ordering by code (ascending) and 0-1000 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithSubCodes3() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", true,"code", Order.ASC, 0, 1000);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(47);
        assertThat(refCodes.getTotalRecords()).isEqualTo(47);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(1000);

        // Verify sorting of codes
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("CRT");
        assertThat(refCodes.getItems().get(46).getCode()).isEqualTo("VICTIM");

        // Verify sub-codes returned or not
        verifySubCodesPresent(refCodes.getItems());

        // Verify quantity of sub-codes returned
        assertThat(refCodes.getItems().get(0).getSubCodes().size()).isEqualTo(22);
        assertThat(refCodes.getItems().get(9).getSubCodes().size()).isEqualTo(15);
        assertThat(refCodes.getItems().get(45).getSubCodes().size()).isEqualTo(2);

        // Verify sorting of sub-codes
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getCode()).isEqualTo("CPS");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(21).getCode()).isEqualTo("SOU");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getCode()).isEqualTo("APP");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(14).getCode()).isEqualTo("TRA");
        assertThat(refCodes.getItems().get(46).getSubCodes().get(0).getCode()).isEqualTo("INFO_COMPLET");
        assertThat(refCodes.getItems().get(46).getSubCodes().get(1).getCode()).isEqualTo("INFO_UPDATE");

        // Verify correct sub-code relationship to parent code
        verifySubCodeParentCodeRelationship(refCodes.getItems());
    }

    // Tests (without retrieval of sub-codes) ordering by description (ascending) and 0-10 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithoutSubCodes4() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", false,"description", Order.ASC, 0, 10);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(10);
        assertThat(refCodes.getTotalRecords()).isEqualTo(58);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(10);

        // Verify sorting
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(0).getDescription()).isEqualTo("Accredited Programme");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("CHAP");
        assertThat(refCodes.getItems().get(9).getDescription()).isEqualTo("Chaplaincy");

        // Verify no sub-codes returned
        refCodes.getItems().forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has no sub-codes", rc.getCode()).isNullOrEmpty();
        });
    }

    // Tests (without retrieval of sub-codes) ordering by description (descending) and 15-30 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithoutSubCodes5() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", false,"description", Order.DESC, 15, 15);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(15);
        assertThat(refCodes.getTotalRecords()).isEqualTo(58);
        assertThat(refCodes.getPageOffset()).isEqualTo(15);
        assertThat(refCodes.getPageLimit()).isEqualTo(15);

        // Verify sorting
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("RR");
        assertThat(refCodes.getItems().get(0).getDescription()).isEqualTo("Release Report");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("OM");
        assertThat(refCodes.getItems().get(9).getDescription()).isEqualTo("Offender Management");
        assertThat(refCodes.getItems().get(14).getCode()).isEqualTo("MHT");
        assertThat(refCodes.getItems().get(14).getDescription()).isEqualTo("Mental Health Treatment Requirement");

        // Verify no sub-codes returned
        refCodes.getItems().forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has no sub-codes", rc.getCode()).isNullOrEmpty();
        });
    }

    // Tests (with retrieval of sub-codes) ordering by description (ascending) and 0-10 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithSubCodes4() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", true,"description", Order.ASC, 0, 10);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(10);
        assertThat(refCodes.getTotalRecords()).isEqualTo(47);
        assertThat(refCodes.getPageOffset()).isEqualTo(0);
        assertThat(refCodes.getPageLimit()).isEqualTo(10);

        // Verify sorting of codes
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("ACP");
        assertThat(refCodes.getItems().get(0).getDescription()).isEqualTo("Accredited Programme");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("COMMS");
        assertThat(refCodes.getItems().get(9).getDescription()).isEqualTo("Communication");

        // Verify sub-codes returned or not
        verifySubCodesPresent(refCodes.getItems());

        // Verify quantity of sub-codes returned
        assertThat(refCodes.getItems().get(0).getSubCodes().size()).isEqualTo(22);
        assertThat(refCodes.getItems().get(9).getSubCodes().size()).isEqualTo(2);

        // Verify sorting of sub-codes
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getCode()).isEqualTo("CPS");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getDescription()).isEqualTo("Core Programme Session");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(21).getCode()).isEqualTo("SOU");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(21).getDescription()).isEqualTo("Statement Of Understanding Signed");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getCode()).isEqualTo("COM_IN");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getDescription()).isEqualTo("Communication IN");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(1).getCode()).isEqualTo("COM_OUT");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(1).getDescription()).isEqualTo("Communication OUT");

        // Verify correct sub-code relationship to parent code
        verifySubCodeParentCodeRelationship(refCodes.getItems());
    }

    @Test
    public void testScheduleReasons() {
        List<ReferenceCode> scheduleReasons = repository.getScheduleReasons("APP");

        assertThat(scheduleReasons.size()).isEqualTo(6);
        ReferenceCode referenceCode = scheduleReasons.get(2);
        assertThat(referenceCode.getCode()).isEqualTo("EDUC");
        assertThat(referenceCode.getDescription()).isEqualTo("Computers");
    }

    // Tests (with retrieval of sub-codes) ordering by description (descending) and 15-30 pagination.
    @Test
    public void testGetReferenceCodesByDomainWithSubCodes6() {
        Page<ReferenceCode> refCodes =
                repository.getReferenceCodesByDomain("TASK_TYPE", true,"description", Order.DESC, 15, 16);

        assertThat(refCodes).isNotNull();
        assertThat(refCodes.getItems()).isNotNull();
        assertThat(refCodes.getItems()).isNotEmpty();
        assertThat(refCodes.getItems().size()).isEqualTo(16);
        assertThat(refCodes.getTotalRecords()).isEqualTo(47);
        assertThat(refCodes.getPageOffset()).isEqualTo(15);
        assertThat(refCodes.getPageLimit()).isEqualTo(16);

        // Verify sorting of codes
        assertThat(refCodes.getItems().get(0).getCode()).isEqualTo("PRISON");
        assertThat(refCodes.getItems().get(0).getDescription()).isEqualTo("Prison");
        assertThat(refCodes.getItems().get(9).getCode()).isEqualTo("MHT");
        assertThat(refCodes.getItems().get(9).getDescription()).isEqualTo("Mental Health Treatment Requirement");
        assertThat(refCodes.getItems().get(15).getCode()).isEqualTo("FARES");
        assertThat(refCodes.getItems().get(15).getDescription()).isEqualTo("Fares");

        // Verify sub-codes returned or not
        verifySubCodesPresent(refCodes.getItems());

        // Verify quantity of sub-codes returned
        assertThat(refCodes.getItems().get(0).getSubCodes().size()).isEqualTo(1);
        assertThat(refCodes.getItems().get(9).getSubCodes().size()).isEqualTo(3);
        assertThat(refCodes.getItems().get(15).getSubCodes().size()).isEqualTo(2);

        // Verify sorting of sub-codes
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getCode()).isEqualTo("RELEASE");
        assertThat(refCodes.getItems().get(0).getSubCodes().get(0).getDescription()).isEqualTo("Release");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getCode()).isEqualTo("MHTRTO");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(0).getDescription()).isEqualTo("Report to Office");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(2).getCode()).isEqualTo("MHTIATP");
        assertThat(refCodes.getItems().get(9).getSubCodes().get(2).getDescription()).isEqualTo("Initial Appointment w.Treatment Provider");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(0).getCode()).isEqualTo("TOBEPAID");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(0).getDescription()).isEqualTo("To Be Paid");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(1).getCode()).isEqualTo("NOTPAID");
        assertThat(refCodes.getItems().get(15).getSubCodes().get(1).getDescription()).isEqualTo("Not To Be Paid");

        // Verify correct sub-code relationship to parent code
        verifySubCodeParentCodeRelationship(refCodes.getItems());
    }

    private void verifySubCodesPresent(List<ReferenceCode> refCodes) {
        refCodes.forEach(rc -> {
            assertThat(rc.getSubCodes()).as("Check code [%s] has sub-codes", rc.getCode()).isNotEmpty();
        });
    }

    private void verifySubCodeParentCodeRelationship(List<ReferenceCode> refCodes) {
        refCodes.forEach(rc -> {
            if (Objects.nonNull(rc.getSubCodes())) {
                rc.getSubCodes().forEach(sc -> {
                    assertThat(sc.getParentDomain())
                            .as("Check sub-code [%s] parent domain against code [%s] domain", sc.getCode(), rc.getCode())
                            .isEqualTo(rc.getDomain());

                    assertThat(sc.getParentCode())
                            .as("Check sub-code [%s] parent code against code [%s] code", sc.getCode(), rc.getCode())
                            .isEqualTo(rc.getCode());
                });
            }
        });
    }
}

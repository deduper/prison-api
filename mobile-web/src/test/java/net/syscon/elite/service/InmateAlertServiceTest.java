package net.syscon.elite.service;

import net.syscon.elite.persistence.InmateAlertRepository;
import net.syscon.elite.service.impl.InmateAlertServiceImpl;
import net.syscon.elite.v2.api.model.Alert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.runners.MockitoJUnitRunner;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import static java.lang.String.format;
import static net.syscon.elite.v2.api.support.Order.ASC;
import static org.assertj.core.api.Java6Assertions.assertThat;
import static org.mockito.Matchers.eq;

@RunWith(MockitoJUnitRunner.class)
public class InmateAlertServiceTest {

    @Mock
    private InmateAlertRepository inmateAlertRepository;

    @InjectMocks
    private InmatesAlertService serviceToTest = new InmateAlertServiceImpl();

    @Test
    public void testCorrectNumberAlertReturned() {
        List<Alert> alerts = createAlerts();
        Mockito.when(inmateAlertRepository.getInmateAlert(eq(-1L), eq(""), eq("alertCode"), eq(ASC), eq(0), eq(10))
        ).thenReturn(alerts);
        final List<Alert> returnedAlerts = serviceToTest.getInmateAlerts(-1L, "", "alertCode", ASC, 0, 10);
        assertThat(returnedAlerts).hasSize(alerts.size());
    }

    @Test
    public void testCorrectExpiredAlerts() {
        List<Alert> alerts = createAlerts();
        Mockito.when(inmateAlertRepository.getInmateAlert(eq(-1L), eq(""), eq("alertCode"), eq(ASC), eq(0), eq(10))
        ).thenReturn(alerts);
        final List<Alert> returnedAlerts = serviceToTest.getInmateAlerts(-1L, "", "alertCode", ASC, 0, 10);
        assertThat(returnedAlerts).extracting("expired").containsSequence(false, false, true, true, false);
    }

    private List<Alert> createAlerts() {
        LocalDateTime now = LocalDateTime.now();

        return Arrays.asList(
                buildAlert(-1L, now.minusMonths(1), now.plusDays(2)),
                buildAlert(-2L, now.minusMonths(2), now.plusDays(1)),
                buildAlert(-3L, now.minusMonths(3), now),
                buildAlert(-4L, now.minusMonths(4), now.minusDays(1)),
                buildAlert(-5L, now.minusMonths(5), null)
            );
    }

    private Alert buildAlert(long id, LocalDateTime dateCreated, LocalDateTime dateExpires) {
        return Alert.builder()
                .alertId(id)
                .alertType(format("ALERTYPE%d", id))
                .alertCode(format("ALERTCODE%d", id))
                .comment(format("This is a comment %d", id))
                .dateCreated(dateCreated)
                .dateExpires(dateExpires)
                .build();
    }

}

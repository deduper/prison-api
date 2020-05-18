package uk.gov.justice.hmpps.nomis.datacompliance.events.listeners;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.stereotype.Service;
import uk.gov.justice.hmpps.nomis.datacompliance.events.listeners.dto.DataDuplicateCheck;
import uk.gov.justice.hmpps.nomis.datacompliance.events.listeners.dto.OffenderDeletionGranted;
import uk.gov.justice.hmpps.nomis.datacompliance.service.DataDuplicateService;
import uk.gov.justice.hmpps.nomis.datacompliance.service.OffenderDeletionService;

import java.io.IOException;
import java.util.Map;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.base.Preconditions.checkState;
import static org.apache.commons.lang3.ObjectUtils.isNotEmpty;

@Slf4j
@Service
@ConditionalOnExpression("{'aws', 'localstack'}.contains('${data.compliance.request.sqs.provider}')")
public class DataComplianceEventListener {

    private static final String OFFENDER_DELETION_GRANTED = "DATA_COMPLIANCE_OFFENDER-DELETION-GRANTED";
    private static final String DATA_DUPLICATE_CHECK = "DATA_COMPLIANCE_DATA-DUPLICATE-CHECK";

    private final Map<String, MessageHandler> messageHandlers = Map.of(
            OFFENDER_DELETION_GRANTED, this::handleDeletionGranted,
            DATA_DUPLICATE_CHECK, this::handleDataDuplicateCheck);

    private final DataDuplicateService dataDuplicateService;
    private final OffenderDeletionService offenderDeletionService;
    private final ObjectMapper objectMapper;

    public DataComplianceEventListener(final DataDuplicateService dataDuplicateService,
                                       final OffenderDeletionService offenderDeletionService,
                                       final ObjectMapper objectMapper) {

        log.info("Configured to listen to data compliance events");

        this.dataDuplicateService = dataDuplicateService;
        this.offenderDeletionService = offenderDeletionService;
        this.objectMapper = objectMapper;
    }

    @JmsListener(destination = "${data.compliance.request.sqs.queue.name}")
    public void handleEvent(final Message<String> message) {

        final var eventType = getEventType(message.getHeaders());

        log.debug("Handling incoming data compliance event of type: {}", eventType);

        messageHandlers.get(eventType).handle(message);
    }

    private String getEventType(final MessageHeaders messageHeaders) {

        final var eventType = messageHeaders.get("eventType", String.class);

        checkNotNull(eventType, "Message event type not found");
        checkState(messageHandlers.containsKey(eventType),
                "Unexpected message event type: '%s', expecting one of: %s", eventType, messageHandlers.keySet());

        return eventType;
    }

    private void handleDeletionGranted(final Message<String> message) {
        final var event = parseEvent(message.getPayload(), OffenderDeletionGranted.class);

        checkState(isNotEmpty(event.getOffenderIdDisplay()), "No offender specified in request: %s", message.getPayload());
        checkNotNull(event.getReferralId(), "No referral ID specified in request: %s", message.getPayload());

        offenderDeletionService.deleteOffender(event.getOffenderIdDisplay(), event.getReferralId());
    }

    private void handleDataDuplicateCheck(final Message<String> message) {
        final var event = parseEvent(message.getPayload(), DataDuplicateCheck.class);

        checkState(isNotEmpty(event.getOffenderIdDisplay()), "No offender specified in request: %s", message.getPayload());
        checkNotNull(event.getRetentionCheckId(), "No retention check ID specified in request: %s", message.getPayload());

        dataDuplicateService.checkForDataDuplicates(event.getOffenderIdDisplay(), event.getRetentionCheckId());
    }

    private <T> T parseEvent(final String requestJson, final Class<T> eventType) {
        try {
            return objectMapper.readValue(requestJson, eventType);
        } catch (final IOException e) {
            throw new RuntimeException("Failed to parse request: " + requestJson, e);
        }
    }

    @FunctionalInterface
    private interface MessageHandler {
        void handle(Message<String> message);
    }
}

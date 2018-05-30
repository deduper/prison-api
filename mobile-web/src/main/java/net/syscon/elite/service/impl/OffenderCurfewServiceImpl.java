package net.syscon.elite.service.impl;

import net.syscon.elite.api.model.OffenderSentenceDetail;
import net.syscon.elite.api.model.SentenceDetail;
import net.syscon.elite.repository.OffenderCurfewRepository;
import net.syscon.elite.service.BookingService;
import net.syscon.elite.service.OffenderCurfewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.time.Clock;
import java.time.LocalDate;
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@Validated
public class OffenderCurfewServiceImpl implements OffenderCurfewService {

    private static final int DAYS_TO_ADD = 27;

    private static final  Comparator<LocalDate> NULL_SAFE_LOCAL_DATE_COMPARATOR = Comparator.nullsLast(Comparator.naturalOrder());
    private static final Comparator<OffenderSentenceDetail> HDCED_COMPARATOR = Comparator.comparing(
                    osd -> osd.getSentenceDetail().getHomeDetentionCurfewEligibilityDate(),
                    NULL_SAFE_LOCAL_DATE_COMPARATOR);

    private final OffenderCurfewRepository offenderCurfewRepository;
    private final BookingService bookingService;
    private final Clock clock;

    public OffenderCurfewServiceImpl(
            OffenderCurfewRepository offenderCurfewRepository,
            BookingService bookingService,
            Clock clock) {
        this.offenderCurfewRepository = offenderCurfewRepository;
        this.bookingService = bookingService;
        this.clock = clock;
    }

    @Override
    public List<OffenderSentenceDetail> getHomeDetentionCurfewCandidates(String agencyId, String username) {

        return bookingService.getOffenderSentencesSummary(agencyId, username, Collections.emptyList())
                .stream()
                .sorted(HDCED_COMPARATOR)
                .filter(offenderEligibleForHomeCurfew(agencyId, username))
                .collect(Collectors.toList());
    }

    private Predicate<OffenderSentenceDetail> offenderEligibleForHomeCurfew(String agencyId, String username) {

        Set<Long> bookingIdsForOffendersWithoutCurfewApprovalStatus = findOffendersWithoutCurfewApprovalStatus(agencyId, username);

        final LocalDate twentySevenDaysAfterToday = LocalDate.now(clock).plusDays(DAYS_TO_ADD);

        return os -> offenderIsEligibleForHomeCurfew(os, bookingIdsForOffendersWithoutCurfewApprovalStatus, twentySevenDaysAfterToday);
    }

    private static boolean offenderIsEligibleForHomeCurfew(OffenderSentenceDetail os,
                                                           Set<Long> offendersWithoutCurfewApprovalStatus,
                                                           LocalDate earliestDateForArdOrCrd) {

        final SentenceDetail sentenceDetail = os.getSentenceDetail();

        return
            (sentenceDetail.getHomeDetentionCurfewEligibilityDate() != null) &&
            (
                isBefore(earliestDateForArdOrCrd, sentenceDetail.getAutomaticReleaseDate()) ||
                isBefore(earliestDateForArdOrCrd, sentenceDetail.getConfirmedReleaseDate()) ||
                offendersWithoutCurfewApprovalStatus.contains(os.getBookingId())
            );
    }

    private static boolean isBefore(LocalDate d1, LocalDate d2) {
        return d2 != null && d1.isBefore(d2);
    }

    private Set<Long> findOffendersWithoutCurfewApprovalStatus(String agencyId, String username) {
        final String query = bookingService.buildAgencyQuery(agencyId, username);
        return new HashSet<>(offenderCurfewRepository.offendersWithoutCurfewApprovalStatus(query));
    }
}

package uk.gov.justice.hmpps.nomis.datacompliance.repository.jpa.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import uk.gov.justice.hmpps.nomis.datacompliance.repository.jpa.model.OffenderWithImage;

import java.time.LocalDateTime;

@Repository
public interface OffenderImageUpdateRepository extends PagingAndSortingRepository<OffenderWithImage, Long> {

    @Query(value =
            "SELECT o.offender_id_display FROM offenders o " +
            "INNER JOIN offender_bookings ob " +
            "ON ob.offender_id = o.offender_id " +
            "INNER JOIN offender_images oi " +
            "ON oi.offender_book_id = ob.offender_book_id " +
            "WHERE oi.capture_datetime > :start " +
            "AND (CASE WHEN :end IS NULL THEN 1 " +
            "          WHEN oi.capture_datetime < :end THEN 1" +
            "          ELSE 0 END) = 1",
            nativeQuery = true)
    Page<OffenderWithImage> getOffendersWithImagesCapturedBetween(@Param("start") LocalDateTime start,
                                                                  @Param("end") LocalDateTime end,
                                                                  Pageable pageable);
}

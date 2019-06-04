package net.syscon.elite.api.model;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.time.LocalDate;

@ApiModel(description = "Categorisation detail for an offender")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategorisationDetail {

    @ApiModelProperty(required = true, value = "Booking Id")
    @NotNull(message = "bookingId must be provided")
    private Long bookingId;

    @ApiModelProperty(required = true, value = "Category code")
    @NotNull(message = "category must be provided")
    private String category;

    @NotNull(message = "committee must be provided")
    @ApiModelProperty(required = true, value = "The assessment committee code")
    private String committee;

    @ApiModelProperty(value = "Next review date for recategorisation, defaults to current date + 6 months, if not provided")
    private LocalDate nextReviewDate;

    @ApiModelProperty(value = "Initial categorisation comment")
    private String comment;

    public LocalDate getNextReviewDate() {
        return nextReviewDate == null ? LocalDate.now().plusMonths(6) : nextReviewDate;
    }
}

package net.syscon.elite.api.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.time.LocalDate;

@ApiModel(description = "Prisoner Information")
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Data
@ToString
public class PrisonerInformation implements CategoryCodeAware, ReleaseDateAware {

    @ApiModelProperty(value = "Establishment Code for prisoner", example = "MDI", required = true, position = 1)
    private String establishmentCode;

    @ApiModelProperty(value = "Booking Id (Internal)", example = "1231232", required = true, position = 2)
    private Long bookingId;

    @ApiModelProperty(value = "Offender Identifier", example = "A1234AA", required = true, position = 3)
    private String nomsId;

    @ApiModelProperty(value = "Given Name 1", example = "John", required = true, position = 4)
    private String givenName1;

    @ApiModelProperty(value = "Given Name 2", example = "Luke", required = true, position = 5)
    private String givenName2;

    @ApiModelProperty(value = "Last Name", example = "Smith", required = true, position = 6)
    private String lastName;

    @ApiModelProperty(value = "Requested Name", example = "Dave", position = 7)
    private String requestedName;

    @ApiModelProperty(value = "Date of Birth", example = "1970-05-01", required = true, position = 8)
    private LocalDate dateOfBirth;

    @ApiModelProperty(value = "Gender", example = "Male", required = true, position = 9)
    private String gender;

    @ApiModelProperty(value = "Indicated that is English speaking", example = "true", required = true, position = 10)
    private boolean englishSpeaking;

    @ApiModelProperty(value = "Full Location Code Description", example = "MDI-A-2-003", required = true, position = 11)
    private String cellLocation;

    @ApiModelProperty(value = "Level 1 Location Unit Code", example = "A", required = true, position = 12)
    private String unitCode1;

    @ApiModelProperty(value = "Level 2 Location Unit Code", example = "2", position = 13)
    private String unitCode2;

    @ApiModelProperty(value = "Level 3 Location Unit Code", example = "003", position = 14)
    private String unitCode3;

    @ApiModelProperty(value = "Date Prisoner booking was initial made", example = "2017-05-01", required = true, position = 15)
    private LocalDate bookingBeginDate;

    @ApiModelProperty(value = "Date of admission into this prison", example = "2019-06-01", required = true, position = 16)
    private LocalDate admissionDate;

    @ApiModelProperty(value = "Release Date (if set)", example = "2021-04-12", position = 17)
    private LocalDate releaseDate;

    @ApiModelProperty(value = "Category of this prisoner", example = "C", position = 18)
    private String categoryCode;

    @ApiModelProperty(value = "Status of prisoner in community", required = true, example = "ACTIVE IN", allowableValues = "ACTIVE IN,ACTIVE OUT", position = 19)
    private String communityStatus;

    @ApiModelProperty(value = "Legal Status", example = "Convicted", allowableValues = "Convicted,Remand", position = 20)
    public String getLegalStatus() {
        if (this.bandCode != null) {
            return bandCode <= 8 || bandCode == 11 ? "Convicted" : "Remand";
        }
        return null;
    }

    @JsonIgnore
    private Integer bandCode;
}

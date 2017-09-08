package net.syscon.elite.v2.api.resource;

import io.swagger.annotations.*;
import net.syscon.elite.v2.api.model.ErrorResponse;
import net.syscon.elite.v2.api.model.PrisonerDetail;
import net.syscon.elite.v2.api.support.ResponseDelegate;

import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Api(value = "Prisoner Search", produces = MediaType.APPLICATION_JSON)
public interface PrisonerResource {
    @GET
    @Produces("application/json")
    @ApiOperation(value = "Returns a list prisoners matching criteria specified", nickname = "getPrisoners")
    @ApiResponses(value = {
            @ApiResponse(code = 200, message = "Prisoners successfully retrieved.", response = PrisonerDetail.class, responseContainer = "List",
                    responseHeaders = {
                            @ResponseHeader(name = "Total-Records", description = "Total number of records available", response = Long.class),
                            @ResponseHeader(name = "Page-Offset", description = "Offset of first returned record", response = Long.class),
                            @ResponseHeader(name = "Page-Limit", description = "Limit for number of records returned", response = Long.class)

                    }
            )
    })
    GetPrisonersResponse getPrisoners(@ApiParam(value = "Search by first name (wildcard)") @QueryParam("firstName") String firstName,
                                      @ApiParam(value = "Search by middle names (wildcard)") @QueryParam("middleNames") String middleNames,
                                      @ApiParam(value = "Search by last name (wildcard)") @QueryParam("lastName") String lastName,
                                      @ApiParam(value = "Search for specific PNC number") @QueryParam("pncNumber") String pncNumber,
                                      @ApiParam(value = "Search for specific CRO number") @QueryParam("croNumber") String croNumber,
                                      @ApiParam(value = "Search by date of birth") @QueryParam("dob") String dob,
                                      @ApiParam(value = "Specify a start date for DOB search (max 10 years)") @QueryParam("dobFrom") String dobFrom,
                                      @ApiParam(value = "Specify an end date for DOB search") @QueryParam("dobTo") String dobTo,
                                      @ApiParam(value = "Comma seperated list of fields to sort by") @HeaderParam("Sort-Fields") String sortFields,
                                      @ApiParam(value = "Offset of first returned record") @HeaderParam("Page-Offset") Long offset,
                                      @ApiParam(value = "Limit for number of records returned") @HeaderParam("Page-Limit") Long limit);

    class GetPrisonersResponse extends ResponseDelegate {
        private GetPrisonersResponse(Response response, Object entity) {
            super(response, entity);
        }

        private GetPrisonersResponse(Response response) {
            super(response);
        }

        public static GetPrisonersResponse respond200WithApplicationJson(List<PrisonerDetail> entity, Long offset, Long limit, Long totalRecords) {
            Response.ResponseBuilder responseBuilder = Response.status(200)
                    .header("Content-Type", "application/json")
                    .header("Total-Records", totalRecords)
                    .header("Page-Offset", offset)
                    .header("Page-Limit", limit);
            responseBuilder.entity(entity);
            return new GetPrisonersResponse(responseBuilder.build(), entity);
        }

        public static GetPrisonersResponse respond400WithApplicationJson(ErrorResponse entity) {
            Response.ResponseBuilder responseBuilder = Response.status(400).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new GetPrisonersResponse(responseBuilder.build(), entity);
        }

        public static GetPrisonersResponse respond404WithApplicationJson(ErrorResponse entity) {
            Response.ResponseBuilder responseBuilder = Response.status(404).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new GetPrisonersResponse(responseBuilder.build(), entity);
        }

        public static GetPrisonersResponse respond500WithApplicationJson(ErrorResponse entity) {
            Response.ResponseBuilder responseBuilder = Response.status(500).header("Content-Type", "application/json");
            responseBuilder.entity(entity);
            return new GetPrisonersResponse(responseBuilder.build(), entity);
        }
    }
}

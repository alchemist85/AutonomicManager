package eu.cloudtm.RESTServer.resources;

import com.google.gson.Gson;
import eu.cloudtm.controller.Controller;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;


//@Singleton
@Path("/status")
public class StatusResource extends AbstractResource {

    private static Log log = LogFactory.getLog(StatusResource.class);

    private Gson gson = new Gson();

    @Inject
    private Controller controller;
/*
{
   "state":"WORKING",
   "scale":{
      "nodes":3,
      "configuration":"SMALL",
      "forecaster":"SIMULATOR"
   },
   "replication_protocol":{
      "protocol":"TWOPC",
      "forecaster":"MANUAL"
   },
   "replication_degree":{
      "degree":2,
      "forecaster":"ANALYTIC"
   },
   "data_placement":"enabled"
}
*/
    @GET
    @Produces("application/json")
    public Response getState() {
        String json = controller.getJSONState();

        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);
    }

    /*
    @GET @Path("/replication/degree")
    @Produces("application/json")
    public Response getReplicationDegree() {
        String json = gson.toJson(controller.getStateClone().getReplicationDegreeClone());

        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);
    }

    @GET @Path("/replication/protocol")
    @Produces("application/json")
    public Response getReplicationProtocol() {
        String json = gson.toJson(controller.getStateClone().getReplicationProtocolClone());

        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);

    }

    @GET @Path("/placement")
    @Produces("application/json")
    public Response getDataPlacement() {
        String json = gson.toJson(controller.getStateClone().getDataPlacementClone());

        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);

    }

    @GET @Path("/scale")
    @Produces("application/json")
    public Response getScale() {
        String json = gson.toJson(controller.getStateClone().getScaleClone());

        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);
    }
    */

}

package eu.cloudtm.autonomicManager.RESTServer.resources;

import com.google.gson.Gson;
import eu.cloudtm.autonomicManager.AutonomicManager;
import eu.cloudtm.commons.Forecaster;
import eu.cloudtm.commons.InstanceConfig;
import eu.cloudtm.commons.PlatformTuning;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.inject.Inject;
import javax.inject.Singleton;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.Random;

@Singleton
@Path("/scale")
public class TuningResource extends AbstractResource {

    private static Log log = LogFactory.getLog(TuningResource.class);
    private Gson gson = new Gson();

    @Inject
    private PlatformTuning platformTuning;


    @PUT
    @Consumes("application/x-www-form-urlencoded")
    @Produces("application/json")
    public synchronized Response setForecaster(
            @DefaultValue("ANALYTICAL") @FormParam("scale_autotuning") Forecaster forecaster
    ) {

        /** UPDATING STATE **/
        //ControllerOld.getInstance().updateScale(size, instanceType, tuning);

        //TODO sistemare qui sotto
        //

        platformTuning.setForecaster(forecaster);
        //String json = gson.toJson(ControllerOld.getInstance().getState());

        String json = "{ \"result\" : \"done\" }";
        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);
    }



    @PUT
    @Consumes("application/x-www-form-urlencoded")
    @Produces("application/json")
    public synchronized Response setScale(
            @DefaultValue("TRUE") @FormParam("scale_tuning") Boolean autotuning,
            @DefaultValue("-1") @FormParam("scale_size") int size,
            @DefaultValue("MEDIUM") @FormParam("instance_type") InstanceConfig instanceType
    ) {

        if(autotuning){
        } else{
            if(!(size>=0 && instanceType!=null)){
                throw new WebApplicationException(Response.Status.BAD_REQUEST);
            }


        }

        /** UPDATING STATE **/

        //TODO sistemare qui sotto String json = gson.toJson(ControllerOld.getInstance().getState());

        String json = "{ \"todo\" : \"da impl\" }";
        Response.ResponseBuilder builder = Response.ok(json);
        return makeCORS(builder);
    }

}
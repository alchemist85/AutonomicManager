package eu.cloudtm;

import eu.cloudtm.stats.WPMSample;
import eu.cloudtm.wpm.parser.ResourceType;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.List;

/**
 * Created by: Fabio Perfetti
 * E-mail: perfabio87@gmail.com
 * Date: 6/16/13
 */
public class InputFilter {

    private static Log log = LogFactory.getLog(InputFilter.class);

    private StatsManager statsManager;

    /* *** SOGLIE *** */
    private static final int DELTA_ARRIVAL_RATE = 2;
    private double lastAvgArrivalRate = 0.0;

    private static final int DELTA_ABORT_RATE = 2;
    private double lastAvgAbortRate = 0.0;

    private static final int DELTA_RESPONSE_TIME = 2;
    private double lastAvgResposeTime = 0.0;

//    /* *** VALORI ATTUALI *** */
//    private double currentArrivalRate;
//    private double current;
//    private double currentThroughput;

    public InputFilter(StatsManager _statsManager){
        statsManager = _statsManager;
    }

    public boolean doFilter(){
        List<WPMSample> lastNSamples = statsManager.getLastNSample( Controller.SAMPLE_WINDOW );
        boolean reconfigure;

        boolean arrivalRateResponse = evaluateArrivalRate(lastNSamples);
        boolean responseTimeResponse = evaluateResponseTime(lastNSamples);
        boolean abortRateResponse = evaluateAbortRate(lastNSamples);

        reconfigure =  arrivalRateResponse || responseTimeResponse || abortRateResponse;

        return reconfigure;
    }

    private boolean evaluateAbortRate(List<WPMSample> lastNSamples){
        double abortSum = 0.0;
        for (WPMSample sample : lastNSamples){
            abortSum += (1 - StatsManager.getAvgAttribute("CommitProbability", sample, ResourceType.JMX));
        }
        double currentAbortAvg =  abortSum / ((double) lastNSamples.size());
        log.debug("currentAbortAvg: " + currentAbortAvg);
        log.debug("lastAvgAbortRate: " + lastAvgAbortRate);

        if(lastAvgAbortRate == 0 || lastAvgAbortRate == Double.NaN){
            log.debug("Updating && Skipping lastAvgAbortRate");
            lastAvgAbortRate = currentAbortAvg;
        } else {
            double rapporto = ( currentAbortAvg / lastAvgAbortRate ) * 100;
            log.debug("rapporto: " + rapporto );

            double variazione = Math.abs(rapporto - 100);
            log.debug("variazione: " + variazione );

            if( variazione >= DELTA_ABORT_RATE ){
                log.debug("Update the lastAvgAbortRate");
                lastAvgAbortRate = currentAbortAvg;
                log.trace("SOGLIA RAGGIUNTA x AbortRate");
                return true;
            }
        }
        return false;
    }

    private boolean evaluateResponseTime(List<WPMSample> lastNSamples){
        return false;
    }

    private boolean evaluateArrivalRate(List<WPMSample> lastNSamples){
        double throughputSum = 0.0;
        for (WPMSample sample : lastNSamples){
            throughputSum += StatsManager.getAvgAttribute("Throughput", sample, ResourceType.JMX);
        }
        double currentThroughputAvg =  throughputSum / ((double) lastNSamples.size());
        log.trace("currentThroughputAvg: " + currentThroughputAvg);
        log.trace("lastAvgArrivalRate: " + lastAvgArrivalRate);

        if(lastAvgArrivalRate == 0 || lastAvgArrivalRate == Double.NaN){
            log.info("Updating && Skipping lastAvgArrivalRate");
            lastAvgArrivalRate = currentThroughputAvg;
        } else {
            double rapporto = ( currentThroughputAvg / lastAvgArrivalRate ) * 100;
            log.info("rapporto: " + rapporto );

            double variazione = Math.abs(rapporto - 100);
            log.info("variazione: " + variazione );

            if( variazione >= DELTA_ARRIVAL_RATE ){
                log.info("Update the lastAvgArrivalRate");
                lastAvgArrivalRate = currentThroughputAvg;
                log.trace("SOGLIA RAGGIUNTA x ArrivalRate");
                return true;
            }
        }
        return false;
    }


    /* *** GETTER PER I VALORI ATTUALI *** */

    public double getLastAvgResposeTime() {
        return lastAvgResposeTime;
    }

    public double getLastAvgAbortRate() {
        return lastAvgAbortRate;
    }

    public double getLastAvgArrivalRate() {
        return lastAvgArrivalRate;
    }

}
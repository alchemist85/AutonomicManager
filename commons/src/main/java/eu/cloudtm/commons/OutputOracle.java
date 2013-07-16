package eu.cloudtm.commons;

/**
 * Created by: Fabio Perfetti
 * E-mail: perfabio87@gmail.com
 * Date: 7/13/13
 */
public interface OutputOracle {

    public double throughput();

    public double abortRate();

    public double responseTime(int txClassId);
}
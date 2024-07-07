package bdd;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static bdd.util.ReportUtil_6.generateCucumberReport;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class Runner_hw_zte_EN {
    final static Logger looger = LoggerFactory.getLogger(Runner_hw_zte_EN.class);

    @Test
    void testflujoztehwEN() {
        looger.info("Ejecutando nuestra prueba de API");
        Results results =
                Runner.path("classpath:bdd/provisionamiento/provisionamiento_operatividad_EN.feature")
                        .tags("@name=flujoztehwEN")
                        .outputCucumberJson(true)
                        .parallel(2);
        generateCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

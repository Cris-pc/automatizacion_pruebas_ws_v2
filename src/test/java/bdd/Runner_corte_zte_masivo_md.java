package bdd;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static bdd.util.ReportUtil_11.generateCucumberReport;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class Runner_corte_zte_masivo_md {
    final static Logger looger = LoggerFactory.getLogger(Runner_corte_zte_masivo_md.class);

    @Test
    void testflujozteMD() {
        looger.info("Ejecutando nuestra prueba de API");
        Results results =
                Runner.path("classpath:bdd/provisionamiento/provisionamiento_zte_corte_masivo.feature")
                        .tags("@name=cortemasivoztemd")
                        .outputCucumberJson(true)
                        .parallel(2);
        generateCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

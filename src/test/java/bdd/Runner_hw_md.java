package bdd;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static bdd.util.ReportUtil.generateCucumberReport;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class Runner_hw_md {
    final static Logger looger = LoggerFactory.getLogger(Runner_hw_md.class);

    @Test
    void testflujohwMD() {
        looger.info("Ejecutando nuestra prueba de API");
        Results results =
                Runner.path("classpath:bdd/provisionamiento/flujocompletohw.feature")
                        .tags("@name=flujohwmd")
                        .outputCucumberJson(true)
                        .parallel(2);
        generateCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}

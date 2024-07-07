package bdd.util;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class ReportUtil_15 {

    public static void generateCucumberReport(String karateOutputPath) {
        try {
            Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
            List<String> jsonPaths = jsonFiles.stream().map(File::getAbsolutePath).collect(Collectors.toList());
            Configuration config = new Configuration(new File("/home/automatizacion/provisionamiento_hw_corte_masivo"), "Cucumber Reports");
            File copied = new File("target/builder/cucumber.json");
            FileUtils.copyFile(new File(jsonPaths.get(0)), copied);
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();
        } catch (IOException ex) {
            throw new RuntimeException(ex);
        }
    }
}
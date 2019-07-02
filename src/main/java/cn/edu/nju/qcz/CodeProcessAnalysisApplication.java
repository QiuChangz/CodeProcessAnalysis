package cn.edu.nju.qcz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "cn.edu.nju.qcz")
public class CodeProcessAnalysisApplication {

    public static void main(String[] args) {
        SpringApplication.run(CodeProcessAnalysisApplication.class, args);
    }

}

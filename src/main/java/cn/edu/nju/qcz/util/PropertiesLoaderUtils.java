package cn.edu.nju.qcz.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class PropertiesLoaderUtils {

    private static final Logger log = LoggerFactory.getLogger(PropertiesLoaderUtils.class);

    private static String configDir;

    static {
        String os = System.getProperty("os.name");
        if (os.toLowerCase().startsWith("win")) {
            //windows系统
            configDir = new File("").getAbsolutePath() + "\\config\\";
        } else {
            //unix系统
            configDir = new File("").getAbsolutePath() + "/config/";
        }
    }

    private Properties properties;

    public String getConfigDirectory() {
        return configDir;
    }

    public PropertiesLoaderUtils(String fileName) {
        String configFile = configDir + fileName;
        properties = new Properties();
        try{
            FileInputStream inputFile = new FileInputStream(configFile);
            properties.load(inputFile);
            inputFile.close();
            log.info("PropertiesLoaderUtils load config success, fileName : " + configFile);
        } catch (FileNotFoundException ex) {
            log.error(ex.getMessage(), ex);
        } catch (IOException ex) {
            log.error("PropertiesLoaderUtils IOException : load config failed, exception : " + ex.toString());
        }
    }

    /**
     * 根据key获取对应的value
     * @param key 配置名
     * @return 配置值
     */
    public String getConfig(String key) {
        if(properties.containsKey(key)) {
            return properties.getProperty(key);
        }
        else
            return "";
    }
}

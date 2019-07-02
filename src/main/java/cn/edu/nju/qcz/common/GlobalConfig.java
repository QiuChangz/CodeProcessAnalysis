package cn.edu.nju.qcz.common;

import cn.edu.nju.qcz.util.PropertiesLoaderUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Map;

public class GlobalConfig {
    private static final String CONFIG_FILE_NAME = "global.properties";
    private static PropertiesLoaderUtils loader = new PropertiesLoaderUtils(CONFIG_FILE_NAME);
    private static Map<String, String> map = new HashMap<>();

    private GlobalConfig() {}

    /**
     * 获取配置值
     * @param key 配置名称
     * @return 若map中存在key，直接返回map中对应的value，否则返回loader中获取的value，并将key，value存在map中
     */
    private static String getConfig(String key) {
        String value = map.get(key);
        if (value == null) {
            value = loader.getConfig(key);
            map.put(key, value != null ? value : "");
        }
        return value;
    }

    public static String getConfig(String key, String defaultValue) {
        String value = getConfig(key);
        return StringUtils.isBlank(value) ? defaultValue : value;
    }
}

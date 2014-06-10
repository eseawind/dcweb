package com.jstrd.asdc.util;

import org.springframework.beans.factory.FactoryBean;

import java.util.Properties;

/**
 * 对Spring配置文件中数据库用户名密码进行加密
 */
public class PropertiesEncryptFactoryBean implements FactoryBean {

    private Properties properties;

    private String key = "8a!2e4b4%1b6e2&ba5.-011b?720f-=+";

    public Object getObject() throws Exception {
        return getProperties();
    }

    public Class getObjectType() {
        return java.util.Properties.class;
    }

    public boolean isSingleton() {
        return true;
    }

    public Properties getProperties() {
        return properties;
    }

    public void setProperties(Properties inProperties) {
        this.properties = inProperties;
        String originalUsername = properties.getProperty("user");
        String originalPassword = properties.getProperty("password");
        if (originalUsername != null){
            String newUsername = SecurityHelper.DESDecrypt(originalUsername, key);
            properties.put("user", newUsername);
        }
        if (originalPassword != null){
            String newPassword = SecurityHelper.DESDecrypt(originalPassword, key);
            properties.put("password", newPassword);
        }
    }
}



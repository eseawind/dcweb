package com.jstrd.asdc.servlet;
import java.io.File;
import java.io.FileInputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Properties;

import org.apache.log4j.Logger;
  
/**  
 * 动态读取配置文件类  
 */  
@SuppressWarnings("unused")
public class ConfigurationRead {   
  
	private static Logger logger = Logger.getLogger(ConfigurationRead.class);
    // 属性文件全名  
    private static final String PFILE = "config.properties";   
  
   // 配置文件路径  
	private URI uri = null;   
  
    // 属性文件所对应的属性对象变量  
    private long m_lastModifiedTime = 0;   
  
    // 对应于属性文件的文件对象变量  
    private File m_file = null;   
  
    // 属性文件所对应的属性对象变量   
    private Properties m_props = null;   
  
    // 唯一实例  
    private static ConfigurationRead m_instance = new ConfigurationRead();   
  
   // 私有构造函数   
    private ConfigurationRead() {   
        try {   
            m_lastModifiedTime = getFile().lastModified();   
            if (m_lastModifiedTime == 0) {   
                System.err.println(PFILE + "file does not exist!");   
            }   
            m_props = new Properties();   
            m_props.load(new FileInputStream(getFile()));   
  
        } catch (Exception e) {   
        	logger.error(e);   
        }   
    }   
  
    /**  
     * 查找ClassPath路径获取文件  
     */  
    private File getFile() throws URISyntaxException { 
    	URI fileUri = this.getClass().getClassLoader().getResource(PFILE).toURI();   
    	m_file = new File(fileUri);   
        return m_file;   
    }   
  
    public synchronized static ConfigurationRead getInstance() {   
        return m_instance;   
    }   

    public String getConfigItem(String name, String defaultVal) { 
    	try {
			getFile();
		} catch (URISyntaxException e) {
			logger.error(e);
		}
        long newTime = m_file.lastModified();   
        // 检查属性文件是否被修改   
        if (newTime == 0) {   
            // 属性文件不存在   
            if (m_lastModifiedTime == 0) {   
                logger.info(PFILE + " file does not exist!");   
            } else {   
            	logger.info(PFILE + " file was deleted!!");   
            }   
            return defaultVal;   
        } else if (newTime > m_lastModifiedTime) {  
        	m_props.clear();   
            try {   
                m_props.load(new FileInputStream(getFile()));   
            } catch (Exception e) {   
            	logger.error(e);
            }   
        }   
        m_lastModifiedTime = newTime;   
        String val = m_props.getProperty(name);   
        if (val == null) {   
            return defaultVal;   
        } else {   
            return val;   
        }   
    }   
  
    public String getConfigItem(String name) {   
        return getConfigItem(name, "");   
    }   
  
}  

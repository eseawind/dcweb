package com.jstrd.asdc.email;

import java.util.ResourceBundle;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
public class mailTest {

	/**
	 * @param args
	 */
	public static void main(String[] args){   
        //这个类主要是设置邮件   
     MailSenderInfo mailInfo = new MailSenderInfo();    
     mailInfo.setMailServerHost("smtp.163.com");    
     mailInfo.setMailServerPort("25");    
     mailInfo.setValidate(true);    
     mailInfo.setUserName("voicet@163.com");    
     mailInfo.setPassword("5424264586");//您的邮箱密码    
     mailInfo.setFromAddress("voicet@163.com");    
     mailInfo.setToAddress("7079321@qq.com");    

     mailInfo.setSubject("账号激活确认邮件");  
     String mainCon="";
     mainCon=getProperties("RES_MAILCON","messageResource_en_US.properties");   
     mailInfo.setContent(mainCon);    
        //这个类主要来发送邮件   
     SimpleMailSender sms = new SimpleMailSender();   
         sms.sendHtmlMail(mailInfo);//发送html格式   

   }  

	public static String getProperties(String res,String fileName) {

		String s="";
		Properties p;

		FileInputStream in;

		FileOutputStream out;
		 File file = new File(fileName);
		 try {
			 String path= MainSend.class.getClass().getResource("/").getPath();
		    	if (path.length()>1 && path.substring(0,1).equals("/"))
		    		path=path.substring(1,path.length());
		    	System.out.println(path);
		 in = new FileInputStream(path+file);
		 p = new Properties();
		 p.load(in);
		 s=p.getProperty(res);
		 in.close();
		 } catch (FileNotFoundException e) {
		 // TODO Auto-generated catch block
		 System.err.println("配置文件config.properties找不到！");
		 e.printStackTrace();
		 } catch (IOException e) {
		 // TODO Auto-generated catch block
		 System.err.println("读取配置文件config.properties错误！");
		 e.printStackTrace();
		 }
		 return s;
	    	
	      
	}
}

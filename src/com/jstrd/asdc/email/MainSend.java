package com.jstrd.asdc.email;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

public class MainSend{
	private static Logger logger = Logger.getLogger(MainSend.class.getName());
	private	int stationId;
	private String localtime;
	
	public void doSend(String email, String listNo, String userName, String checkUrl, String webUrl, String lang, String realPath) {
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		mailInfo.setToAddress(email);
		String mainCon = "";
		mainCon = getProperties("RES_MAILCON", realPath + "messageResource_" + lang + ".properties");
		mainCon = mainCon.replaceAll("& username &", userName);
		mainCon = mainCon.replaceAll("& listno &", listNo);
		mainCon = mainCon.replaceAll("& viaurl &", checkUrl);
		mainCon = mainCon.replaceAll("& weburl &", webUrl);
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_MAILTITLE", realPath + "messageResource_" + lang + ".properties"));
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendHtmlMail(mailInfo);
		sms.run();
	}

	public void doSendCheckCode(String email, String checkcode, String userName, String webUrl, String lang, String realPath, String chgpwdUrl) {
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		mailInfo.setToAddress(email);
		String mainCon = "<img src='"
				+ webUrl
				+ "/images/report_logo.gif'><br><hr width=600 size=1 align='left'>";
		mainCon = mainCon
				+ getProperties("RES_MAIL_UPDATEPWD_CON", realPath
				+ "messageResource_" + lang + ".properties");
		mainCon = mainCon.replaceAll("& username &", userName);
		mainCon = mainCon.replaceAll("& checkcode &", checkcode);
		mainCon = mainCon.replaceAll("& weburl &", webUrl);
		mainCon = mainCon.replaceAll("& chgUrl &", chgpwdUrl);
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_MAIL_UPDATEPWD_TITLE", realPath + "messageResource_" + lang + ".properties"));
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendHtmlMail(mailInfo);
		sms.run();
		
	}

	public void doSendShare(String email, String listNo, String userName, String shareName, String plantname, String checkUrl, String webUrl, String lang, String realPath) {
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		mailInfo.setToAddress(email);
		String mainCon = "";
		mainCon = getProperties("RES_SHAREMAILCON", realPath + "messageResource_" + lang + ".properties");
		mainCon = mainCon.replaceAll("& username &", userName);
		mainCon = mainCon.replaceAll("& sharename &", shareName);
		mainCon = mainCon.replaceAll("& plantname &", plantname);
		mainCon = mainCon.replaceAll("& listno &", listNo);
		mainCon = mainCon.replaceAll("& viaurl &", checkUrl);
		mainCon = mainCon.replaceAll("& weburl &", webUrl);
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_SHAREMAILTITLE", realPath + "messageResource_" + lang + ".properties"));
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendHtmlMail(mailInfo);
	}

	public void doSendShareDel(String email, String managerName, String managerEmail, String shareName, String plantname, String lang, String realPath, String basePath) {
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		mailInfo.setToAddress(email);
		String mainCon = "<p align='left'><img src='"
				+ basePath
				+ getProperties("RES_REPORT_TITLE_IMG", realPath
				+ "messageResource_" + lang + ".properties")
				+ "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		String mailTitle = getProperties("RES_CONF_SHARE_DEL_MAIL_TITLE", realPath + "messageResource_" + lang + ".properties");
		mailTitle = mailTitle.replaceAll("& plantname &", plantname);
		mainCon += "<strong><span stytle='font-size: 24px'>" + mailTitle
				+ "</span></strong></p>";
		mainCon += "<hr>";
		mainCon += getProperties("RES_CONF_SHARE_DEL_MAIL_DEAR", realPath
				+ "messageResource_" + lang + ".properties")
				+ "<br>";
		mainCon += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ getProperties("RES_CONF_SHARE_DEL_MAIL_MES", realPath
				+ "messageResource_" + lang + ".properties") + "<br>";
		mainCon = mainCon.replaceAll("& username &", shareName);
		mainCon = mainCon.replaceAll("& managername &", managerName);
		mainCon = mainCon.replaceAll("& manageremail &", managerEmail);
		mainCon = mainCon.replaceAll("& plantname &", plantname);
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(mailTitle);
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendHtmlMail(mailInfo);
	}

	public void doSendDayReport(String emails, String userName, String plantName, Map mainInfo, String itemStr, String lang, String realPath, String basePath, String img) {
		String nowTime = getLocaltime();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		String nowDay = formatter.format(new Date());
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		String mail[] = emails.split(";");
		String mailList = "";
		for (int i = 0; i < mail.length; i++) {
			mailList += (i + 1) + "、" + mail[i] + ";<br>";
		}
		String mainCon = "<p align='left'>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_TITLE_DAY", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong></p>";
		mainCon += "<hr>";
		mainCon += getProperties("RES_REPORT_FIRSTMES", realPath
				+ "messageResource_" + lang + ".properties")
				+ "<br>";
		mainCon = mainCon.replaceAll("& username &", "");
		mainCon += "&nbsp;&nbsp;&nbsp;&nbsp;"
				+ getProperties("RES_REPORT_SECONDMES_DAY", realPath
				+ "messageResource_" + lang + ".properties")
				+ "<br>";
		mainCon = mainCon.replaceAll("& plantname &", plantName);
		mainCon += "<hr>";
		mainCon += "<br>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_MESSAGE", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong><br>";
		mainCon += "<br>";
		//报告周期
		mainCon += getProperties("RES_REPORT_TIMEINTERVAL", realPath
				+ "messageResource_" + lang + ".properties")
				//+ mainInfo.get("startdt").toString()
				//+ "--"
				+ mainInfo.get("enddt").toString() + "<br>";
		mainCon += "<br>";
		String items[] = itemStr.split(",");
		mainCon += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
		//本日发电量
		if (items[0].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_1", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("e_today").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//本日发电峰值
		if (items[1].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_2", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("power_max").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//本日收益
		if (items[2].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_3", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("in_today").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//本日CO2减排量
		if (items[3].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_4", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("co2_today").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//总发电量
		if (items[4].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_5", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("e_total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//总收益
		if (items[5].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_6", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("in_total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		//总CO2减排量
		if (items[6].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_7", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("co2total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		mainCon += "</table><br>";
		//发送报告时间
		//mainCon += getProperties("RES_REPORT_TIMES", realPath
				//+ "messageResource_" + lang + ".properties")
				//+ nowTime + "<br>";
		//mainCon += "<br>";
		mainCon += "<img src='" + img + "'>";
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_REPORT_TITLE_DAY", realPath
				+ "messageResource_" + lang + ".properties")
				+ " " + plantName + "(" + nowDay + ")");
		SimpleMailSender sms = new SimpleMailSender();
		for (int i = 0; i < mail.length; i++) {
			mailInfo.setToAddress(mail[i]);
			sms.sendHtmlMail(mailInfo);
			sms.run();
		}
	}

	public void doSendMonthReport(String emails, String userName, String plantName, Map mainInfo, String itemStr, String lang, String realPath, String basePath, String img) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = getLocaltime();
		formatter = new SimpleDateFormat("yyyy-MM");
		String nowDay = formatter.format(new Date());
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		String mail[] = emails.split(";");
		String mailList = "";
		for (int i = 0; i < mail.length; i++) {
			mailList += (i + 1) + "、" + mail[i] + ";<br>";
		}
		String mainCon = "<p align='left'>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_TITLE_MONTH", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong></p>";
		mainCon += "<hr>";
		mainCon += getProperties("RES_REPORT_FIRSTMES", realPath
				+ "messageResource_" + lang + ".properties")
				+ "<br>";
		mainCon = mainCon.replaceAll("& username &", "");
		mainCon += "&nbsp;&nbsp;&nbsp;&nbsp;"
				+ getProperties("RES_REPORT_SECONDMES_DAY", realPath
				+ "messageResource_" + lang + ".properties") + "<br>";
		mainCon = mainCon.replaceAll("& plantname &", plantName);
		mainCon += "<br>";
		//mainCon += getProperties("RES_REPORT_SENDMAILS", realPath
		//		+ "messageResource_" + lang + ".properties")
		//		+ "<br>";
		//mainCon += mailList;
		mainCon += "<hr>";
		mainCon += "<br>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_MESSAGE", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong><br>";
		mainCon += "<br>";
		mainCon += getProperties("RES_REPORT_TIMEINTERVAL", realPath
				+ "messageResource_" + lang + ".properties")
				//+ mainInfo.get("startdt").toString()
				//+ "--"
				+ mainInfo.get("enddt").toString() + "<br>";
		mainCon += "<br>";
		mainCon += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
		String items[] = itemStr.split(",");
		if (items[0].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_1", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("e_month").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[1].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_2", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("power_max").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[2].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_3", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("in_month").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[3].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_4", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("co2_month").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[4].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_5", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("e_total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[5].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_MONTH_6", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("in_total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		if (items[6].equals("1")) {
			mainCon += "<tr>";
			mainCon += "<td width=\"25%\" height=\"25\" align=\"right\">";
			mainCon += getProperties("RES_REPORT_MES_DAY_7", realPath
					+ "messageResource_" + lang + ".properties")
					+ "</td><td  height=\"25\" align=\"left\">"
					+ "&nbsp;&nbsp;"
					+ mainInfo.get("co2total").toString()
					+ "</td>";
			mainCon += "</tr>";
		}
		mainCon += "</table><br>";
		//mainCon += getProperties("RES_REPORT_TIMES", realPath
				//+ "messageResource_" + lang + ".properties")
				//+ nowTime + "<br>";
		//mainCon += "<br>";
		mainCon += "<img src='" + img + "'>";
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_REPORT_TITLE_MONTH", realPath
				+ "messageResource_" + lang + ".properties")
				+ " " + plantName + "(" + nowDay + ")");
		SimpleMailSender sms = new SimpleMailSender();
		for (int i = 0; i < mail.length; i++) {
			mailInfo.setToAddress(mail[i]);
			sms.sendHtmlMail(mailInfo);
			sms.run();
		}
	}

	public void doSendEventReport(String emails, String userName, String plantName, Map mainInfo, String itemStr, String lang, String realPath, String basePath, String img, String startDt, String endDt) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String nowTime = getLocaltime();
		formatter = new SimpleDateFormat("yyyy-MM");
		String nowDay = formatter.format(new Date());
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost(mailServerInfo.serverHost);
		mailInfo.setMailServerPort(mailServerInfo.serverHost + "");
		mailInfo.setValidate(true);
		mailInfo.setUserName(mailServerInfo.mailAcc);
		mailInfo.setPassword(mailServerInfo.emailPwd);
		mailInfo.setFromAddress(mailServerInfo.sendEmail);
		String mail[] = emails.split(";");
		String mailList = "";
		for (int i = 0; i < mail.length; i++) {
			mailList += (i + 1) + "、" + mail[i] + ";<br>";
		}
		String mainCon = "<p align='left'>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_TITLE_EVENT", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong></p>";
		mainCon += "<hr>";
		mainCon += getProperties("RES_REPORT_FIRSTMES", realPath
				+ "messageResource_" + lang + ".properties")
				+ "<br>";
		//mainCon = mainCon.replaceAll("& username &", userName);
		mainCon = mainCon.replaceAll("& username &", "");
		mainCon += "&nbsp;&nbsp;&nbsp;&nbsp;"
				+ getProperties("RES_REPORT_SECONDMES_DAY", realPath
				+ "messageResource_" + lang + ".properties") + "<br>";
		mainCon = mainCon.replaceAll("& plantname &", plantName);
		//mainCon += getProperties("RES_REPORT_SENDMAILS", realPath
		//		+ "messageResource_" + lang + ".properties")
		//		+ "<br>";
		//mainCon += mailList;
		mainCon += "<br>";
		mainCon += getProperties("RES_REPORT_TIMEINTERVAL", realPath
				+ "messageResource_" + lang + ".properties")
				//+ startDt + "--" 
				+ endDt + "<br>";
		mainCon += "<br>";
		//mainCon += getProperties("RES_REPORT_TIMES", realPath
				//+ "messageResource_" + lang + ".properties")
				//+ nowTime + "<br>";
		//mainCon += "<br>";
		mainCon += "<strong><span stytle='font-size: 24px'>"
				+ getProperties("RES_REPORT_MESSAGE", realPath
				+ "messageResource_" + lang + ".properties")
				+ "</span></strong><br>";
		mainCon += img;
		mailInfo.setContent(mainCon);
		mailInfo.setSubject(getProperties("RES_REPORT_TITLE_EVENT", realPath
				+ "messageResource_" + lang + ".properties")
				+ " " + plantName + "(" + nowDay + ")");
		SimpleMailSender sms = new SimpleMailSender();
		for (int i = 0; i < mail.length; i++) {
			mailInfo.setToAddress(mail[i]);
			sms.sendHtmlMail(mailInfo);
			sms.run();
		}
	}

	public String getProperties(String res, String fileName) {
		String s = "";
		Properties p;
		FileInputStream in;
		FileOutputStream out;
		File file = new File(fileName);
		try {
			in = new FileInputStream(file);
			p = new Properties();
			p.load(in);
			s = p.getProperty(res);
			in.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return s;
	}
	
	/**
	 *  获得指定日期的前一天 
	 * @param specifiedDay
	 * @return
	 */
	public static String getSpecifiedDayBefore(String specifiedDay) {
		Calendar calendar = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd HH:mm:ss").parse(specifiedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		calendar.setTime(date);
		int day = calendar.get(Calendar.DATE);
		calendar.set(Calendar.DATE, day - 1);
		String dayBefore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
		return dayBefore;
	}

	public int getStationId() {
		return stationId;
	}

	public void setStationId(int stationId) {
		this.stationId = stationId;
	}
	
	public String getLocaltime() {
		return localtime;
	}

	public void setLocaltime(String localtime) {
		this.localtime = localtime;
	}

}

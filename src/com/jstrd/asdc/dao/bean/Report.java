package com.jstrd.asdc.dao.bean;

public class Report {
	
	private int reportId;
	private int reportType;
	private String sendMails;
	private String sendContent;
	private String sendMethod;
	private int sendMaxnum;
	private int repeatType;
	private int isOpen;
	private int notNeweIsstill;
	private int stationid;
	private String sendDayRepeatTime;
	private String sendMonthRepeatTime;
	private String phone;
	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public int getReportType() {
		return reportType;
	}
	public void setReportType(int reportType) {
		this.reportType = reportType;
	}
	public String getSendMails() {
		return sendMails;
	}
	public void setSendMails(String sendMails) {
		this.sendMails = sendMails;
	}
	public String getSendContent() {
		return sendContent;
	}
	public void setSendContent(String sendContent) {
		this.sendContent = sendContent;
	}
	public String getSendMethod() {
		return sendMethod;
	}
	public void setSendMethod(String sendMethod) {
		this.sendMethod = sendMethod;
	}
	public int getSendMaxnum() {
		return sendMaxnum;
	}
	public void setSendMaxnum(int sendMaxnum) {
		this.sendMaxnum = sendMaxnum;
	}
	public int getRepeatType() {
		return repeatType;
	}
	public void setRepeatType(int repeatType) {
		this.repeatType = repeatType;
	}
	public int getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}
	public int getNotNeweIsstill() {
		return notNeweIsstill;
	}
	public void setNotNeweIsstill(int notNeweIsstill) {
		this.notNeweIsstill = notNeweIsstill;
	}
	public int getStationid() {
		return stationid;
	}
	public void setStationid(int stationid) {
		this.stationid = stationid;
	}
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getSendDayRepeatTime() {
		return sendDayRepeatTime;
	}
	public void setSendDayRepeatTime(String sendDayRepeatTime) {
		this.sendDayRepeatTime = sendDayRepeatTime;
	}
	public String getSendMonthRepeatTime() {
		return sendMonthRepeatTime;
	}
	public void setSendMonthRepeatTime(String sendMonthRepeatTime) {
		this.sendMonthRepeatTime = sendMonthRepeatTime;
	}

}

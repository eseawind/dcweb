package com.jstrd.asdc.util;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

public class DateUtil {

	/**
	 * 获取12个月的月第一天 和 本月的最后一天
	 * @throws ParseException 
	 */
	public static List<String> get2daysForSql(String date) throws ParseException{
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		//list.add(sdf.format(sdf.parse(date)));
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		int day = Integer.parseInt(date.split("-")[2]);
		cal.setTime(sdf.parse(date));
		cal.set(Calendar.YEAR,   year); 
		cal.set(Calendar.MONTH,   month); 
		cal.set(Calendar.DATE, cal.getActualMinimum(cal.DAY_OF_MONTH));
		cal.add(Calendar.MONTH, -11);
		list.add(sdf.format(cal.getTime()));
		cal.set(year, month, day);
		cal.set(Calendar.YEAR,   year); 
		cal.set(Calendar.MONTH,   month); 
		cal.set(Calendar.DATE, cal.getActualMaximum(cal.DAY_OF_MONTH));
		list.add(sdf.format(cal.getTime()));
		return list; 
	}
	public static String getDblStr(String dbl) {
		if (dbl!=null && dbl.length()>0){
			if (dbl.indexOf(".")!=-1){
				dbl=dbl.trim();
				if (dbl.substring(0,1).equals("."))
					dbl="0"+dbl;
				
				
			}
		}
		return dbl;
	}
	/**
	 * 获取某月第一天
	 */
	public static String getFirstDayOfMonth(String date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		int day = Integer.parseInt(date.split("-")[2]);
		cal.set(Calendar.YEAR,   year); 
		cal.set(Calendar.MONTH,   month); 
		cal.set(Calendar.DATE, cal.getActualMinimum(cal.DAY_OF_MONTH));
		return sdf.format(cal.getTime());
	}
	/**
	 * 获取某月最后一天
	 */
	public static String getLastDayOfMonth(String date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		int day = Integer.parseInt(date.split("-")[2]);
		cal.set(Calendar.YEAR,   year); 
		cal.set(Calendar.MONTH,   month); 
		cal.set(Calendar.DATE, cal.getActualMaximum(cal.DAY_OF_MONTH));
		return sdf.format(cal.getTime());
	}
	
	/**
	 * 获取某年第一天
	 */
	public static String getFirstDayOfYear(String date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int year = Integer.parseInt(date.split("-")[0]);
		Calendar calendar = Calendar.getInstance();   
	    calendar.clear();   
	    calendar.set(Calendar.YEAR, year);   
		return sdf.format(calendar.getTime());
	}
	/**
	 * 获取某年最后一天
	 */
	public static String getLastDayOfYear(String date){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int year = Integer.parseInt(date.split("-")[0]);
		Calendar calendar = Calendar.getInstance();   
	    calendar.clear();   
	    calendar.set(Calendar.YEAR, year);   
	    calendar.roll(Calendar.DAY_OF_YEAR, -1);   
		return sdf.format(calendar.getTime());
	}
	/**
	 * 获取昨天
	 */
	public static String getToday(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		return sdf.format(cal.getTime());
	}
	/**
	 * 获取昨天
	 */
	public static String getYesterDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, -1);
		return sdf.format(cal.getTime());
	}
	/**
	 * 获取下一周的所有日期
	 */
	public static List<String>  getNextWeek(){
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, 7);
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		list.add(sdf.format(cal.getTime()));
		return list;
	}
	/**
	 * 获取上一周的所有日期
	 */
	public static  List<String>  getPreWeek(){
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, -7);
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		list.add(sdf.format(cal.getTime()));
		return list;
	}
	/**
	 * 获取本周的所有日期
	 */
	public static  List<String>  getCurrentWeek(){
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		list.add(sdf.format(cal.getTime()));
		return list;
	}
	/**
	 * 获取最近7天
	 * @param args
	 * @throws ParseException 
	 * @throws ParseException 
	 * @throws Exception
	 */
	public static  List<String>  getLastSeventDay(String date) throws ParseException {
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		list.add(sdf.format(sdf.parse(date)));
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		int day = Integer.parseInt(date.split("-")[2]);
		cal.set(year, month, day);
		for(int i=-6;i<0;i++){
			cal.add(cal.DATE, -1);
			list.add(sdf.format(cal.getTime()));
		}
		Collections.reverse(list);
		return list;
	}
	
	/**
	 * 周天开始 获取一周内的具体天数
	 * @param monthStr
	 * @return
	 */
	public static  List<String>  getWeekDays(String date) throws ParseException{
		List<String> list = new LinkedList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		//list.add(sdf.format(sdf.parse(date)));
		int year = Integer.parseInt(date.split("-")[0]);
		int month = Integer.parseInt(date.split("-")[1])-1;
		int day = Integer.parseInt(date.split("-")[2]);
		cal.setTime(sdf.parse(date));
		cal.set(year, month, day);
		cal.set(Calendar.DAY_OF_WEEK,Calendar.SUNDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.MONDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.TUESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.WEDNESDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.THURSDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.FRIDAY);
		list.add(sdf.format(cal.getTime()));
		cal.set(Calendar.DAY_OF_WEEK,Calendar.SATURDAY);
		list.add(sdf.format(cal.getTime()));
		return list;
	}
	
	
	
	public static List<String> getDaysByMonth(String monthStr){
		List<String> list = new LinkedList<String>();
		int year = Integer.parseInt(monthStr.split("-")[0]);
		int month = Integer.parseInt(monthStr.split("-")[1])-1;
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
		int totalDays = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		for(int i=1;i<=totalDays;i++){
			list.add(monthStr+"-"+(i<10?"0"+i:i));
		}
		return list;
	}

	public static List<String> getLast12Months(String monthStr){
		List<String> list = new LinkedList<String>();
		int year = Integer.parseInt(monthStr.split("-")[0]);
		int month = Integer.parseInt(monthStr.split("-")[1]);
		for(int i=0;i<12;i++){
			if(month>0){
				list.add(year+"-"+(month<10?"0"+month:month));
				month--;
			}else{
				list.add((year-1)+"-"+((month+12)<10?"0"+(month+12):(month+12)));
				month--;
			}
		}
		Collections.reverse(list);
		return list;
	}
	
	public static void main(String args[]) throws ParseException{
//		System.out.println(getFirstDayOfYear("2012-01-06"));
//		System.out.println(getLastDayOfYear("2012-01-06"));
		for(String s:get2daysForSql("2012-02-26")){
			System.out.println(s);
		}
//		System.out.println("===================");
//		for(String s:getWeekDays("2012-02-05")){
//			System.out.println(s);
//		}
//		System.out.println("===================");
//		for(String s:getDaysByMonth("2012-08")){
//			System.out.println(s);
//		}
	}
}    


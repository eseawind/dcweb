package com.jstrd.asdc.servlet.other;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jstrd.asdc.dao.StationDao;
import com.jstrd.asdc.util.Base64Bean;
import com.jstrd.asdc.util.StringHelper;

/**
 * @see 获取电站发电图表数据信息, 日,月,年,总计
 */
@SuppressWarnings({"serial","unchecked"})
public class StationPowerInfo extends HttpServlet {

	private StationDao stationDao;
	
	public void init() throws ServletException {
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());   
		stationDao = (StationDao) wac.getBean("stationDao");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		List<Map> dataList=null;
		String sid="";
		String date="";
		int tabid=0;
		String key="";
		String data="";
		String period="";
		
		//登录校验
		String info="";
		key = request.getParameter("key");
		period = request.getParameter("period");
		date = request.getParameter("date");
		try {
			byte[] byteArray = Base64Bean.decryptBASE64(key);
			data = new String(byteArray);
			sid = data.split("_")[1];
			info = stationDao.getStationInfoByKey(key);
			//tabid -> period
			if(period.equals("bydays")){
				tabid = 1101;
			}else if(period.equals("bymonth")){
				tabid = 1102;
			}else if(period.equals("byyear")){
				tabid = 1103;
			}else if(period.equals("bytotal")){
				tabid = 1104;	
			}
			JSONObject json = new JSONObject();
			JSONObject json1 = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			if(StringHelper.isCanQuery(info)){
				switch (tabid) {
					case 1101:
						dataList = stationDao.findStationTpList(Integer.parseInt(sid), date);
						break;
					case 1102:
						dataList = stationDao.findStationMpList(Integer.parseInt(sid), date);
						break;
					case 1103:
						dataList = stationDao.findStationYpList(Integer.parseInt(sid), date);
						break;
					case 1104:
						dataList = stationDao.findStationApList(Integer.parseInt(sid));
						break;
					default:
						dataList=null;
				}
				if(null!=dataList && dataList.size()>0){
					json.put("sid", sid);
					json.put("dataunit", dataList.get(0).get("unit").toString());
					json.put("code", "1");
					json.put("msg", "Request succeeds");
					for(int i=0; i<dataList.size(); i++){
						json1.put("time", dataList.get(i).get("time").toString());
						json1.put("no", dataList.get(i).get("no").toString());
						json1.put("value", String.valueOf(dataList.get(i).get("value")));
						jsonArray.add(json1);
					}
					json.put("data", jsonArray);
					out.println(json);
				}else{
					out.println("the station [id="+sid+"] is no data");
				}
			}else{
				json.put("code", info);
				if(info.equals("0")){
					json.put("msg", "Request timed out, please try again 10 minutes");
				}else if(info.equals("-1")){
					json.put("msg", "Key was not found");
				}
				out.print(json.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Request format error<br/>");
			out.println("Request format: http://solarcloud.zeversolar.com/stationPowerInfo?key=YWRtaW5AemV2ZXJzb2xhci5jb21fMTA2Ng==&period=bydays&date=2014-04-11");
		}
		out.flush();
		out.close();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		doPost(request, response);
	}
	
}

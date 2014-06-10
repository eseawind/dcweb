package com.jstrd.asdc.servlet.other;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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
 * @see 获取电站事件信息
 */
@SuppressWarnings({"serial","unchecked"})
public class StationEventInfo extends HttpServlet {

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
		String key="";
		String data="";
		String sdt="";
		String edt="";
		int dflag=0;
		
		//请求参数
		key = request.getParameter("key");
		try {
			byte[] byteArray = Base64Bean.decryptBASE64(key);
			data = new String(byteArray);
			sid = data.split("_")[1];
			sdt = request.getParameter("sdt");
			edt = request.getParameter("edt");
			//登录校验
			String info="";
			if(StringHelper.checkString(key)){
				info = stationDao.getStationInfoByKey(key);
			}
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			Date ds = sdf.parse(sdt);
			Date de = sdf.parse(edt);
			dflag = StringHelper.daysBetween(ds,de);
			if(dflag>7){
				info = "-2";
			}
			JSONObject json = new JSONObject();
			JSONObject json1 = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			if(StringHelper.isCanQuery(info, dflag)){
				dataList = stationDao.getStationEventPortInfo(Integer.parseInt(sid), sdt, edt);
				if(null!=dataList && dataList.size()>0){
					json.put("sid", sid);
					json.put("code", "1");
					json.put("msg", "Request succeeds");
					for(int i=0; i<dataList.size(); i++){
						json1.put("eventCode", dataList.get(i).get("did").toString());
						json1.put("ssno", dataList.get(i).get("ssno").toString());
						json1.put("eventTime", dataList.get(i).get("occdt").toString());
						json1.put("eventType", dataList.get(i).get("msgtype").toString());
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
				}else{
					json.put("msg", "Intervals not exceeding 7 days straight.");
				}
				out.print(json.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Request format error<br/>");
			out.println("Request format: http://solarcloud.zeversolar.com/stationEventInfo?key=YWRtaW5AemV2ZXJzb2xhci5jb21fMTA2Ng==&sdt=2014-04-06&edt=2014-04-11");
		} 
		out.flush();
		out.close();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
}

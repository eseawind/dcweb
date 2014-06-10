package com.jstrd.asdc.servlet.other;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jstrd.asdc.dao.StationDao;
import com.jstrd.asdc.util.Base64Bean;
import com.jstrd.asdc.util.StringHelper;

/**
 * @see 获取电站动态信息
 */
@SuppressWarnings({"serial","unchecked"})
public class StationDynamicInfo extends HttpServlet {

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
		
		Map stationM=null;
		String sid="";
		String key="";
		String data="";
		//登录校验
		String info="";
		key = request.getParameter("key");
		try {
			byte[] byteArray = Base64Bean.decryptBASE64(key);
			data = new String(byteArray);
			sid = data.split("_")[1];
			info = stationDao.getStationInfoByKey(key);
			JSONObject json = new JSONObject();
			if(StringHelper.isCanQuery(info)){
				stationM = stationDao.getStationInfoById(Integer.parseInt(sid));
				if(null!=stationM && stationM.size()>0){
					json.put("sid", sid);
					json.put("code", "1");
					json.put("msg", "Request succeeds");
					json.put("ludt", stationM.get("ludt").toString());
					Map map1 = new HashMap();
					Map map2 = new HashMap();
					Map map3 = new HashMap();
					Map map4 = new HashMap();
					Map map5 = new HashMap();
					map1.put("value", stationM.get("etoday").toString());
					map1.put("unit", stationM.get("etoday_unit").toString());
					json.put("E-Today", map1);
					map2.put("value", String.valueOf(stationM.get("emonth")));
					map2.put("unit", stationM.get("emonth_unit").toString());
					json.put("E-Month", map2);
					map3.put("value", String.valueOf(stationM.get("etotal")));
					map3.put("unit", stationM.get("etotal_unit").toString());
					json.put("E-Total", map3);
					map4.put("value", String.valueOf(stationM.get("inval")));
					map4.put("unit", stationM.get("inval_unit").toString());
					json.put("TotalYield", map4);
					map5.put("value", String.valueOf(stationM.get("Co2Val")));
					map5.put("unit", stationM.get("co2val_unit").toString());
					json.put("CO2Avoided", map5);
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
			out.println("Request format: http://solarcloud.zeversolar.com/stationDynamicInfo?key=YWRtaW5AemV2ZXJzb2xhci5jb21fMTA2Ng==");
		} 
		out.flush();
		out.close();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		doPost(request, response);
	}
	
}

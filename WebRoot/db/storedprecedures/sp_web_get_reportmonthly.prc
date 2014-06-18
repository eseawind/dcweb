create or replace procedure sp_web_get_reportmonthly(
i_stationid number,
i_reportid number,
cur_result out sys_refcursor
) is
/*================================================================
功能说明:获得月报配置信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Report Config/Monthly
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
begin
  open cur_result for select decode(state,0,1,0) state,reciverlist,rep_format,convertfenstotime(21) sendattime,ITEMSTR from tb_station_report_monthly where stationid = i_stationid and reportid = i_reportid;
end sp_web_get_reportmonthly;
/


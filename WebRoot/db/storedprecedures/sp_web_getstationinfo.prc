create or replace procedure sp_web_getstationinfo(
i_stationid in number,
cur_station out sys_refcursor
) is
/*================================================================
功能说明:获取指定电站的详细情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Plant Management
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
   open cur_station for select a.stationname,a.iconindex,to_char(a.startdt,'yyyy-mm-dd') startdt,a.totalpower,a.companyname,
   a.city,a.province,a.country,a.street,a.zip,fn_real_dms_ex(a.jd) jd,fn_real_dms_ex(a.wd) wd,a.h height,
   a.comangle,a.timezone,a.w_keyval tzkey,a.co2xs,a.gainxs,a.money currency,a.companyname company,nvl(b.account,'') admininfo,
   nvl(a.etotaloffset,0) etotaloffset,customerflag,portkey from tb_station a,tb_user b where a.masterid = b.userid(+) and stationid = i_stationid;
end sp_web_getstationinfo;
/


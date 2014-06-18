create or replace procedure sp_station_setkey(
i_stationid in number,--电站编号
i_strkey varchar2) is--更新电站Key
/*================================================================
功能说明:
    用户帐号登录--for 公共数据接口
相关WEB页面及文件
    首页登录页面
    UserDaoImpl.java
审核日期:2014-04-03
审核人:嵇长军
==================================================================*/
begin
     update tb_station set portkey = i_strkey where stationid = i_stationid;
     commit;
end sp_station_setkey;
/


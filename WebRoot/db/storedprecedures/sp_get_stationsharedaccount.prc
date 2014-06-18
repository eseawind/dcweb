create or replace procedure sp_get_stationsharedaccount(
--获取指定电站的共享帐号列表
i_stationid number,
cur_result out sys_refcursor
) is
/*================================================================
功能说明:获得指定电站的当前共享的帐号(不包括电站管理员自己的帐号)
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Shared config
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
   open cur_result for select a.userid,a.rightstr,b.account,a.mailactive state,b.firstname,b.secondname from tb_userstation a,tb_user b where a.userid=b.userid and a.stationid = i_stationid and a.roleid =1;
end sp_get_stationsharedaccount;
/


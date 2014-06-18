create or replace procedure sp_web_setstationselectstate(
i_stationid number,--电站编号
i_state number--电站状态0:未选择,1:已经选择
) is
/*================================================================
功能说明:修改电站的关注属性
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:超级管理员的电站查询功能
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
   update tb_station set isselect = i_state where stationid = i_stationid;
   commit;  
end sp_web_setstationselectstate;
/


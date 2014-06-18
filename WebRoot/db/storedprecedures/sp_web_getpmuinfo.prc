create or replace procedure sp_web_getpmuinfo(
i_psno varchar2,
cur_result out sys_refcursor) is
/*================================================================
功能说明:获得指定PMU信息详细情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:管理员功能之监控器查询
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
   open cur_result for select usedspace,totalspace,state,softver,hardwver,llip,to_char(lldt,'yyyy-mm-dd hh24:mi:ss')lldt from tb_pmu where psno = upper(i_psno);
end sp_web_getpmuinfo;
/


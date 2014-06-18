create or replace procedure sp_web_getpmutypelist(
cur_typelist out sys_refcursor,
cur_subtypelist out sys_refcursor) is
/*================================================================
功能说明:获得系统PMU设备类型列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:管理员之监控嚣查询页面
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
  open cur_typelist for select distinct nvl(devname,'未定义') TName from tb_pmu where pmutype is not null;--'PMU PRO' TName from dual union select 'PMU' TName from dual;
  open cur_subtypelist for select distinct subtype TName from tb_pmu where subtype is not null;--'1.0' TName from dual union select '2.0' TName from dual;
end sp_web_getpmutypelist;
/


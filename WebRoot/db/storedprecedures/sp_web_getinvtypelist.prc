create or replace procedure sp_web_getinvtypelist(
cur_typelist out sys_refcursor) is
/*================================================================
功能说明:获得当前逆变器类型列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:超级管理员功能中的,Inverter Config
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
  open cur_typelist for select distinct trim(devtypename) devtypename from (select distinct devtypename from tb_inverter) where devtypename is not null;
end sp_web_getinvtypelist;
/


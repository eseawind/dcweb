create or replace procedure sp_web_setpmubyname(i_ssno varchar2,i_byname varchar2) is
/*================================================================
功能说明:设置设备别名(包括PMU,ISNO)
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Device management
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
  update tb_pmu  set byname = i_byname where psno = i_ssno;
  update tb_inverter set byname = i_byname where isno = i_ssno;
  commit;
end sp_web_setpmubyname;
/


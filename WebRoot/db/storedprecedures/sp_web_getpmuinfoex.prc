create or replace procedure sp_web_getpmuinfoex(
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
   open cur_result for select nvl(b.stationname,'未绑定') stationname,a.psno,a.idex,a.devname pmutype,a.subtype,nvl(a.usedspace,0) ||'M' usedspace,nvl(a.totalspace,0) ||'M' totalspace ,a.state,a.softver,a.hardwver,nvl(a.llip,'未知') llip,nvl(to_char(a.lldt,'yyyy-mm-dd hh24:mi:ss'),'未知') lldt,a.upa,a.upn,a.curgate from tb_pmu a,tb_station b where a.stationid = b.stationid(+) and psno = upper(i_psno);
end sp_web_getpmuinfoex;
/


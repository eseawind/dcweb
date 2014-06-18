create or replace procedure sp_web_getdeviceInfo(
i_ssno varchar2, --设备序列号
cur_result out sys_refcursor
) is
/*================================================================
功能说明:自动根据设备类型显示设备相关信息
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
open cur_result for select psno ssno,1 TypeName,devname DeviceName,subtype XH,Factory,penpai PP,softver SoftVer,hardwver HardwareVer from tb_pmu  where upper(psno) = upper(i_ssno) union
select isno ssno,2 TypeName,devname DeviceName,devtypename XH,factoryname Factory,penpai PP,softver SoftVer,hardver HardwareVer from tb_inverter where upper(isno) = upper(i_ssno);
end sp_web_getdeviceInfo;
/


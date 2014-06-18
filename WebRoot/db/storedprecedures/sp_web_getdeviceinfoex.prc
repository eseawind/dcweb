create or replace procedure sp_web_getdeviceInfoex(
i_ssno varchar2, --设备序列号
cur_result out sys_refcursor
) is
/*================================================================
功能说明:自动根据设备类型显示设备相关信息(2013-4修改，添加e_total逆变器读数数据项
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Config/Device management
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2013-04-03
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
v_e_total number;
begin
  select count(1) into v_rownum from tb_pmu where upper(psno) = upper(i_ssno);
  if v_rownum > 0 then
     select nvl(sum(e_total),0) into v_e_total from tb_inverter where upper(psno) =upper(i_ssno);
     open cur_result for
          select psno ssno,1 TypeName,decode(devname,'nvl',null,'null',null,devname) DeviceName,subtype XH,fn_get_val_kwh(v_e_total)||fn_get_unit_kwh(v_e_total) e_total,decode(Factory,'nvl',null,'null',null,Factory) Factory,decode(penpai,'nvl',null,'null',null,penpai) PP,decode(softver,'nvl',null,'null',null,softver) SoftVer,hardwver HardwareVer from tb_pmu  where upper(psno) = upper(i_ssno);
  else
    open cur_result for
         select isno ssno,2 TypeName,decode(devname,'nvl',null,'null',null,devname) DeviceName,devtypename XH,fn_get_val_kwh(nvl(e_total,0))||fn_get_unit_kwh(nvl(e_total,0)) e_total,decode(factoryname,'nvl',null,'null',null,factoryname) Factory,decode(penpai,'nvl',null,'null',null,penpai) PP,decode(softver,'nvl',null,'null',null,softver) SoftVer,decode(hardver,'nvl',null,'null',null,hardver) HardwareVer
 from tb_inverter where upper(isno) = upper(i_ssno);
  end if;
end sp_web_getdeviceInfoex;
/


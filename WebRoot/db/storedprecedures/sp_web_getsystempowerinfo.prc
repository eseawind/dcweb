create or replace procedure sp_web_getsystempowerinfo(
cur_result out sys_refcursor--输出结果集
   ) is
/*================================================================
功能说明:获得系统全局发电量统计信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:网站首页
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
 v_co2rate number;--
v_stationnum_yesterday number;
v_stationnum number;
v_power_yesterday number;
v_power_total number;
v_co2_yesterday number;
v_co2_total number;

begin
  select nvl(count(1),0) into v_stationnum_yesterday from tb_station where trunc(createdt) = trunc(sysdate-1);
  select nvl(count(1),0) into v_stationnum from tb_station;
  select nvl(sum(e_today),0),nvl(sum(e_total),0) into v_power_yesterday,v_power_total from tb_invdaily where trunc(recvdate) = trunc(sysdate-1);
  select nvl(sum(e_today),0) into v_power_total from tb_invdaily;
  v_Co2Rate := to_number(fn_get_sys_param('sys_default','co2rate','0.0'));
  v_co2_yesterday :=v_power_yesterday * v_co2rate;
  v_co2_total :=v_power_total *  v_co2Rate;
  open cur_result for select v_stationnum_yesterday station_last,v_stationnum station_total,
                             fn_get_val_kwh(v_power_yesterday) e_last,fn_get_unit_kwh(v_power_yesterday) e_last_u,
                             fn_get_val_kwh(v_power_total) e_total,fn_get_unit_kwh(v_power_total) e_total_u,
                             fn_get_val_weight(v_co2_yesterday) co2_last,fn_get_unit_weight(v_co2_yesterday) co2_last_u,
                             fn_get_val_weight(v_co2_total) co2_total,fn_get_unit_weight(v_co2_total) co2_total_u from dual;
end sp_web_getsystempowerinfo;
/


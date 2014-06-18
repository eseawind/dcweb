create or replace procedure sp_get_system_powerinfo_unit(
   cur_result out sys_refcursor) is
 v_co2rate number;--
 v_stationnum_yesterday number;--昨天创建电站数
   v_power_yesterday number;--昨天发电量
   v_co2_yesterday number;--昨天二氧公碳减排
   v_stationnum number;--电站总数
   v_power_total number;--累计发电量
   v_co2_total number;
begin
  select nvl(count(1),0) into v_stationnum_yesterday from tb_station where trunc(createdt) = trunc(sysdate-1);
  select nvl(count(1),0) into v_stationnum from tb_station;
  select nvl(sum(e_today),0),nvl(sum(e_total),0) into v_power_yesterday,v_power_total from tb_invdaily where trunc(recvdate) = trunc(sysdate-1);
  select nvl(sum(e_total),0) into v_power_total from tb_inverter;
  v_Co2Rate := to_number(fn_get_sys_param('sys_default','co2rate','0.0'));
  v_co2_yesterday :=v_power_yesterday * v_co2rate;
  v_co2_total :=v_power_total *  v_co2Rate;
  open cur_result for select v_stationnum_yesterday stationnum_yesterday,v_stationnum stationnum_total,
  fn_get_val_kwh(v_power_yesterday) e_yesterday,fn_get_unit_kwh(v_power_yesterday) e_yesterday_unit,
  fn_get_val_kwh(v_power_total) e_todal,fn_get_unit_kwh(v_power_total) e_total_unit,
  fn_get_val_weight(v_co2_yesterday) co2_yesterday,fn_get_unit_weight(v_co2_yesterday) co2_yesterday_unit,
  fn_get_val_weight(v_co2_total) co2_total,fn_get_unit_weight(v_co2_total) co2_total_unit from dual;
end sp_get_system_powerinfo_unit;
/


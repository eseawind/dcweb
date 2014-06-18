create or replace procedure sp_get_system_powerinfo(
   o_stationnum_yesterday out number,--昨天创建电站数
   o_power_yesterday out number,--昨天发电量
   o_co2_yesterday out number,--昨天二氧公碳减排
   o_stationnum out number,--电站总数
   o_power_total out number,--累计发电量
   o_co2_total out number) is
 v_co2rate number;--
begin
  select nvl(count(1),0) into o_stationnum_yesterday from tb_station where trunc(createdt) = trunc(sysdate-1);
  select nvl(count(1),0) into o_stationnum from tb_station;
  select nvl(sum(e_today),0),nvl(sum(e_total),0) into o_power_yesterday,o_power_total from tb_invdaily where trunc(recvdate) = trunc(sysdate-1);
  select nvl(sum(e_total),0) into o_power_total from tb_inverter;
  v_Co2Rate := to_number(fn_get_sys_param('sys_default','co2rate','0.0'));
  o_co2_yesterday :=o_power_yesterday * v_co2rate;
  o_co2_total :=o_power_total *  v_co2Rate;
end sp_get_system_powerinfo;
/


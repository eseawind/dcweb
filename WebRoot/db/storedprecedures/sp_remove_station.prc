create or replace procedure sp_remove_station(
i_stationid number) is
--É¾³ýÖ¸¶¨µçÕ¾
begin
  delete tb_station_report_daily where stationid = i_stationid;
  delete tb_station_report_monthly where stationid = i_stationid;
  delete tb_station_report_event where stationid = i_stationid;
  delete tb_userstation where stationid = i_stationid;
  update tb_pmu set stationid = null where stationid = i_stationid;
  delete tb_station where stationid = i_stationid;
  commit;
end sp_remove_station;
/


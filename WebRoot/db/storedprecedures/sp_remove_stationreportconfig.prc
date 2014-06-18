create or replace procedure sp_remove_stationreportconfig(
i_stationid number--µÁ’æ±‡∫≈
) is
begin
  delete tb_station_report_daily where stationid = i_stationid;
  delete tb_station_report_monthly where stationid = i_stationid;
  delete tb_station_report_event where stationid = i_stationid;
  commit;
end sp_remove_stationreportconfig;
/


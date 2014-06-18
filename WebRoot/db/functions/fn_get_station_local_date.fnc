create or replace function fn_get_station_local_date(i_stationid number) return date is
  Result date;
  --??£¿£¿???®š£¿£¿£¿£¿?£¿?£¿??¦Á£¿£¿?
--i_StationID:?®š?£¿
  v_timezone number;
begin
  select nvl(timezone,8) into v_timezone from tb_station where stationid = i_stationid;
  result:=GetLocalCurrentDatetime(v_timezone);
  return(Result);
end fn_get_station_local_date;
/


create or replace function fn_get_station_today_table(i_stationid number) return varchar2 is
v_curdate date;--?®š£¿£¿£¿£¿??£¿£¿?
v_timezone number;
  Result varchar2(60);
begin
  select timezone into v_timezone from tb_station where stationid = i_stationid;
  select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
  Result:='tb_inv' || to_char(v_curdate,'yyyymmdd');
  return(Result);
end fn_get_station_today_table;
/


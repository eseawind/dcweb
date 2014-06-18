create or replace function fn_getstationpmuonlinenum(i_stationid number) return number is
  Result number;
begin
  select count(1) into result from tb_pmu where state = 1 and stationid = i_stationid;
  return(Result);
end fn_getstationpmuonlinenum;
/


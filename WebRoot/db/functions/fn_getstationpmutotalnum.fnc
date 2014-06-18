create or replace function fn_getstationpmutotalnum(i_stationid number) return number is
  Result number;
begin
  select count(1) into result from tb_pmu where stationid = i_stationid;
  return(Result);
end fn_getstationpmutotalnum;
/


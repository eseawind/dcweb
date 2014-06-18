create or replace function fn_get_station_e_today(
i_stationid number
) return number is
--
v_curdate date;--?®š£¿£¿£¿£¿??£¿£¿?
v_timezone number;
v_tablename varchar2(32);--??£¿?²Ó£¿£¿?£¿£¿?£¿
v_today number;
begin
  select timezone into v_timezone from tb_station where stationid = i_stationid;
  select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
  v_tablename:='tb_inv' || to_char(v_curdate,'yyyymmdd');
  execute immediate
            'select nvl(sum(e_today),0) from (select max(e_today) e_today,isno from '||v_tablename ||' where stationid = :stationid_ group by isno)'
       into v_today using i_stationid;
  return v_today;
end fn_get_station_e_today;
/


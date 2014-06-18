create or replace function fn_get_inv_e_today(i_isno varchar2,i_stationid number) return number is
--???£¿ÌÀ£¿§Ó?§Ü£¿?£¿??£¿???²Ó
v_curdate date;--?®š£¿£¿£¿£¿??£¿£¿?
v_timezone number;
v_tablename varchar2(32);--??£¿?²Ó£¿£¿?£¿£¿?£¿
v_today number;
v_r number;
begin

  select timezone into v_timezone from tb_station where stationid = i_stationid;
  select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
  v_tablename:='tb_inv' || to_char(v_curdate,'yyyymmdd');
  execute immediate 'select count(1) from '||v_tablename||' where isno = :isno_' into v_r using i_isno;
  if v_r>0 then
     execute immediate 'select max(e_today) e_today from '||v_tablename ||' where isno = :isno__'
       into v_today using i_isno;
  else
      v_today:=0;
  end if;
  return v_today;
end fn_get_inv_e_today;
/


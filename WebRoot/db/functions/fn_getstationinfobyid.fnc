create or replace function FN_GETSTATIONINFOBYID (v_stationid number,v_date varchar2) return sys_refcursor
--exec :a:=FN_GETSTATIONINFOBYID(1,'2012-02-10');
--ETODAY,EMONTH,EYEAR,ETOTAL,CO2RATE,INRATE,BGURL
as
v_etoday number;
v_EMonth number;
v_EYear number;
v_ETotal Number;
v_querydate date;
v_tablename varchar2(32);
v_sql varchar2(1000);
v_Co2Rate Number;
v_InRate Number;
v_Pic varchar2(1000);
cur sys_refcursor;
begin
    v_querydate := to_date(v_date,'yyyy-mm-dd');
    v_tablename :='tb_inv'||to_char(v_querydate,'yyyymmdd');
  select co2xs,gainxs,bgurl into v_Co2Rate,v_InRate,v_pic from tb_station where stationid = v_stationid;
  select sum(e_today) into v_emonth from tb_invdaily where to_char(recvdate,'yyyy-mm') = to_char(v_querydate,'yyyy-mm') and stationid = v_Stationid;
  select sum(e_today) into v_eyear from tb_invdaily where to_char(recvdate,'yyyy') = to_char(v_querydate,'yyyy') and stationid = v_Stationid;
  v_sql:='select sum(e_fen10) e_today from '|| v_tablename ||' where stationid = '|| v_stationid;
  execute immediate v_sql into v_etoday;
  select max(e_total) into v_etotal from tb_invdaily where stationid = v_Stationid;
  open cur for select nvl(v_etoday,0) etoday,nvl(v_emonth,0) emonth,nvl(v_eyear,0) eyear,nvl(v_etotal,0) etotal,v_Co2Rate Co2Rate,v_InRate InRate,v_pic BGURL from dual;
  return cur;
end FN_GETSTATIONINFOBYID;
/


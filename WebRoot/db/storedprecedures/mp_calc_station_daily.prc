create or replace procedure mp_calc_station_daily(
i_stationid number,--µÁ’æ±‡∫≈
i_date varchar2
) is
v_tablename varchar2(50);
v_querydate date;
  v_sql varchar2(2000);
begin
  v_querydate:=to_date(i_date,'yyyy-mm-dd');
  v_tablename:='tb_inv'||to_char(v_querydate,'yyyymmdd');
  v_sql:='insert into  tb_invdaily( psno,isno,stationid,recvdate,e_today,e_total,h_today,h_total)
                      select psno,isno,:stationid_,:v_querydate_,max(e_today),max(e_total),
                      max(h_total)-min(h_total),max(h_total) from ' || v_tablename ||' where stationid = :stationid__ group by isno,psno';
         EXECUTE IMMEDIATE v_sqL using i_stationid,trunc(v_querydate),i_stationid;
         commit;
end mp_calc_station_daily;
/


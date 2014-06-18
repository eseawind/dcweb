create or replace procedure sp_get_station_power_daily2(
i_stationid number,--电站编号
i_yearmonthday in varchar2,--查询日期yyyy-mm-dd
o_sumstr out varchar2,
cur_power out sys_refcursor
) is
--获取指定日期的发电量详细信息
v_querydate date;
v_tablename varchar(30);
v_maxpac number;
v_unit varchar2(16);
v_rate number;
v_today number;
v_sql varchar2(1000);
begin
  v_querydate := to_date(i_yearmonthday,'yyyy-mm-dd');
  v_tablename:='tb_inv' || to_char(v_querydate,'yyyymmdd');
  select sum(pacmax) into v_maxpac from tb_inverter where stationid = i_stationid;
  execute immediate 'select nvl(sum(e_today),0) from (select max(e_today) e_today,isno from '||v_tablename||' where stationid = :stationid_ group by isno)' into v_today using i_stationid;
  o_sumstr:=to_char(fn_get_val_kwh(v_today),'fm9999990.099')||fn_get_unit_kwh(v_today);
  execute immediate 'truncate table tmp_info';
  v_sql := 'insert into tmp_info(sv1,nv1,nv2)
               select fn_gettimebyfen10(a.idd) rtime,a.idd fen10,nvl(b.pac,0) pac from
                           tb_serial a,
                           ( select  fen10,sum(pac) pac from
                                     ( select isno,fen10,round(avg(pac),1) pac from  ' || v_tablename||'
                                             where stationid = :stationid__ group by isno,fen10 )
                                     group by fen10 order by fen10) b
                 where a.idd = b.fen10(+) order by fen10 asc';
   execute immediate v_sql using i_stationid;
   commit;
   select max(nv2) into v_maxpac from tmp_info;
  v_rate:=fn_get_rate_power(v_maxpac,v_unit);
   open cur_power for select sv1 rtime,nv1 fen10,round(nv2/v_rate,3) pac,v_unit unit from tmp_info;
end sp_get_station_power_daily2;
/


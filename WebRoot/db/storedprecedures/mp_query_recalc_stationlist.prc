create or replace procedure mp_query_recalc_stationlist(
--查询需要手工统计的电站
i_date varchar2,--重算日期
i_daynum int,--指定日期前几天数据
curmain    out sys_refcursor
) is
v_tablename varchar2(32);
v_querydate date;
v_sql       varchar2(1000);
begin
  execute immediate 'truncate table tmp_info';
  v_querydate := to_date(i_date,'yyyy-mm-dd') - i_daynum+1;
  for daynum in 1 .. i_daynum loop
     v_tablename := 'tb_inv' || to_char(v_querydate, 'yyyymmdd');
     --
     v_sql:='insert into tmp_info(idd,sv1) select a.stationid,'''||to_char(v_querydate,'yyyy-mm-dd')||''' from (select distinct stationid from '
         ||v_tablename ||') a where a.stationid not in ('||
         'select distinct stationid from tb_invdaily where to_char(recvdate,''yyyy-mm-dd'') = '''||
             to_char(v_querydate,'yyyy-mm-dd')||''')';
     execute immediate v_sql;
     v_querydate:= v_querydate + 1;
  end loop;
  open curmain for select a.idd stationid,a.sv1 recvdate,b.stationname from tmp_info a,tb_station b where a.idd=b.stationid;
end mp_query_recalc_stationlist;
/


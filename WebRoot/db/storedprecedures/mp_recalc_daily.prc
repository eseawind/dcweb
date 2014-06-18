create or replace procedure mp_recalc_daily(
--重新计算指定电站指定日期日统计数据
i_stationid number,--电站编号
i_date varchar2--重算日期
) is
v_date date;
v_tablename varchar2(50);
v_sql varchar2(2000);
begin
  if length(i_date)>10 then
     v_date :=to_date(i_date,'yyyy-mm-dd hh24:mi:ss');
  else
     v_date :=to_date(i_date,'yyyy-mm-dd');
  end if;
  v_tablename:='tb_inv'||to_char(v_date,'yyyymmdd');
  delete tb_invdaily where stationid = i_stationid and recvdate = trunc(v_date);
  v_sql:='insert into  tb_invdaily( psno,isno,stationid,recvdate,e_today,e_total,h_today,h_total)
                      select psno,isno,stationid,:recvdate_,max(e_today),max(e_total),
                      max(h_total)-min(h_total),max(h_total) from ' || v_tablename ||'  where stationid=:stationid_ group by isno,psno,stationid';
  EXECUTE IMMEDIATE v_sqL using trunc(v_date),i_stationid;
  commit;
end mp_recalc_daily;
/


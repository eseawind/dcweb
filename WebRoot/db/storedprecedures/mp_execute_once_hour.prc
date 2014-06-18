create or replace procedure mp_execute_once_hour is
--一小时执行一次
v_hour number;
v_timezone number;
v_date date;
v_tablename varchar2(50);
v_sql varchar2(2000);
begin
    select to_number(to_char(sysdate,'hh24')) into v_hour from dual;
    if v_hour <=21 then
       v_timezone:=9-v_hour;
    else
       v_timezone:=33-v_hour;
    end if;
    v_date:=getlocalcurrentdatetime(v_timezone)-1;
    --防止重复调用,清除原有的
    delete tb_invdaily where  recvdate = trunc(v_date) and stationid in (select stationid from tb_station where timezone between v_timezone and (v_timezone+0.9));
    commit;
    v_tablename:='tb_inv'||to_char(v_date,'yyyymmdd');
    v_sql:='insert into  tb_invdaily( psno,isno,stationid,recvdate,e_today,e_total,h_today,h_total)
                      select psno,isno,stationid,:recvdate_,max(e_today),max(e_total),
                      max(h_total)-min(h_total),max(h_total) from ' || v_tablename ||'  where timezone between :timezone_ and :timezone__ group by isno,psno,stationid';
   EXECUTE IMMEDIATE v_sqL using trunc(v_date),v_timezone,v_timezone+0.9;
   --用户帐号的计数器复位
   update tb_user set LOGINTODAYTIMES=0,LOGINFAILEDTIMES=0 where timezone between v_timezone and v_timezone+0.9;
   commit;
end mp_execute_once_hour;
/


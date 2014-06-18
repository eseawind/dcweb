create or replace procedure sp_dcg_startup(
i_dcgatename varchar2
) is
--DCG网关启动事件
v_curdate date;--电站所在时区当前时间
begin
   for cut in(select psno,stationid from tb_pmu where upper(curgate) = upper(i_dcgatename) and state = 1) loop
      v_curdate:=fn_get_station_local_date(cut.stationid);--获得该电站的所在时区的当前时间
      sp_dcg_pmu_offlineex(cut.stationid,cut.psno,v_curdate);
   end loop;
end sp_dcg_startup;
/


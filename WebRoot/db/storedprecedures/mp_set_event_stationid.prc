create or replace procedure mp_set_event_stationid is
v_rownum number;
v_stationid number;
begin
  for curt in (select distinct ssno from tb_event_all) loop
     select count(1) into v_rownum from tb_pmu where psno = curt.ssno;
     if v_rownum >0 then
         select stationid into v_stationid from tb_pmu where psno = curt.ssno;
         update tb_event_all set stationid = v_stationid,devt=1 where ssno = curt.ssno;
         commit;
     end if;
     select count(1) into v_rownum from tb_inverter where isno=curt.ssno;
     if v_rownum >0 then
         select stationid into v_stationid from tb_inverter where isno = curt.ssno;
         update tb_event_all set stationid = v_stationid,devt=2 where ssno = curt.ssno;
         commit;
     end if;
  end loop;
end mp_set_event_stationid;
/


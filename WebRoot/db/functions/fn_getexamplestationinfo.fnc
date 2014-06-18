create or replace function fn_GetExampleStationInfo return sys_refcursor
--获得指定用户id的当前电话列表及部分统计信息
--STATIONID,STATIONNAME,INVNUM,PMUNUM,E_TOTAL,H_TOTAL
as
     cur sys_refcursor;
     v_etotal number;
     v_htotal number;
     v_invnum number;
     v_pmunum number;
     cursor curstation is select stationid,stationname from tb_station where stationid in(select stationid from tb_userstation where sharet = 1);
begin--delete tmp_stationinfo;
     EXECUTE IMMEDIATE  'truncate table tmp_stationinfo';
     for cur_result in curstation loop
         --select nvl(sum(e_total),0),nvl(sum(h_total),0),count(1) into v_etotal,v_htotal,v_invnum from tb_inverter where stationid = cur_result.stationid;
         select count(1) into v_invnum from tb_inverter where stationid = cur_result.stationid;
         select nvl(sum(e_today),0),nvl(sum(h_today),0) into v_etotal,v_htotal from tb_invdaily where stationid = cur_result.stationid;
         select count(1) into v_pmunum from tb_pmu where stationid  = cur_result.stationid;
         insert into tmp_stationinfo(stationid,stationname,invnum,pmunum,e_total,h_total) values(cur_result.stationid,cur_result.stationname,v_invnum,v_pmunum,v_etotal,v_htotal);
     end loop;
     commit;
     open cur for select * from tmp_stationinfo;
     return cur;
end;
/


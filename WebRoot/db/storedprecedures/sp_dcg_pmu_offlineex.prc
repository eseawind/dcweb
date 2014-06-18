create or replace procedure sp_dcg_pmu_offlineex(
--PMU离线执行的存储过程
i_stationid number,--电站编号
i_psno varchar2,--PMU序列号
i_occdt varchar2--断线时刻
) is
v_curdate date;--电站所在时区当前时间
begin
  --
  v_curdate:=fn_get_station_local_date(i_stationid);--获得该电站的所在时区的当前时间
      insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,300,0,0);--插入PMU离线记录
        for curt in (select isno from tb_inverter where psno = upper(i_psno) and state = 1) loop
            insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag,insdt) 
               values(seq_invevent_id.nextval,i_stationid,
            curt.isno,2,v_curdate,1,0,0,0,sysdate);
        end loop;
        update tb_inverter set state = 0 where psno = upper(i_psno);--更新当前PSNO下的所有逆变器状态为离线状态，但登录时，并不更新由PMU自己发送上线状态后，再更新
        update tb_pmu set state = 0 where psno = upper(i_psno);--更新PMU状态
        commit;
end sp_dcg_pmu_offlineex;
/


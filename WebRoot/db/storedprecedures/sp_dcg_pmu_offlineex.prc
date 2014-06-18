create or replace procedure sp_dcg_pmu_offlineex(
--PMU����ִ�еĴ洢����
i_stationid number,--��վ���
i_psno varchar2,--PMU���к�
i_occdt varchar2--����ʱ��
) is
v_curdate date;--��վ����ʱ����ǰʱ��
begin
  --
  v_curdate:=fn_get_station_local_date(i_stationid);--��øõ�վ������ʱ���ĵ�ǰʱ��
      insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,300,0,0);--����PMU���߼�¼
        for curt in (select isno from tb_inverter where psno = upper(i_psno) and state = 1) loop
            insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag,insdt) 
               values(seq_invevent_id.nextval,i_stationid,
            curt.isno,2,v_curdate,1,0,0,0,sysdate);
        end loop;
        update tb_inverter set state = 0 where psno = upper(i_psno);--���µ�ǰPSNO�µ����������״̬Ϊ����״̬������¼ʱ������������PMU�Լ���������״̬���ٸ���
        update tb_pmu set state = 0 where psno = upper(i_psno);--����PMU״̬
        commit;
end sp_dcg_pmu_offlineex;
/


create or replace procedure sp_dcg_eventEx(
i_stationid number,--��վ���
i_occdt varchar2,--��������ʱ��
i_ssno varchar2,--�豸���к�
i_eve_type number,--�¼�����
i_eve_code number,--�¼�����
i_devt number,--�豸����
o_Recid out number--�����ǰ������ļ�¼���
) is
--DCG�����¼��ϴ��洢����
begin
  insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_ssno),i_devt,to_date(i_occdt,'yyyy-mm-dd hh24:mi:ss'),
                     i_eve_type,i_eve_code,0,0);
--Eve_type=1,��������¼��������޸��������״̬(1:���ߣ�0:����)
  if i_eve_type = 1  then --��Ϣ����
    if i_eve_code = 0 then --����
      update tb_inverter set state = 0 where isno = upper(i_ssno);
    elsif i_eve_code =1 then  --����
       update tb_inverter set state = 1 where isno = upper(i_ssno);
    end if;
  end if;
  commit;
  if i_eve_code = 312 then--�����¼������¼����վ������
     mp_recalc_daily(i_stationid,i_occdt);
  end if;
  select SEQ_INVEVENT_ID.currval  into o_recid from dual;
end sp_dcg_eventEx;
/

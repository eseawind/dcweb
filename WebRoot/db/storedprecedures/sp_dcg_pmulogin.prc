create or replace procedure sp_dcg_pmulogin(
i_psno varchar2,--pmu ���к�
i_idex out varchar2,--pmu�豸���к�
i_clientip varchar2,--pmu ip��ַ
o_stationid out number,
o_timezone out number,--��վ����ʱ��
o_result out varchar2 --��¼���
) is
v_idex varchar2(60);
v_rownum number;
v_stationid number;
v_curdate date;--��վ����ʱ����ǰʱ��

begin
   select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
   if v_rownum >0 then
      select nvl(stationid,0),idex into v_stationid,v_idex from tb_pmu where psno = upper(i_psno);
      if v_stationid >0 then--�Ѿ��󶨵�վ��PMU
         if  true then --v_idex = i_idex  ��δ�ж���֤�벿��
           v_curdate:=fn_get_station_local_date(v_stationid);--��øõ�վ������ʱ���ĵ�ǰʱ��
            update tb_pmu set state = 1,llip = i_clientip,lldt=v_curdate,ludt=v_curdate where psno = upper(i_psno);
            insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     v_stationid,upper(i_psno),1,v_curdate,
                     1,301,0,0);--����PMU�����¼���¼
            commit;
            select nvl(timezone,8) into o_timezone from tb_station where stationid = v_stationid;
            o_stationid :=v_stationid;
            o_result:='ok';--��¼�ɹ�
         else
            o_result:='err_idex';--��չ�����
         end if;
      else
        o_result:='err_nobind';--PMUδ��
      end if;
   else
      o_result:='err_psno';--PMU�����кŲ�����
   end if;
end sp_dcg_pmulogin;
/


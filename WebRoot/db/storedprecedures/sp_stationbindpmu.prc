create or replace procedure sp_stationbindpmu(
i_stationid in number,--��վ���
i_psno in varchar2,--pmu���к�
i_serial varchar2,--pmu��֤���ʽΪ:xxxx-xxxx-xxxx-xxxx
i_opdate varchar2,
o_result out varchar2) is
/*================================================================
����˵��:��վ��PMU����
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:������վ�������վ�󣬰��µ�PMU����
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_r1 number;
v_r2 number;
v_idex varchar2(64);
v_oldid number;
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   select count(1) into v_r1 from tb_station where stationid = i_stationid;
   select count(1)into v_r2 from tb_pmu where psno = upper(i_psno);
   if v_r1 > 0 and v_r2 >0 then
      select nvl(stationid,0),idex into v_oldid,v_idex from tb_pmu where psno = upper(i_psno);
      if v_oldid=0 then
         if v_idex = i_serial then --v_idex = i_serial
           update tb_pmu set stationid = i_stationid where psno = upper(i_psno);
           update tb_inverter set stationid = i_stationid  where upper(psno) = upper(i_psno);
         --v_curdate:=fn_get_station_local_date(i_stationid);--��øõ�վ������ʱ���ĵ�ǰʱ��
         v_curdate:= to_date(i_opdate,'yyyy-MM-dd hh24:mi:ss');
           insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,303,0,0);--PMU���¼�
           commit;
           o_result:='ok';
         else
           o_result:='err_serial';
         end if;
      else
         o_result:='err_usednow';
      end if;
   else
      o_result:='err_notexists';
   end if;
end sp_stationbindpmu;
/


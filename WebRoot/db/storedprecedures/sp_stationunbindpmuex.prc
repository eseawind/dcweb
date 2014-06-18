create or replace procedure sp_stationunbindpmuex(
i_stationid number,
i_psno varchar2,
i_idex varchar2,
i_opdate varchar2,
o_result out varchar2
) is
/*================================================================
����˵��:��վPMU����󶨹�ϵ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Device management
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_rownum number;
v_curdate date;--��վ����ʱ����ǰʱ��
begin
   if i_stationid is not null and i_idex is not null and  i_psno is not null and length(i_psno) >2 then
      select count(1) into v_rownum from tb_pmu where stationid = i_stationid and psno = upper(i_psno) and i_idex = idex;
      if v_rownum >0 then
         update tb_inverter set /*stationid = null,*/psno = null where psno = upper(i_psno);
         update tb_pmu set stationid = null where psno = upper(i_psno);
         --v_curdate:=fn_get_station_local_date(i_stationid);--��øõ�վ������ʱ���ĵ�ǰʱ��
         v_curdate:= to_date(i_opdate,'yyyy-MM-dd hh24:mi:ss');
         insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag) values (
                     SEQ_INVEVENT_ID.nextval,
                     i_stationid,upper(i_psno),1,v_curdate,
                     1,302,0,0);--����PMU�����¼���¼
         insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
             values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',100,-1,-1,'stationid='|| trim(to_char(i_stationid,'99999999'))||';psno='|| i_psno||';');
         commit;
         o_result:='ok';
      else
         o_result:='err_psno_idex';
      end if;
   else
        o_result:='err_itemempty';
   end if;
end sp_stationunbindpmuex;
/


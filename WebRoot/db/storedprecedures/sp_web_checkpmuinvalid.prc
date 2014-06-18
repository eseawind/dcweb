create or replace procedure sp_web_checkpmuinvalid(
i_psno varchar2,--PMU���к�
i_idex varchar2,--ע����
o_result out varchar2--�����
) is
/*================================================================
����˵��:������վ����PMUʱ����������PMU��Ϣ�Ƿ���ȷ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:������վ����PMU�������PMU
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
v_stationid number;
v_idex varchar2(60);
begin
  select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
  if v_rownum >0 then
       select stationid,idex into v_stationid,v_idex from tb_pmu where psno = upper(i_psno);
       if v_stationid is null then
            if v_idex = i_idex then
                o_result:='ok';
            else
                o_result:='err_idex';
            end if;
       else
                 o_result:='err_used';
       end if;

  else
      o_result:='err_nofound';
  end if;

end sp_web_checkpmuinvalid;
/


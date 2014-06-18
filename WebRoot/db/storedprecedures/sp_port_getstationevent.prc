create or replace procedure sp_port_getstationevent (
i_stationid number,--��վ���
i_dts varchar2 default null,--��ʼ����
i_dte varchar2 default null,--��������
cur_result out sys_refcursor--��������
) is
/*˵��:
��Թ������ݽӿ��ṩ�ĵ�վ�¼���ѯ*/
v_dts date;
v_dte date;
begin
     v_dts:=to_date(i_dts||' 00:00:00','yyyy-mm-dd hh24:mi:ss');
      v_dte:=to_date(i_dte||' 23:59:59','yyyy-mm-dd hh24:mi:ss');
----1:��Ϣ��2:����,3:����
   open cur_result for select did,ssno,occdt,val1 msgtype,val2 err_code from tb_event_all where stationid = i_stationid and occdt between v_dts and v_dte;
end sp_port_getstationevent;
/


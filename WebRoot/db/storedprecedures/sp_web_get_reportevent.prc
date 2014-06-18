create or replace procedure sp_web_get_reportevent(
i_stationid number,
cur_result out sys_refcursor
) is
/*================================================================
����˵��:����¼�����������Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Report Config/Event
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
begin
  open cur_result for select decode(state,0,1,0) state,reciverlist,rep_format,nextdelay,decode(emptysend,0,1,0) emptysend,maxeventlimit,ITEMSTR from tb_station_report_event where stationid = i_stationid;
end sp_web_get_reportevent;
/


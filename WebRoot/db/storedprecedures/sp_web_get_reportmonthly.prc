create or replace procedure sp_web_get_reportmonthly(
i_stationid number,
i_reportid number,
cur_result out sys_refcursor
) is
/*================================================================
����˵��:����±�������Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Report Config/Monthly
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
  open cur_result for select decode(state,0,1,0) state,reciverlist,rep_format,convertfenstotime(21) sendattime,ITEMSTR from tb_station_report_monthly where stationid = i_stationid and reportid = i_reportid;
end sp_web_get_reportmonthly;
/


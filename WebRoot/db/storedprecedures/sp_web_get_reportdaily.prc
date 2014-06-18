create or replace procedure sp_web_get_reportdaily(
i_stationid number,--��վ���
i_reportid number,--���ñ��
cur_result out sys_refcursor
) is
/*================================================================
����˵��:����ձ���������Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Report Config/Daily
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
  open cur_result for select decode(state,0,1,0) state,reciverlist,rep_format,convertfenstotime(sendattime) sendattime,ITEMSTR from tb_station_report_daily where stationid = i_stationid and reportid = i_reportid;
end sp_web_get_reportdaily;
/


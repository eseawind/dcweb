create or replace procedure sp_web_setstationselectstate(
i_stationid number,--��վ���
i_state number--��վ״̬0:δѡ��,1:�Ѿ�ѡ��
) is
/*================================================================
����˵��:�޸ĵ�վ�Ĺ�ע����
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��������Ա�ĵ�վ��ѯ����
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
   update tb_station set isselect = i_state where stationid = i_stationid;
   commit;  
end sp_web_setstationselectstate;
/

create or replace procedure sp_station_setkey(
i_stationid in number,--��վ���
i_strkey varchar2) is--���µ�վKey
/*================================================================
����˵��:
    �û��ʺŵ�¼--for �������ݽӿ�
���WEBҳ�漰�ļ�
    ��ҳ��¼ҳ��
    UserDaoImpl.java
�������:2014-04-03
�����:������
==================================================================*/
begin
     update tb_station set portkey = i_strkey where stationid = i_stationid;
     commit;
end sp_station_setkey;
/


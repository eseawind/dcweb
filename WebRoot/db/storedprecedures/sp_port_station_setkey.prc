create or replace procedure sp_port_station_setkey(
i_stationid in number,--��վ���
i_strkey varchar2) is--���µ�վKey
/*================================================================
����˵��:
���µ�վKey �ַ���
==================================================================*/
begin
     update tb_station set portkey = i_strkey where stationid = i_stationid;
     commit;
end sp_port_station_setkey;
/


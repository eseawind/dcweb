create or replace procedure sp_port_station_setkey(
i_stationid in number,--电站编号
i_strkey varchar2) is--更新电站Key
/*================================================================
功能说明:
更新电站Key 字符串
==================================================================*/
begin
     update tb_station set portkey = i_strkey where stationid = i_stationid;
     commit;
end sp_port_station_setkey;
/


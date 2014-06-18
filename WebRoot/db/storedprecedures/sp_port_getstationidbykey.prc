create or replace procedure sp_port_getstationidByKey (
i_keystr varchar2,--key
o_stationid out int 
/*
-1:δ�ҵ�Key
-2:Key��Ӧ�ĵ�վ����û�û����ϵ
-3:�ʺŲ�����
0:��ѯ��ʱ
*/
) is
v_rn int;
v_lastquerydt date;
begin
  o_stationid:= -1;
 select count(1) into v_rn from tb_station where portkey = i_keystr;
 if (v_rn =1) then
       select stationid,nvl(LastPortRequestdt,sysdate -1) into o_stationid,v_lastquerydt  from tb_station where portkey = i_keystr ;
       --if((sysdate-v_lastquerydt)*24*60 <10) then
       --if((sysdate-v_lastquerydt)*24*60 <0) then
       --   o_stationid:=0;
       --else
       --   update tb_station set LastPortRequestdt = sysdate() where stationid = o_stationid;
       --   commit;
       --end if;
 end if;
end sp_port_getstationidByKey;
/


create or replace procedure sp_web_getstationlocaldt(
i_Stationid number,
o_now out varchar2) is
v_timezone number;
begin
  
  select nvl(timezone,8) into v_timezone from tb_station where stationid = i_Stationid;
        
  o_now :=to_char(GetLocalCurrentDatetime(v_timezone),'yyyy-mm-dd hh24:mi:ss');
  
  --o_now :=to_char(sysdate(),'yyyy-mm-dd hh24:mi:ss'); 

end sp_web_getstationlocaldt;
/


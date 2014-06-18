create or replace procedure sp_getcurrentversion(
i_system varchar2,
i_version varchar2,
i_Width number,
i_Height number,
o_version out varchar2,
o_update out varchar2,
o_url out varchar2,
o_context out varchar2) is
begin
  o_version:='1.3.2';
--  o_version:='11';
  o_update:='2013-12-12';
  if(i_version=o_version) then
    o_url:='';
  else
    o_url:='http://voicet.oicp.net:8000/netPack/download/Solarcloud_1.3.2.apk';
  end if;
  o_context:='for interface test';
end sp_getcurrentversion;
/


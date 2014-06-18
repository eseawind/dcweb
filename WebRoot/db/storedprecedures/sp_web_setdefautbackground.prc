create or replace procedure sp_web_setdefautbackground(i_stationid number) is
begin
  update tb_station set bgurl = 'upload/station/defultBg.jpg' where stationid = i_stationid;
  commit;
end sp_web_setdefautbackground;
/


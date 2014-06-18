create or replace procedure sp_get_userlimit(i_userid number,i_stationid number,cur out sys_refcursor) is
--用户获得电站的操作权限
begin
  open cur for select 1 editstation,1 devman,1 reportconfig from dual;
end sp_get_userlimit;
/


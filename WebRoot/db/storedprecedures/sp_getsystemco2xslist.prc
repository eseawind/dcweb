create or replace procedure sp_getsystemco2xslist(o_curresult out sys_refcursor) is
begin
  open o_curresult for select '0.8' gainxs from dual;
end sp_getsystemco2xslist;
/


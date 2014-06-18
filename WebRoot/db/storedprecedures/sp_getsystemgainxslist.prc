create or replace procedure sp_getsystemgainxslist(o_curresult out sys_refcursor) is
begin
  open o_curresult for select '0.7' gainxs from dual;
end sp_getsystemgainxslist;
/


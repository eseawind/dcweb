create or replace procedure sp_web_sys_checkAccount(
i_account varchar2,
o_result out varchar2
) is
v_account varchar2(100);
v_rownum number;
v_roleid number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
     select nvl(roleid,0) into v_roleid from tb_user where account = v_account;
     if v_roleid = 0  or v_roleid = 12 then
        o_result:='ok';
     else
        o_result:='err_nomatchaccount';
     end if;
  else
     o_result:='err_accountnotexists';
  end if;
end sp_web_sys_checkAccount;
/


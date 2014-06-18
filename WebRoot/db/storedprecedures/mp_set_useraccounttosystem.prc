create or replace procedure mp_set_useraccounttosystem(i_account varchar2,o_result out varchar2) is
--将普通用户帐号升级为系统管理员帐号
v_userid number;
v_rownum number;
begin
  select count(1) into v_rownum from tb_user where account = lower(i_account);
  if v_rownum >0 then
     update tb_user set roleid = 3 where userid = v_userid;
     commit;
     o_result:='ok';
  else
     o_result:='err_account';
  end if;
end mp_set_useraccounttosystem;
/


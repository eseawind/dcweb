create or replace procedure sp_web_sys_appendaccount(
i_account varchar2,
i_prg_up number,--升级程序
i_sta_config number,--电站管理
i_acc_config number,--帐号管理
i_dev_config number,--设备管理
i_state number,--??
o_result out varchar2
) is
v_account varchar2(100);
v_userid number;
v_rownum number;
v_roleid number;
v_rolestring varchar2(100);
begin
  v_account:=trim(lower(i_account));
  select count(1)into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
     select userid,roleid into v_userid,v_roleid from tb_user where account = v_account;
     if v_roleid not in(3,4) then
        v_rolestring:=to_char(i_prg_up)||','||to_char(i_sta_config)||','||to_char(i_acc_config)||','||to_char(i_dev_config);
        update tb_user set roleid = 3,rolestring = v_rolestring,state = i_state where userid=v_userid;
        commit;
        o_result:='ok';
     else
        o_result:='err_useraccount';
     end if;
  else
     o_result:='err_accountnotexists';
  end if;
end sp_web_sys_appendaccount;
/


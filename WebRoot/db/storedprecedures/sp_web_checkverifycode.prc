create or replace procedure sp_web_checkverifycode(
i_account varchar2,--帐号
i_verifycode varchar2,--校验码
i_Password varchar2,--密码
o_result out varchar2--修改结果
) is
/*================================================================
功能说明:用户帐号修改密码邮件激活验证码校验
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:密码找回功能的通过邮件中的验证码修改用户密码操作
    引用文件:UserDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_account varchar2(100);
v_rownum number;
v_verifycode varchar2(60);
v_mailactive number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
      select a_verifycode,mailactive into v_verifycode,v_mailactive from tb_user where account = v_account;
      if v_verifycode = i_verifycode then
          if v_mailactive = 0 then
             --若未激活，先保证激活能够登录
             update tb_user set pwd = fn_encryptforpwd(i_password),mailactive=1 where account=v_account;
          else
             update tb_user set pwd = fn_encryptforpwd(i_password) where account=v_account;
          end if;
          commit;
          o_result:='ok';
      else
          o_result:='err_code';
      end if;
  else
     o_result:='err_account';
  end if;
end sp_web_checkverifycode;
/


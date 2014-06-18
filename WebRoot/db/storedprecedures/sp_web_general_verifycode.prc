create or replace procedure sp_web_general_verifycode(
i_account varchar2,--用户帐号
o_firstname out varchar2,--输出用户信息的姓
o_secondname out varchar2,--输出用户的名
o_result out varchar2--校验结果
) is
/*================================================================
功能说明:web用户帐号忘记密码时生成的验证码
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:登录首页忘记密码的密码找回页面
    引用文件:UserDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
--
v_verifycode varchar2(100);
v_rownum number;
v_account varchar2(100);
begin
  --修改密码之前该帐号状态必须激活,可以不用激活在修改密码时，直接触发激活
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account=v_account /*and mailactive = 1 */;
  if v_rownum >0 then
      v_verifycode:=fn_getrandstringwithabc(8);
      select firstname,secondname into o_firstname,o_secondname from tb_user where account = v_account;
      update tb_user set a_verifycode = v_verifycode,verifydt=sysdate where account=v_account;
      commit;
      o_result:=v_verifycode;
  else
      o_result:='error_account';
  end if;
end sp_web_general_verifycode;
/


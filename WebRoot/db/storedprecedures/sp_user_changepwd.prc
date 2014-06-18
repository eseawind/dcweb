create or replace procedure sp_user_changepwd(
i_userid in number,--用户ID号
i_oldpwd in varchar2,--原来的密码
i_newpwd in varchar2,--新密码
o_result out varchar2--修改结果,成功:ok,失败:err_oldpwd,err_account
) is
/*================================================================
功能说明:根据userid 修改密码
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:User/Change password
    引用文件:UserDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
v_password varchar(100);
begin
  select count(1) into v_rownum from tb_user where userid = i_userid;
  if v_rownum >0 then
    select pwd into v_password from tb_user where userid = i_userid;
    if  v_password = fn_encryptforpwd(i_Oldpwd) then
       update tb_user set pwd = fn_encryptforpwd(i_newpwd) where userid = i_userid;
       commit;
       o_result:='ok';
    else
       o_result:='err_oldpwd';
    end if;
  else
    o_result:='err_account';
  end if;
end sp_user_changepwd;
/


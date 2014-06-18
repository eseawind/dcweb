create or replace procedure sp_web_sys_removeAccount2(
i_account varchar2,
o_result out varchar2
) is
/*================================================================
功能说明:删除系统管理员帐号操作
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:超级管理员功能之管理员管理
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_account varchar2(100);
v_userid number;
v_rownum number;
begin
  v_account:=trim(lower(i_account));
 select count(1) into v_rownum from tb_user where account = v_account and roleid = 3;
 if v_rownum > 0 then
     select userid into v_userid from tb_user where account = v_account;
     --根据该帐号当前是否拥有自己的电站及共享电站，决定roleid值
     select count(1) into v_rownum from tb_userstation where userid = v_userid;
     if v_rownum >0 then
         update tb_user set roleid = 12,rolestring=null where account = v_account;
     else
         update tb_user set roleid = 0 ,rolestring=null where account = v_account;
     end if;
     commit;
     o_result:='ok';
 else
     o_result:='err_accountnotexists';
 end if;
end sp_web_sys_removeAccount2;
/


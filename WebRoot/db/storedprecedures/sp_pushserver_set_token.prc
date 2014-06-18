create or replace procedure sp_pushserver_set_token(
--设置终端标识信息
i_tokestr varchar2,--终端标识
i_account varchar2,--登录帐号(邮箱地址)(实际传递为用户编号)
i_lan varchar2,--语言种类(英文:en_US,中文:zh_CN)
i_start varchar2,--推送开始时间(例如:09:00)
i_end varchar2--推送结束时间(18:00)
) is
v_rownum number;
v_userid number;
begin
   select count(1) into v_rownum from tb_token_data where tokenid = i_tokestr;
   v_userid :=to_number(i_account);
   if v_rownum >0 then
      update tb_token_data set userid = v_userid,curlan = i_lan,starttime=fn_getminutesbytime(i_start),endtime=fn_getminutesbytime(i_end) where tokenid = i_tokestr;
   else
      insert into tb_token_data(tokenid,userid,curlan,starttime,endtime,createdt) values(i_tokestr,v_userid,i_lan,fn_getminutesbytime(i_start),fn_getminutesbytime(i_end),sysdate);
   end if;
   commit;
end sp_pushserver_set_token;
/


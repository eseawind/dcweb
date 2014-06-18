create or replace procedure sp_pushserver_set_token(
--�����ն˱�ʶ��Ϣ
i_tokestr varchar2,--�ն˱�ʶ
i_account varchar2,--��¼�ʺ�(�����ַ)(ʵ�ʴ���Ϊ�û����)
i_lan varchar2,--��������(Ӣ��:en_US,����:zh_CN)
i_start varchar2,--���Ϳ�ʼʱ��(����:09:00)
i_end varchar2--���ͽ���ʱ��(18:00)
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


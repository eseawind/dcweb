create or replace procedure sp_pushserver_remove_token(
--����ն˱�ʶ
i_tokestr varchar2--�ն˱�ʶ
) is
begin
   if length(i_tokestr)>20 then
     delete tb_token_data where tokenid = i_tokestr;
     commit;
   end if;
end sp_pushserver_remove_token;
/


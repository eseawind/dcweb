create or replace trigger trgbd_tb_tokendata
  before delete on tb_token_data
  for each row
declare
  -- Token 删除时，发送清除消息给DBS
begin
  if length(:old.tokenid)> 20 then
      insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
      values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',203,-1,-1,:old.tokenid);
  end if;
end trgbd_tb_tokendata;
/


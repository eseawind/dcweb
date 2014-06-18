create or replace trigger trgai_tb_tokendata
  after insert on tb_token_data
  for each row
declare
begin
  if length(:new.tokenid)> 20 then
      insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
            values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',202,-1,2,:new.tokenid);
  end if;
end trgai_tb_tokendata;
/


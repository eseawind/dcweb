create or replace trigger trgau_tb_tokendata
  after update on tb_token_data
  for each row
declare
v_msg varchar2(100);
begin
  if :old.userid = :new.userid then
     v_msg:=:old.tokenid||','||:new.curlan||','||:new.starttime||','||:new.endtime;
     insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
            values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',202,-1,1,v_msg);
  else
    v_msg:=:old.tokenid;
    insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
            values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',202,-1,2,v_msg);
  end if;
end trgau_tb_tokendata;
/


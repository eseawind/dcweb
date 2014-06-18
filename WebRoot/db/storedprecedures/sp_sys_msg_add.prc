create or replace procedure sp_sys_msg_add(i_msgfrom varchar2,i_msgto varchar2,i_action number,i_val1 number,i_val2 number,i_context varchar2) is
begin
  insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,i_msgfrom,i_msgto,i_action,i_val1,i_val2,i_context);
  commit;
end sp_sys_msg_add;
/


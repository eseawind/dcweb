create or replace procedure sp_push_newtask(
i_tokenstr varchar2,
i_title varchar2,
i_key_val varchar2
) is

begin
  insert into tb_pushtask(tid,tokenstr,title,key_val,createdt) values(SEQ_PUSH_TASK.Nextval,i_tokenstr,i_title,i_key_val,sysdate);
  commit;
end sp_push_newtask;
/


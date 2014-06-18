create or replace trigger trgau_DICT_SSIIS
  after update on tb_dict_ssiis
  for each row
declare
  -- local variables here
begin
    if (:new.subtag ='pmuverdefine' and :new.context <> :old.context) then
        insert into tb_sys_msg(idd,msgfrom,msgto,ACTION,val1,val2,context) values (SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',1200,-1,-1,'');
    END IF;
end trgau_DICT_SSIIS;
/


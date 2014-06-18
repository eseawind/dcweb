create or replace trigger TRGAI_DICT_SSIIS
  after insert on tb_dict_ssiis
  for each row
declare
begin
  if (:new.subtag ='pmuverdefine') then

      insert into tb_sys_msg(idd,msgfrom,msgto,ACTION,val1,val2,context) values (SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',1200,-1,-1,'');
  end if;
end TRGAI_DICT_SSIIS;
/


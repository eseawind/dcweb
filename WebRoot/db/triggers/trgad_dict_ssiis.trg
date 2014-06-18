create or replace trigger trgad_DICT_SSIIS
  after delete on tb_dict_ssiis
  for each row
declare
begin
   if (:old.subtag = 'pmuverdefine') then
      insert into tb_sys_msg(idd,msgfrom,msgto,ACTION,val1,val2,context) values (SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYOND',1200,-1,-1,'');
   end if;
end trgad_DICT_SSIIS;
/


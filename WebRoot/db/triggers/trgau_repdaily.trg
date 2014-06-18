create or replace trigger trgau_repdaily
  after update on tb_station_report_daily
  for each row
declare
begin
   if (:new.state = 1 and (:new.lan <> :old.lan or :new.reciverlist <> :old.reciverlist or :new.rep_format<> :old.rep_format or :new.sendattime<> :old.sendattime or :new.itemstr <> :old.itemstr)) or :new.state <> :old.state then
      insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',101,:new.stationid,:new.reportid,'lan='||:new.lan||';');
   end if;
end trgau_repdaily;
/


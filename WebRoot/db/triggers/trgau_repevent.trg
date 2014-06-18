create or replace trigger trgau_repevent
  after update on tb_station_report_event
  for each row
declare
begin
    if  (:new.state = 1 and (:new.lan <> :old.lan or :new.reciverlist <> :old.reciverlist or :new.rep_format<> :old.rep_format or :new.itemstr <> :old.itemstr or :new.nextdelay<> :old.nextdelay or :new.emptysend<> :old.emptysend or :new.maxeventlimit <> :old.maxeventlimit)) or :new.state <> :old.state  then
      insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',103,:new.stationid,1,'lan='||:new.lan||';');
    end if;
end trgau_repevent;
/


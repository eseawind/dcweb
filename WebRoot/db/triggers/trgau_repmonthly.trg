create or replace trigger trgau_repmonthly
  after update on tb_station_report_monthly
  for each row
declare
begin
     if :new.state <> :old.state or (:new.state = 1 and (:new.lan <> :old.lan or :new.reciverlist <> :old.reciverlist or :new.rep_format<> :old.rep_format or :new.itemstr <> :old.itemstr)) then
       insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','DBS100',102,:new.stationid,:new.reportid,'lan='||:new.lan || ';');
     end if;
end trgau_repmonthly;
/


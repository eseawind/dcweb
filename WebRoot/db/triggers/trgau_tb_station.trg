create or replace trigger trgau_tb_station
  after update on tb_station
  for each row
declare

begin
   if (:old.w_keyval <> :new.w_keyval or :old.customerflag <> :new.customerflag) then
     insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',300,:new.stationid,:new.w_keyval,
     'stationid='||:new.stationid||';timezone='||:new.w_keyval ||';customerflag='||:new.customerflag ||';');
   end if;
end trgau_tb_station;
/


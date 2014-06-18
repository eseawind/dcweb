create or replace procedure sp_Empty_DeviceEvent(i_sno in  varchar2) is
--清空指定设备的事件列表
--适用范围:wap,web,手机客户端
--test,pass 20120403
v_rownum number;
begin
   select count(1) into v_rownum from tb_event_all where ssno = i_sno and c_tag = 0;
   if v_rownum > 0 then
      update tb_event_all set c_tag = 1 where ssno = i_sno and c_tag = 0;
      commit;
   end if;
end sp_Empty_DeviceEvent;
/


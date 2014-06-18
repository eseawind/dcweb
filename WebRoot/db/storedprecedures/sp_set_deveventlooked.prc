create or replace procedure sp_set_deveventlooked(i_sno varchar2) is
--设置指定设备事件查看过状态
--i_sno:为指定的设备序列号
begin
  update tb_event_all set l_tag = 1 where l_tag = 0 and ssno = i_sno;
  commit;
end sp_set_deveventlooked;
/


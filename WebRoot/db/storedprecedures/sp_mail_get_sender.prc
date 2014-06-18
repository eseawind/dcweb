create or replace procedure sp_mail_get_sender(cur_result out sys_refcursor) is
begin
  --open cur_result for select 'smtp.163.com' smtp,25 port_a,1 validate_a,'voicet@163.com' account,'5424264586' password,'voicet@163.com' mailaddr from dual;
  open cur_result for select 'mail.zeversolar.com' smtp,25 port_a,1 validate_a,'solarcloud@zeversolar.com' account,'051269370998' password,'solarcloud@zeversolar.com' mailaddr from dual;
end sp_mail_get_sender;
/


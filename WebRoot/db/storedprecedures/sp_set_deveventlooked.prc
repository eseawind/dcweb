create or replace procedure sp_set_deveventlooked(i_sno varchar2) is
--����ָ���豸�¼��鿴��״̬
--i_sno:Ϊָ�����豸���к�
begin
  update tb_event_all set l_tag = 1 where l_tag = 0 and ssno = i_sno;
  commit;
end sp_set_deveventlooked;
/


create or replace procedure sp_web_checkurlenabled(
i_userid number,--�û����
i_roleid number,--��ɫ���,--1
i_rolestr varchar2,--��ɫ�ַ���
o_result out  varchar2--���
) is
begin
  o_result:='ok';
end sp_web_checkurlenabled;
/


create or replace procedure sp_web_general_verifycode(
i_account varchar2,--�û��ʺ�
o_firstname out varchar2,--����û���Ϣ����
o_secondname out varchar2,--����û�����
o_result out varchar2--У����
) is
/*================================================================
����˵��:web�û��ʺ���������ʱ���ɵ���֤��
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��¼��ҳ��������������һ�ҳ��
    �����ļ�:UserDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
--
v_verifycode varchar2(100);
v_rownum number;
v_account varchar2(100);
begin
  --�޸�����֮ǰ���ʺ�״̬���뼤��,���Բ��ü������޸�����ʱ��ֱ�Ӵ�������
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account=v_account /*and mailactive = 1 */;
  if v_rownum >0 then
      v_verifycode:=fn_getrandstringwithabc(8);
      select firstname,secondname into o_firstname,o_secondname from tb_user where account = v_account;
      update tb_user set a_verifycode = v_verifycode,verifydt=sysdate where account=v_account;
      commit;
      o_result:=v_verifycode;
  else
      o_result:='error_account';
  end if;
end sp_web_general_verifycode;
/


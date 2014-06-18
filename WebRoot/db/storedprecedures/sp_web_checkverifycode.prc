create or replace procedure sp_web_checkverifycode(
i_account varchar2,--�ʺ�
i_verifycode varchar2,--У����
i_Password varchar2,--����
o_result out varchar2--�޸Ľ��
) is
/*================================================================
����˵��:�û��ʺ��޸������ʼ�������֤��У��
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:�����һع��ܵ�ͨ���ʼ��е���֤���޸��û��������
    �����ļ�:UserDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_account varchar2(100);
v_rownum number;
v_verifycode varchar2(60);
v_mailactive number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
      select a_verifycode,mailactive into v_verifycode,v_mailactive from tb_user where account = v_account;
      if v_verifycode = i_verifycode then
          if v_mailactive = 0 then
             --��δ����ȱ�֤�����ܹ���¼
             update tb_user set pwd = fn_encryptforpwd(i_password),mailactive=1 where account=v_account;
          else
             update tb_user set pwd = fn_encryptforpwd(i_password) where account=v_account;
          end if;
          commit;
          o_result:='ok';
      else
          o_result:='err_code';
      end if;
  else
     o_result:='err_account';
  end if;
end sp_web_checkverifycode;
/


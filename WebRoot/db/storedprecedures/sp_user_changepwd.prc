create or replace procedure sp_user_changepwd(
i_userid in number,--�û�ID��
i_oldpwd in varchar2,--ԭ��������
i_newpwd in varchar2,--������
o_result out varchar2--�޸Ľ��,�ɹ�:ok,ʧ��:err_oldpwd,err_account
) is
/*================================================================
����˵��:����userid �޸�����
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:User/Change password
    �����ļ�:UserDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_rownum number;
v_password varchar(100);
begin
  select count(1) into v_rownum from tb_user where userid = i_userid;
  if v_rownum >0 then
    select pwd into v_password from tb_user where userid = i_userid;
    if  v_password = fn_encryptforpwd(i_Oldpwd) then
       update tb_user set pwd = fn_encryptforpwd(i_newpwd) where userid = i_userid;
       commit;
       o_result:='ok';
    else
       o_result:='err_oldpwd';
    end if;
  else
    o_result:='err_account';
  end if;
end sp_user_changepwd;
/


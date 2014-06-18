create or replace procedure sp_web_sys_removeAccount2(
i_account varchar2,
o_result out varchar2
) is
/*================================================================
����˵��:ɾ��ϵͳ����Ա�ʺŲ���
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��������Ա����֮����Ա����
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_account varchar2(100);
v_userid number;
v_rownum number;
begin
  v_account:=trim(lower(i_account));
 select count(1) into v_rownum from tb_user where account = v_account and roleid = 3;
 if v_rownum > 0 then
     select userid into v_userid from tb_user where account = v_account;
     --���ݸ��ʺŵ�ǰ�Ƿ�ӵ���Լ��ĵ�վ�������վ������roleidֵ
     select count(1) into v_rownum from tb_userstation where userid = v_userid;
     if v_rownum >0 then
         update tb_user set roleid = 12,rolestring=null where account = v_account;
     else
         update tb_user set roleid = 0 ,rolestring=null where account = v_account;
     end if;
     commit;
     o_result:='ok';
 else
     o_result:='err_accountnotexists';
 end if;
end sp_web_sys_removeAccount2;
/


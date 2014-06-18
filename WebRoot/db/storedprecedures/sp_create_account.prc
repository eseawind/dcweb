create or replace procedure sp_create_account(
i_account in varchar2,--�û��ʺţ�ֻ��������
i_password in varchar2,--��ʼ����
i_question nvarchar2,--�û�����
i_answer nvarchar2,--�û��ش�
i_firstname nvarchar2,--��
i_secondname nvarchar2,--��
i_company nvarchar2,--��˾����
i_webaddr varchar2,--��˾��ַ
i_country varchar2,--����
i_City nvarchar2,--����
i_province varchar2,--ʡ����
i_street varchar2,--�ֵ�����
i_zip varchar2,--�ʱ�
i_telnum varchar2,--�绰����xx-xxx-xxxxxx
i_mobile varchar2,--�ֻ�����
o_userid out number,--����û�ID��
o_verifycode out varchar2,--�û�ע����
o_result out varchar2--���
) is
/*================================================================
����˵��:�����û��ʺ�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �û�ע��ҳ��
    UserDaoImpl.java
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
v_pwdmd5 varchar2(100);
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum =0 then--ϵͳ�в�����ͬ���ʺţ����Եǲ�
     if fn_getitemnum(v_account,'@') >1 then--�Ϸ��ʺ�
        v_pwdmd5:= fn_encryptforpwd(i_password);
        o_verifycode:=fn_getrandstringwithabc(8);
        insert into tb_user(
              userid,account,pwd,question1,ans1,firstname,secondname,company,webaddr,country,province,city,
              street,zip,tel,roleid,mobile,a_verifycode,mailactive,verifydt,createdt)
              values (seq_userid.nextval,v_account,v_pwdmd5,i_question,i_answer,i_firstname,i_secondname,i_company,i_webaddr,to_number(i_country),to_number(i_province),i_city,i_street,i_zip,i_telnum,12,i_mobile,o_verifycode,0,sysdate,sysdate);
        select seq_userid.currval into o_userid from dual;
        commit;
        o_result:='ok';
     else
        o_result:='err_format';
     end if;
  else
     o_result:='err_accountexists';
  end if;
end sp_create_account;
/


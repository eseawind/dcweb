create or replace procedure sp_web_updateaccountinfo(
i_account varchar2,
i_firstname varchar2,--��
i_secondname varchar2,--��
i_company varchar2,--��˾����
i_webaddr varchar2,--��˾��ַ
i_country varchar2,--����
i_province varchar2,--ʡ����
i_City varchar2,
i_street varchar2,--�ֵ�����
i_zip varchar2,--�ʱ�
i_telnum varchar2,--�绰����xx-xxx-xxxxxx
i_mobile varchar2,--�ֻ�����
o_result out varchar2
) is
/*================================================================
����˵��:�����û��ʺ���Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:User/Modify data
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
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
      update tb_user set firstname=i_firstname,secondname=i_secondname,
      company=i_company,webaddr=i_webaddr,
      country=to_number(i_country),province=to_number(i_province),street=i_street,city=i_city,
      zip=i_zip,tel=i_telnum,mobile=i_mobile where account = v_account;
      commit;
      o_result:='ok';
  else
      o_result:='err_account';
  end if;
  o_result:='ok';
end sp_web_updateaccountinfo;
/


create or replace procedure sp_web_getcurrencylist(o_curresult out sys_refcursor) is
/*================================================================
����˵��:��õ�ǰ��ѡ��Ļ��ҷ����б�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:������վҳ��
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_str1 varchar2(10);
v_str2 varchar2(10);
v_str3 varchar2(10);
v_str4 varchar2(10);
begin
  v_str1:='$';
  v_str2:='��';
  v_str3:='�';
  v_str4:='kr';

  open o_curresult for 
                   select v_str1  currency from dual union 
                   select v_str2  currency from dual union 
                   select v_str3  currency from dual union 
                   select v_str4  currency from dual;
end sp_web_getcurrencylist;
/


create or replace procedure sp_web_get_sys_accountlist2(
cur_result out sys_refcursor
) is
/*================================================================
����˵��:���ϵͳ����Ա�ʺ��б�
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
rolestring=x1,x2,x3,x4,x5
x1:pmut
x2:invt
x3:usert
x4:devt
x5:evet
==================================================================*/
begin
  open cur_result for select account,firstname,secondname,nvl(to_number(fn_getmidstr(rolestring,1,',')),0) updatet,nvl(to_number(fn_getmidstr(rolestring,2,',')),0) plantt,to_number(fn_getmidstr(rolestring,3,',')) usert,to_number(fn_getmidstr(rolestring,4,','))  devt,nvl(to_number(fn_getmidstr(rolestring,5,',')),0) evet,state from tb_user where roleid =3;
end sp_web_get_sys_accountlist2;
/


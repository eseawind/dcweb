create or replace procedure sp_web_getinvtypelist(
cur_typelist out sys_refcursor) is
/*================================================================
����˵��:��õ�ǰ����������б�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��������Ա�����е�,Inverter Config
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
begin
  open cur_typelist for select distinct trim(devtypename) devtypename from (select distinct devtypename from tb_inverter) where devtypename is not null;
end sp_web_getinvtypelist;
/


create or replace procedure sp_web_getpmutypelist(
cur_typelist out sys_refcursor,
cur_subtypelist out sys_refcursor) is
/*================================================================
����˵��:���ϵͳPMU�豸�����б�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:����Ա֮�������ѯҳ��
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
  open cur_typelist for select distinct nvl(devname,'δ����') TName from tb_pmu where pmutype is not null;--'PMU PRO' TName from dual union select 'PMU' TName from dual;
  open cur_subtypelist for select distinct subtype TName from tb_pmu where subtype is not null;--'1.0' TName from dual union select '2.0' TName from dual;
end sp_web_getpmutypelist;
/


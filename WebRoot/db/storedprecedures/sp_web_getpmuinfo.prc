create or replace procedure sp_web_getpmuinfo(
i_psno varchar2,
cur_result out sys_refcursor) is
/*================================================================
����˵��:���ָ��PMU��Ϣ��ϸ���
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:����Ա����֮�������ѯ
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
   open cur_result for select usedspace,totalspace,state,softver,hardwver,llip,to_char(lldt,'yyyy-mm-dd hh24:mi:ss')lldt from tb_pmu where psno = upper(i_psno);
end sp_web_getpmuinfo;
/


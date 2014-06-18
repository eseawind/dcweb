create or replace procedure sp_web_getpmuinfoex(
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
   open cur_result for select nvl(b.stationname,'δ��') stationname,a.psno,a.idex,a.devname pmutype,a.subtype,nvl(a.usedspace,0) ||'M' usedspace,nvl(a.totalspace,0) ||'M' totalspace ,a.state,a.softver,a.hardwver,nvl(a.llip,'δ֪') llip,nvl(to_char(a.lldt,'yyyy-mm-dd hh24:mi:ss'),'δ֪') lldt,a.upa,a.upn,a.curgate from tb_pmu a,tb_station b where a.stationid = b.stationid(+) and psno = upper(i_psno);
end sp_web_getpmuinfoex;
/


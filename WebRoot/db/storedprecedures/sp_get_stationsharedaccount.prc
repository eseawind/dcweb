create or replace procedure sp_get_stationsharedaccount(
--��ȡָ����վ�Ĺ����ʺ��б�
i_stationid number,
cur_result out sys_refcursor
) is
/*================================================================
����˵��:���ָ����վ�ĵ�ǰ������ʺ�(��������վ����Ա�Լ����ʺ�)
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Shared config
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
   open cur_result for select a.userid,a.rightstr,b.account,a.mailactive state,b.firstname,b.secondname from tb_userstation a,tb_user b where a.userid=b.userid and a.stationid = i_stationid and a.roleid =1;
end sp_get_stationsharedaccount;
/


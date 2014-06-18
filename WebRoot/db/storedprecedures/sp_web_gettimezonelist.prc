create or replace procedure sp_web_gettimezonelist(
i_language varchar2,
cur_list out sys_refcursor) is
/*================================================================
����˵��:ָ�����ԣ���ȡҳ��ʱ���б���Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:������վҳ���
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
  open cur_list for select val1 areacode,val2 keyval,context areaname, ex1 isdst from tb_dict_ssiis where subtag = 'webtimezone' and language = i_language order by val1,context ;
end sp_web_gettimezonelist;
/


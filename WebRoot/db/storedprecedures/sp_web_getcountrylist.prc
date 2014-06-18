create or replace procedure sp_web_getcountrylist(
i_language varchar2,--��������
cur_list out sys_refcursor--�����б�
) is
/*================================================================
����˵��:********
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:ҳ�����õ������б�Ĳ�ѯ
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
  open cur_list for select val1 c_code,val2,context countryname from tb_dict_ssiis where language=i_language and subtag = 'webcountrylist' order by val2,nlssort(countryname,'NLS_SORT=SCHINESE_PINYIN_M');
end sp_web_getcountrylist;
/


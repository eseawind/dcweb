create or replace procedure sp_web_getprovincelist(
i_code number,--���Ҵ���
i_language varchar2,--����
cur_list out sys_refcursor--��ѯ�����
) is
/*================================================================
����˵��:����ָ�����뼰�����������ƻ�øù��ҵ���ʡ��Ϣ�б�
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_rownum number;
begin
  select count(1)into v_rownum from tb_dict_ssiis where subtag = 'webprovince' and language = i_language and val1 = i_code;
  if v_rownum >0 then
    open cur_list for select val2 pid,context provincename from tb_dict_ssiis where subtag = 'webprovince' and language = i_language and val1 = i_code;
  else
     open cur_list for select 1 pid,context provincename from tb_dict_ssiis where subtag = 'webcountrylist' and language = i_language and val1 = i_code;
  end if;
end sp_web_getprovincelist;
/


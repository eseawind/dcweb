create or replace procedure sp_web_shareaccountactiveex(
i_stationid number,--������ĵ�վ���
i_userid number,--������շ����û�ID
i_state number,--1:����,-1:�ܾ�,0:��ֵֵ
o_result  out varchar2--������
) is
/*================================================================
����˵��:�����վ�û��ʺż���
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��վ�б���,δ�����վ�Ĺ�����ܲ���
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
--
v_rownum number;
begin
  if i_state in(-1,0,1) then
  select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
  if v_rownum >0 then
        update tb_userstation set mailactive = i_state where stationid = i_stationid and userid = i_userid;
        commit;
        o_result:='ok';
  else
     o_result:='err_account';
  end if;
  else
    o_result:='err_state';
  end if;
end sp_web_shareaccountactiveex;
/


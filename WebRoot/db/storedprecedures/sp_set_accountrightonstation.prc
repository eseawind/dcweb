create or replace procedure sp_set_accountrightonstation(
i_stationid number,--��վ���
i_userid number,--������ʺ�
i_rightstr varchar2,--Ȩ���ַ���,ʾ��:x,x,x,x
o_result out varchar2) is
/*================================================================
����˵��:�޸�ָ����վָ���û��ĵ�ǰ����Ȩ��
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
--Ϊ��վָ�������ʺ�
v_rownum number;
begin
     select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid= i_userid;
     if v_rownum =1 then
        update tb_userstation set rightstr = i_rightstr where stationid = i_stationid and userid= i_userid;
        commit;
        o_result:='ok';
     else
       o_result:='err_notexists';
     end if;
end sp_set_accountrightonstation;
/


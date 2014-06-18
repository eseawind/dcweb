create or replace procedure sp_web_removeaccfromstation(
i_stationid number,--��վ���
i_userid number,--�û�ID��
o_result out varchar2
) is
/*================================================================
����˵��:Ϊָ����վɾ��������ʺ�
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
v_rownum number;
v_roleid number;
begin
      select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
       if v_rownum  >0 then
           select roleid into v_roleid from tb_userstation where stationid = i_stationid and userid = i_userid;
           if v_roleid = 1 then
               delete tb_userstation where userid = i_userid and stationid = i_stationid;
               --�����û����Ƿ񻹴��ڹ����վ���Լ��ĵ�վ
               select count(1) into v_rownum from tb_userstation where userid= i_userid;
               if v_rownum =0 then--û�е�վ��
                   update tb_user set roleid = 0 where userid = i_userid;
               end if;
               commit;
               o_result:='ok';
           else
              o_result:='err_roleid';
           end if;
       else
           o_result:='err_norolerec';
       end if;
end sp_web_removeaccfromstation;
/


create or replace procedure sp_set_stationtoaccount(
i_stationid number,--��վ���
i_account varchar2,--������ʺ�
i_rightstr varchar2,--Ȩ���ַ���,ʾ��:x,x,x,x
o_result out varchar2) is
/*================================================================
����˵��:��ָ����վ�����ָ���ʺŲ���
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
v_account varchar2(60);
v_rownum number;
v_userid number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
     select userid into v_userid from tb_user where account = v_account;
     select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid= v_userid;
     if v_rownum =0 then
        insert into tb_userstation(userid,stationid,createdt,roleid,rightstr,state,mailactive) values(v_userid,i_stationid,sysdate,1,i_rightstr,0,1);
        commit;
        o_result:='ok';
     else
       o_result:='err_exists';
     end if;
  else
     o_result:='err_account';
  end if;
end sp_set_stationtoaccount;
/


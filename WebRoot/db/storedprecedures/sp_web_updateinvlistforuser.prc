create or replace procedure sp_web_updateinvlistforuser(
i_userid number,--�û�ID��
i_stationid number,--��վ���
i_isnolist varchar2 default ''--xxxx,xxx,xxxx
) is
/*================================================================
����˵��:���µ�ǰ�û���ָ����վ��ͼ������У���ѡ����������б���Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Graphs
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
v_itemnum number;
v_no varchar(32);
begin
  delete tb_userstationinv_def where userid = i_userid and stationid = i_stationid;
  v_itemNum :=fn_getitemnum(i_isnolist,',');
  for i in 1 .. v_itemnum loop
     v_no:=upper(fn_getmidstr(i_isnolist,i,','));
     if Length(v_no)> 3 then
         insert into tb_userstationinv_def(userid,stationid,isno) values(i_userid,i_stationid,v_no);
     end if;
  end loop;
  commit;
end sp_web_updateinvlistforuser;
/


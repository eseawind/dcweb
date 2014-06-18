create or replace procedure sp_remove_stationex(
i_stationid number,
i_userid number,
o_result out varchar2
) is
/*================================================================
����˵��:ɾ��ָ���û���ָ����վ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:��¼�󣬵�վ�б�ҳ��
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
v_master number;
--ɾ��ָ����վ
begin
   select masterid into v_master from tb_station where stationid = i_stationid;
   select count(1) into v_rownum from tb_pmu where stationid = i_stationid;
   if v_master = i_userid then--��վ����Ա��ɾ��
      if v_rownum =0 then--�õ�վ����ɾ��
          delete tb_station_report_daily where stationid = i_stationid;
          delete tb_station_report_monthly where stationid = i_stationid;
          delete tb_station_report_event where stationid = i_stationid;
          --��վ����Աɾ����վ
          delete tb_userstation where stationid = i_stationid;
          delete tb_station where stationid = i_stationid;
          select count(1) into v_rownum from tb_userstation where userid = i_userid;
          if v_rownum = 0 then--���û���ǰ����ӵ�еĵ�վ��û���ˣ���Ϊ0״̬
             update tb_user set roleid = 0 where userid = i_userid and roleid = 12;
          end if;
          commit;
          o_result:='ok';
      else
         o_result:='err_havepmu';
      end if;
   else--�ǹ���Ա�Ĳ���
      delete tb_userstation where stationid = i_stationid and userid = i_userid;
      select count(1) into v_rownum from tb_userstation where userid = i_userid;
      if v_rownum = 0 then--���û���ǰ����ӵ�еĵ�վ��û���ˣ���Ϊ0״̬
         update tb_user set roleid = 0 where userid = i_userid and roleid = 12;
      end if;
      commit;
      o_result:='ok';
   end if;
end sp_remove_stationex;
/


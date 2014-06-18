create or replace procedure sp_remove_stationex(
i_stationid number,
i_userid number,
o_result out varchar2
) is
/*================================================================
功能说明:删除指定用户的指定电站
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:登录后，电站列表页面
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
v_master number;
--删除指定电站
begin
   select masterid into v_master from tb_station where stationid = i_stationid;
   select count(1) into v_rownum from tb_pmu where stationid = i_stationid;
   if v_master = i_userid then--电站管理员的删除
      if v_rownum =0 then--该电站可以删除
          delete tb_station_report_daily where stationid = i_stationid;
          delete tb_station_report_monthly where stationid = i_stationid;
          delete tb_station_report_event where stationid = i_stationid;
          --电站管理员删除电站
          delete tb_userstation where stationid = i_stationid;
          delete tb_station where stationid = i_stationid;
          select count(1) into v_rownum from tb_userstation where userid = i_userid;
          if v_rownum = 0 then--该用户当前所有拥有的电站都没有了，改为0状态
             update tb_user set roleid = 0 where userid = i_userid and roleid = 12;
          end if;
          commit;
          o_result:='ok';
      else
         o_result:='err_havepmu';
      end if;
   else--非管理员的操作
      delete tb_userstation where stationid = i_stationid and userid = i_userid;
      select count(1) into v_rownum from tb_userstation where userid = i_userid;
      if v_rownum = 0 then--该用户当前所有拥有的电站都没有了，改为0状态
         update tb_user set roleid = 0 where userid = i_userid and roleid = 12;
      end if;
      commit;
      o_result:='ok';
   end if;
end sp_remove_stationex;
/


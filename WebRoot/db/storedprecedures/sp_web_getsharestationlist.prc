create or replace procedure sp_web_getsharestationlist(
cur_stationinfo out sys_refcursor
) is
/*================================================================
功能说明:用户未登录情况下，获得系统当前系统设置的共享电站列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:在首页点击示例电站后，出现的电站列表
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_etotal number;--总共发电量
v_htotal number;--总共二氧化碳减排
v_etoday number;--当日发电量
v_eventTotalNum number;--全部事件数
v_eventNewNum number;--新事件数
v_pmutnum number;
v_pmu1num number;
v_invtnum number;
v_inv1num number;
cursor curstation is select  0 roleid,stationid,stationname,iconindex,nvl(money,'$') currency,co2xs,gainxs,nvl(timezone,8) timezone,ludt,city,pmutnum,pmu1num,invtnum,inv1num from tb_station where sharet = 1;
begin
  EXECUTE IMMEDIATE  'truncate table tmp_stationlist';
  for cur_result in curstation loop
     vp_get_station_info(cur_result.stationid,v_pmutnum,v_pmu1num,v_invtnum,v_inv1num,v_eventTotalNum,v_eventNewNum);
     --统计该电站当前总的发电量
     select nvl(sum(e_today),0),nvl(sum(h_today),0) into v_etotal,v_htotal from tb_invdaily where stationid = cur_result.stationid;
    --统计当天的发电量
     v_etoday:=fn_get_station_e_today(cur_result.stationid);
     v_etotal:=v_etotal+v_etoday;
     insert into tmp_stationlist( stationid,
                                  stationname,
                                  iconindex,
                                  roleid,
                                  ludt,
                                  inv1num,
                                  invtnum,
                                  pmu1num,
                                  pmutnum,
                                  e_total,
                                  e_today,
                                  co2val,
                                  inval,
                                  eve0num,
                                  evetnum,currency)
                            values(
                                  cur_result.stationid,
                                  cur_result.stationname,
                                  nvl(cur_result.iconindex,'res/def/bg/defultBg.jpg'),
                                  cur_result.roleid,
                                  nvl(cur_result.ludt,to_date('2000-01-01','yyyy-mm-dd')),
                                  v_inv1num,
                                  v_invtnum,
                                  v_pmu1num,
                                  v_pmutnum,
                                  nvl(v_etotal,0),
                                  nvl(v_etoday,0),
                                  nvl(v_etotal,0)*cur_result.co2xs,
                                  nvl(v_etotal,0) * cur_result.gainxs,
                                  v_eventNewNum,
                                  v_eventTotalNum,cur_result.currency);
  end loop;
  commit;
  open cur_stationinfo for select stationid,stationname,iconindex,fn_get_val_Kwh(e_total) e_total,fn_get_unit_kwh(e_total) e_total_unit,fn_get_val_Kwh(e_today) e_today,fn_get_unit_kwh(e_today) e_today_unit,fn_get_val_weight(nvl(co2val,0)) co2val,fn_get_unit_weight(nvl(co2val,0)) co2_unit,nvl(inval,0) inval,currency inval_unit,pmu1num,pmutnum,inv1num,invtnum,eve0num,evetnum,to_char(ludt,'yyyy-mm-dd hh24:mi:ss') ludt from tmp_stationlist;
end sp_web_getsharestationlist;
/


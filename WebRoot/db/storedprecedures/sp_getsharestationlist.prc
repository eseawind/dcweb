create or replace procedure sp_getsharestationlist(cur_stationinfo out sys_refcursor) is
--获得当前系统共享电站列表
--适应范围:wap,手机端，web
v_etotal number;--总共发电量
v_htotal number;--总共二氧化碳减排
v_etoday number;--当日发电量
v_eventTotalNum number;--全部事件数
v_eventNewNum number;--新事件数
v_pmutnum number;
v_pmu1num number;
v_invtnum number;
v_inv1num number;
cursor curstation is select  0 roleid,stationid,stationname,iconindex,co2xs,gainxs,nvl(money,'$') currency,nvl(timezone,8) timezone,ludt,city,pmutnum,pmu1num,invtnum,inv1num from tb_station where sharet = 1;
begin
  EXECUTE IMMEDIATE  'truncate table tmp_stationlist';
  for cur_result in curstation loop
    vp_get_station_info(cur_result.stationid,v_pmutnum,v_pmu1num,v_invtnum,v_inv1num,v_eventTotalNum,v_eventNewNum);
     --统计电站当前PMU数目和INV数目
     select nvl(sum(e_today),0),nvl(sum(h_today),0) into v_etotal,v_htotal from tb_invdaily where stationid = cur_result.stationid;
     --统计当天的发电量
     v_etoday:=fn_get_station_e_today(cur_result.stationid);
     v_etotal:=v_etotal+v_etoday;
     --插入记录
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
                                  inval,currency) values(
                                  cur_result.stationid,
                                  cur_result.stationname,
                                  cur_result.iconindex,
                                  cur_result.roleid,
                                  cur_result.ludt,
                                  v_inv1num,
                                  v_invtnum,
                                  v_pmu1num,
                                  v_pmutnum,
                                  v_etotal,
                                  v_etoday,
                                  v_etotal*cur_result.co2xs,
                                  v_etotal * cur_result.gainxs,cur_result.currency);
  end loop;
  commit;
  open cur_stationinfo for select stationid,stationname,iconindex,fn_get_val_kwh(e_total) e_total,fn_get_unit_kwh(e_total) e_total_unit,fn_get_val_kwh(e_today) e_today,fn_get_unit_kwh(e_today) e_today_unit,fn_get_val_weight(nvl(co2val,0)) co2val,fn_get_unit_weight(nvl(co2val,0)) co2val_unit,nvl(inval,0) inval,currency inval_unit,pmu1num,pmutnum,inv1num,invtnum,eve0num,evetnum,ludt from tmp_stationlist;
end sp_getsharestationlist;
/


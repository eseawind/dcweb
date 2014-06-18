create or replace procedure sp_getmystationlist(i_userid in number,cur_stationinfo out sys_refcursor) is
--根据userid 获得我的电站及权限列表
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
cursor curstation is select  a.userid,a.stationid,a.roleid,a.rightstr,b.co2xs,b.gainxs,b.stationname,nvl(b.money,'$') currency,
                             b.iconindex,nvl(b.timezone,8) timezone,
                             nvl(b.ludt,to_date('2000-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')) ludt,b.city
                             from tb_userstation a,tb_station b where a.stationid=b.stationid and a.mailactive = 1 and a.userid = i_userid;
begin
  EXECUTE IMMEDIATE  'truncate table tmp_stationlist';
  for cur_result in curstation loop
     --统计电站当前PMU数目和INV数目,界面无需求,暂不统计
     vp_get_station_info(cur_result.stationid,v_pmutnum,v_pmu1num,v_invtnum,v_inv1num,v_eventTotalNum,v_eventNewNum);
     --统计该电站当前总的发电量
     select nvl(sum(e_today),0),nvl(sum(h_today),0) into v_etotal,v_htotal from tb_invdaily where stationid = cur_result.stationid;
     --统计当天的发电量
     v_etoday:=fn_get_station_e_today(cur_result.stationid);
     --插入记录
     v_etotal:=v_etotal+v_etoday;
     insert into tmp_stationlist( stationid,stationname,iconindex,roleid,ludt,inv1num,invtnum,pmu1num,pmutnum,e_total,e_today,co2val,inval,eve0num,evetnum,rightstr,currency) values(cur_result.stationid,cur_result.stationname,cur_result.iconindex,cur_result.roleid,cur_result.ludt,v_inv1num,v_invtnum,v_pmu1num,v_pmutnum,v_etotal,v_etoday,v_etotal*cur_result.co2xs,v_etotal * cur_result.gainxs,v_eventNewNum,v_eventtotalnum,cur_result.rightstr,cur_result.currency);
  end loop;
  commit;
  open cur_stationinfo for select stationid,stationname,roleid,rightstr,nvl(iconindex,'/res/def/icon/plant01.jpg') iconindex,
       fn_get_val_kwh(e_total) e_total,fn_get_unit_kwh(e_total) e_total_unit,fn_get_val_kwh(e_today) e_today,fn_get_unit_kwh(e_today) e_today_unit,
       fn_get_val_weight(nvl(co2val,0)) co2val,fn_get_unit_weight(nvl(co2val,0)) co2val_unit,
       nvl(inval,0) inval,currency inval_unit,pmu1num,pmutnum,inv1num,invtnum,eve0num,ludt from tmp_stationlist;
end sp_getmystationlist;
/


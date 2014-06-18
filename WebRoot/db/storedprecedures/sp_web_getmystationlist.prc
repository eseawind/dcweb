create or replace procedure sp_web_getmystationlist(
i_userid in number,--查询的用户ID号
cur_stationinfo out sys_refcursor
) is
/*================================================================
功能说明:根据用户ID号获得该用户的当前电站列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:用户登录后，显示的当前自己的电站列表(包括自己创建的和别人共享过来的电站)
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:游标集中包括了当前用户针对各电站的权限信息
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
begin
  EXECUTE IMMEDIATE  'truncate table tmp_stationlist';
  for cur_result in (select  a.userid,a.stationid,a.roleid,a.rightstr,b.co2xs,b.gainxs,nvl(b.money,'$') currency,decode(a.roleid,2,1,a.mailactive) state,b.stationname,b.iconindex,nvl(b.timezone,8) timezone,
                           b.ludt,b.city,b.etotaloffset from tb_userstation a,tb_station b where a.stationid=b.stationid and a.mailactive>=0 and a.userid = i_userid) loop
     vp_get_station_info(cur_result.stationid,v_pmutnum,v_pmu1num,v_invtnum,v_inv1num,v_eventTotalNum,v_eventNewNum);
     select nvl(sum(e_today),0),nvl(sum(h_today),0) into v_etotal,v_htotal from tb_invdaily where stationid = cur_result.stationid;
     --select nvl(sum(e_total),0),nvl(sum(h_total),0) into v_etotal,v_htotal from tb_inverter where stationid = cur_result.stationid;
     --统计当天的发电量
    v_etoday:=fn_get_station_e_today(cur_result.stationid);
    v_etotal:=v_etoday+v_etotal+cur_result.etotaloffset;
     insert into tmp_stationlist( stationid,stationname,state,iconindex,roleid,ludt,inv1num,invtnum,pmu1num,pmutnum,e_total,e_today,co2val,inval,eve0num,rightstr,currency) values(cur_result.stationid,cur_result.stationname,cur_result.state,nvl(cur_result.iconindex,'res/def/bg/defultBg.jpg'),cur_result.roleid,nvl(cur_result.ludt,to_date('2001-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss')),v_inv1num,v_invtnum,v_pmu1num,v_pmutnum,nvl(v_etotal,0),nvl(v_etoday,0),nvl(v_etotal*cur_result.co2xs,0),nvl(v_etotal * cur_result.gainxs,0),nvl(v_eventNewNum,0),nvl(cur_result.rightstr,'1,2,3'),cur_result.currency);
  end loop;
  commit;
  open cur_stationinfo for select stationid,stationname,roleid,rightstr,iconindex,fn_get_val_kwh(e_total) e_total,fn_get_unit_kwh(e_total) e_total_unit,fn_get_val_kwh(e_today) e_today,fn_get_unit_kwh(e_today) e_today_unit,fn_get_val_weight(nvl(co2val,0)) co2val,fn_get_unit_weight(nvl(co2val,0)) co2val_unit,nvl(trunc(inval,2),0) inval,currency inval_unit,pmu1num,pmutnum,inv1num,invtnum,eve0num,nvl(evetnum,0) evetnum,to_char(ludt,'yyyy-mm-dd hh24:mi:ss') ludt,state from tmp_stationlist;
end sp_web_getmystationlist;
/


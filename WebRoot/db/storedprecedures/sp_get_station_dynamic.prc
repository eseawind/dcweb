create or replace procedure sp_get_station_dynamic(i_stationid in number,cur_result out sys_refcursor) is
--获取电站动态信息
v_curdate date;--电站所在时区当前时间
e_total number;
e_today number;
e_month number;--本月发电量
v_eventtnum number;
v_event0num number;
begin
    select nvl(sum(e_today),0) into e_total from tb_invdaily where stationid = i_stationid;
    select sum(e_today) into e_month from tb_invdaily where stationid = i_stationid and to_char(recvdate,'yyyy-mm') = to_char(v_curdate,'yyyy-mm');
    v_eventtnum:=0;
    v_event0num:=fn_getsationeventnewnum(i_stationid);
    e_today:=fn_get_station_e_today(i_stationid);
    e_month:=e_month+e_today;
    e_total:=e_total+e_today;
    open cur_result for select stationname,iconindex,e_today e_today,e_month e_month,e_total e_total,round(e_total*co2xs,2) co2val,e_total * gainxs inval,pmu1num,pmutnum,inv1num,invtnum,v_event0num eve0num,v_eventtnum evetnum,bgurl,ludt from tb_station where stationid = i_stationid;
end sp_get_station_dynamic;
/


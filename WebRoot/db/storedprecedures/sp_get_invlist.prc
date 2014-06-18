create or replace procedure sp_get_invlist(
   i_stationid number,
   cur_result out sys_refcursor
) is
--获取指定电站的逆变器列表
   e_today number;
   e_total number;
   v_station_e_total number;
begin
   v_station_e_total:=fn_get_station_e_today(i_stationid );
   if v_station_e_total >0 then
      open cur_result for select isno,nvl(byname,isno) byname,state,e_today,e_total,pac,pacmax,round(e_today*100/v_station_e_total,1) percentage,fn_getinveventnewnum(isno,i_stationid) eve0num,0 evetnum from tb_inverter where stationid = i_stationid;
    else
      open cur_result for select isno,nvl(byname,isno) byname,state,e_today,e_total,pac,pacmax,0 percentage,fn_getinveventnewnum(isno,i_stationid) eve0num ,0 evetnum from tb_inverter where stationid = i_stationid;
    end if;
end sp_get_invlist;
/


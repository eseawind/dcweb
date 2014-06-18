create or replace procedure vp_get_station_info(
--统计指定电站动态信息
i_stationid in number,
o_pmut out number,--总共PMU数目
o_pmu1 out number,--在线PMU数目
o_invt out number,--总共INV数目
o_inv1 out number,--在线INV数目
o_eventt out number,--总共事件总数
o_event0 out number--未读事件总数
) is
begin
   select count(1) into o_eventt from tb_event_all
      where stationid =i_stationid /*and ssno in (
         select isno ssno from tb_inverter where stationid = i_stationid union
         select psno ssno from tb_pmu where stationid = i_stationid)*/
      and c_tag =0;
   --未读取新事件数目Val1:--1:信息,2:警告,3:错误
   select count(1) into o_event0 from tb_event_all
      where stationid = i_stationid /*and ssno in (
         select isno ssno from tb_inverter where stationid = i_stationid union
         select psno ssno from tb_pmu where stationid = i_stationid)*/
      and val1=3 and l_tag=0 and c_tag = 0;
   select count(1)into  o_pmut from tb_pmu where stationid = i_stationid;
   select count(1) into o_pmu1 from tb_pmu where stationid = i_stationid and state = 1 ;
   if (o_pmu1 >0) then
       select count(1) into o_inv1 from tb_inverter where stationid = i_stationid and state = 1;
    else
      o_inv1:=0;
    end if;
    select count(1) into o_invt from tb_inverter where stationid = i_stationid;
end vp_get_station_info;
/


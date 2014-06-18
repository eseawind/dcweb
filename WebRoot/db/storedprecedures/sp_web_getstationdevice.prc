create or replace procedure sp_web_getstationdevice(
i_stationid number,--电站编号
cur_list out sys_refcursor --设备列表
) is
--为电站提供简单设备列表查询
begin
  open cur_list for select isno ssno,nvl(byname,isno) byname,2 devt from tb_inverter where stationid = i_stationid union
  select psno ssno,nvl(byname,psno) byname,1 devt from tb_pmu where stationid = i_stationid order by devt,ssno;
end sp_web_getstationdevice;
/


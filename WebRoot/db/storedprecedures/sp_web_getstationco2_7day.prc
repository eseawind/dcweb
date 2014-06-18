create or replace procedure SP_Web_GetStationCo2_7Day(
i_stationid in number,--电站编号
i_date in varchar2,--开始日期
curmain out sys_refcursor--查询结果集
) IS
/*================================================================
功能说明:查询指定电站指定结束日期的前七天的二氧化碳减排量
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Co2/7 Days
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_querydate date;
v_rangdts date;
v_rangdte date;
v_co2rate number;
v_e_today number;
v_m number;
v_r number;
v_u varchar2(10);
v_curdate date;--电站所在时区当前时间
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   v_querydate := to_date(i_date,'yyyy-mm-dd');
   v_rangdts:=v_querydate-6;
   v_rangdte:=v_querydate;
   --
   select nvl(co2xs,0.2) into v_co2rate from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1)
                          select to_char(nvl(b.recvdate,v_querydate+c.idd-7),'yyyy-mm-dd'),nvl(b.co2val,0) from
                                   (select idd from tb_serial where idd between 1 and 7) c,
                                   (select recvdate+7-v_querydate dayid,a.* from
                                          (select recvdate,sum(e_today)*v_co2rate co2val from tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid group by recvdate
                                           ) a ) b
                                    where c.idd =b.dayid(+);
   v_e_today:=fn_get_station_e_today(i_stationid);
   if v_e_today>0 then
      update tmp_info set nv1 = nv1+v_e_today*v_co2rate where sv1 = to_char(v_curdate,'yyyy-mm-dd');
   end if;
   commit;
   select max(nv1) into v_m from tmp_info;
   v_r:=fn_get_rate_weight(v_m,v_u);
   open curmain for select sv1 recvdate,round(nv1/v_r,2) co2val,v_u unit from tmp_info order by recvdate;
end SP_Web_GetStationCo2_7Day;
/


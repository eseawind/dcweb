create or replace procedure SP_Web_GetStationGain_7Day(
i_stationid in number,--电站编号
i_date in varchar2,--查询日期
curmain out sys_refcursor
) IS
/*================================================================
功能说明:查询指定电站及查询日期之前七天(包括所指定日期当天)收益情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Yield/7 Days
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
v_Gainrate number;--收益系数
v_e_today number;
v_currency varchar2(16);
v_curdate date;--电站所在时区当前时间
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   --
   v_querydate := to_date(i_date,'yyyy-mm-dd');
   v_rangdts:=v_querydate-6;
   v_rangdte:=v_querydate;
   --
   select nvl(Gainxs,0.2),nvl(money,'$') into v_Gainrate,v_currency from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1)
        select to_char(nvl(b.recvdate,v_querydate+c.idd-7),'yyyy-mm-dd') recvdate,nvl(b.Gainval,0) Gainval from (select idd from tb_serial where idd between 1 and 7) c,(select recvdate+7-v_querydate dayid,a.* from
                      (select recvdate,sum(e_today)*v_Gainrate Gainval from tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid group by recvdate)
                       a)b where c.idd =b.dayid(+);
   v_e_today:=fn_get_station_e_today(i_stationid);
   if v_e_today >0 then
      update tmp_info set nv1 = nv1+v_e_today*v_Gainrate where sv1 = to_char(v_curdate,'yyyy-mm-dd');
   end if;
   commit;
   open curmain for select sv1 recvdate,nv1 Gainval,v_currency unit from tmp_info order by recvdate;
end SP_Web_GetStationGain_7Day;
/


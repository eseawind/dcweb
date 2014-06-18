create or replace procedure SP_Web_GetStationGain_All(
i_stationid in number,--电站编号
curmain out sys_refcursor
) IS
/*================================================================
功能说明:查询指定电站各年收益情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Yield/Total
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_gainrate number;--二氧化碳减排系数
v_currency varchar2(16);
v_today number;
v_curdate date;--电站所在时区当前时间
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   select nvl(gainxs,0.2),nvl(money,'$') into v_gainrate,v_currency from tb_station where stationid  =i_stationid;

   insert into tmp_info(sv1,nv1) select to_char(recvdate,'yyyy') recvdate,sum(e_today) e_total from tb_invdaily
                                  where stationid = i_stationid group by to_char(recvdate,'yyyy')
                            ;
   v_today:=fn_get_station_e_today(i_stationid);
   if v_today >0 then
      update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy');
   end if;
   commit;
   open curmain for select sv1 recvdate,round(nv1*v_gainrate,1) Gainval,v_currency unit from  tmp_info order by recvdate;
end SP_Web_GetStationGain_All;
/


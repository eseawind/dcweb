create or replace procedure SP_Web_GetStationGain_Year(
i_stationid in number,--电站编号
i_year in varchar2,--查询年(如2012年)
curmain out sys_refcursor
) IS
/*================================================================
功能说明:查询指定电站及指定年各月收益情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Yield/Year
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
v_month number;
v_year number;
v_currency varchar2(16);
v_gainrate number;--二氧化碳减排系数
v_today number;
v_curdate date;--电站所在时区当前时间
begin
  execute immediate 'truncate table tmp_info';
  v_curdate:=fn_get_station_local_date(i_stationid);
   v_querydate := to_date(i_year||'12-01','yyyy-mm-dd');
   v_rangdts:=to_date(to_char(v_querydate,'yyyy')||'-01-01','yyyy-mm-dd');
   v_rangdte:=to_date(to_char(v_querydate,'yyyy')||'-12-31','yyyy-mm-dd');
   v_month:=to_number(to_char(v_querydate,'mm'));
   v_year:=to_number(to_char(v_querydate,'yyyy'));

   select nvl(gainxs,0.2),nvl(money,'$') into v_gainrate,v_currency from tb_station where stationid  =i_stationid;
   insert into tmp_info(sv1,nv1) select nvl(b.recvdate,fn_get_yearmonth(v_year,v_month,a.idd)) recvdate,nvl(b.e_total,0) e_total from(select idd from tb_serial where idd between 1 and 12)a,
                           (select recvdate,to_number(substr(recvdate,6,2)) mid,e_total from ( select to_char(recvdate,'yyyy-mm') recvdate,sum(e_today) e_total from tb_invdaily
                                  where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid group by to_char(recvdate,'yyyy-mm')
                            ))b where a.idd = b.mid(+) ;
 v_today:=fn_get_station_e_today(i_stationid);
   if v_today >0 then
       update tmp_info set nv1=nv1+v_today where sv1  = to_char(v_curdate,'yyyy-mm');
   end if;
   commit;
   open curmain for select sv1 recvdate,round(nv1*v_gainrate,2) Gainval,v_currency unit from tmp_info order by recvdate;
end SP_Web_GetStationGain_Year;
/


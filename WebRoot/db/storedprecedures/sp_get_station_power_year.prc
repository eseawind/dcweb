create or replace procedure sp_get_station_power_year(
i_stationid number,--要查询的电站编号
i_year varchar2,--要查询的年份
o_startdt out varchar2,--输出查询范围的开始日期
o_enddt out varchar2,--输出查询范围的结束日期
cur_power out sys_refcursor--查询结果集输出
) is
/*================================================================
功能说明:获取一年内各月发电量信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Overview/Power/Year
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rangdts date;
v_rangdte date;
v_year number;
v_max number;
v_unit varchar2(10);
v_rate number;
v_today number;--今日发电量
v_curdate date;--电站所在时区当前时间
begin
   execute immediate 'truncate table tmp_info';
   v_curdate:=fn_get_station_local_date(i_stationid);
   if i_year = to_char(v_curdate,'yyyy') then
      v_today:=fn_get_station_e_today(i_stationid);
   else
      v_today:=0;
   end if;
   v_year:=to_number(i_year);
   if v_year > 2000  and v_year < 2050 then
      v_rangdts:=to_date(i_year||'-01-01','yyyy-mm-dd');
      v_rangdte :=last_day(to_date(i_year||'-12-01','yyyy-mm-dd'));
      o_startdt :=to_char(v_rangdts,'yyyy-mm-dd');
      o_enddt:=to_char(v_rangdte,'yyyy-mm-dd');
      insert into tmp_info(sv1,idd,nv1) select nvl(b.recvdate,v_year||'-'||to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from tb_serial a,(
           select recvdate,to_number(substr(recvdate,6,2)) idd,e_total from(
                 select to_char(recvdate,'yyyy-mm') recvdate,sum(e_today) e_total from  tb_invdaily where (recvdate between v_rangdts and v_rangdte) and stationid = i_stationid  group by to_char(recvdate,'yyyy-mm')
                 )
           )b where a.idd = b.idd(+) and a.idd between 1 and 12 order by idd;
      if v_today > 0 then
         update tmp_info set nv1 = nv1+v_today where sv1 = to_char(v_curdate,'yyyy-mm');
      end if;
      commit;
      select max(nv1) into v_max from tmp_info;
      v_rate:=fn_get_rate_kwh(v_max,v_unit);
      open cur_power for select sv1 recvdate,idd,round(nv1/v_rate,3) e_total,v_unit e_total_unit from tmp_info;
   end if;
end sp_get_station_power_year;
/


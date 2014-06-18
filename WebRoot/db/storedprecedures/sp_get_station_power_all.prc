create or replace procedure sp_get_station_power_all(
i_stationid number,--要查询的电站编号
cur_power out sys_refcursor --查询结果集
) is
/*================================================================
功能说明:获取某一电站各年发电量信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Overview/Power/Total
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_r number;
v_u varchar2(10);
v_m number;
v_today number;
v_curdate date;--电站所在时区当前时间
begin
     execute immediate 'truncate table tmp_info';
     v_curdate:=fn_get_station_local_date(i_stationid);
     v_today:=fn_get_station_e_today(i_stationid);
     insert into tmp_info(sv1,nv1)  select year,e_total from (
                                            select year,sum(e_total) e_total from
                                                 (select to_char(recvdate,'yyyy') year,isno,sum(e_today) as e_total from tb_invdaily where  stationid = i_stationid group by to_char(recvdate,'yyyy'),isno) group by year);
     select count(1) into v_m from tmp_info;
     if v_m >0 then
        update tmp_info set nv1 = nv1+v_today where sv1=to_char(v_curdate,'yyyy');
     else
        insert into tmp_info (sv1,nv1) values (to_char(v_curdate,'yyyy'),v_today);
     end if;
     
     commit;
     select max(nv1) into v_m from tmp_info;
     v_r:=fn_get_rate_kwh(v_m,v_u);
     open cur_power for select sv1 year,round(nv1/v_r,3) e_total,v_u e_total_unit from tmp_info order by sv1;
end sp_get_station_power_all;
/


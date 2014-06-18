create or replace procedure sp_get_inv_energy_monthex(
i_stationid in number,--电站编号
i_isnolist varchar2,--要查询的逆变器列表
i_yearmonth in varchar2,--输入查询日期
o_startdt out varchar2,
o_enddt out varchar2,
cur_result out sys_refcursor--输入结果集
) is
/*================================================================
功能说明:查询指定电站,指定逆变器列表，指定月份各天的发电量情况
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Energy&Power/Month
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
v_daynum number;
v_unit varchar2(10);
v_max number;
v_rate number;
v_today number;
v_curdate date;--电站所在时区当前时间
begin
   execute immediate 'truncate table tmp_info';
   v_rangdts:=to_date(i_yearmonth||'-01','yyyy-mm-dd');
   v_rangdte :=last_day(v_rangdts);
   v_daynum :=to_number(to_char(v_rangdte,'dd'));
   o_startdt :=to_char(v_rangdts,'yyyy-mm-dd');
   o_enddt:=to_char(v_rangdte,'yyyy-mm-dd');
   v_curdate:=fn_get_station_local_date(i_stationid);
   for curt in (select nvl(byname,isno) byname,isno from tb_inverter where stationid = i_stationid) loop
      if instr(i_isnolist,curt.isno,1,1)>0 or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' )  then
         insert into tmp_info(sv1,sv2,sv3,idd,nv1)
         select curt.isno,curt.byname,nvl(to_char(b.recvdate,'yyyy-mm-dd'),i_yearmonth||'-'|| to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_today,0) e_total from
            (select idd from tb_serial where idd between 1 and v_daynum) a,
            (select isno,recvdate,e_today,to_number(to_char(recvdate,'dd')) idd  from  tb_invdaily
            where (recvdate between v_rangdts and v_rangdte) and isno = curt.isno and stationid = i_stationid
            )b where a.idd = b.idd(+) order by idd;

         if i_yearmonth = to_char(v_curdate,'yyyy-mm') then
            v_today:=fn_get_inv_e_today(curt.isno,i_stationid);
            if v_today>0 then
               update tmp_info set nv1 = nv1+v_today where sv1 = curt.isno and sv3 = to_char(v_curdate,'yyyy-mm-dd');
            end if;
         end if;
      end if;
   end loop;
   commit;
   select max(nv1) into v_max from tmp_info;
   v_rate:=fn_get_rate_kwh(v_max,v_unit);
   open cur_result for select sv1 isno,sv2 byname,sv3 recvdate,idd,round(nv1 /v_rate,3) data1/*e_total*/,v_unit e_total_unit,1 res_num from tmp_info order by sv1,sv3;
end sp_get_inv_energy_monthex;
/


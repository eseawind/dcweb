create or replace procedure SP_GET_INV_IAC_DAYex(
i_stationid number,--电站编号
i_isnolist in varchar2,--逆变器列表
i_date varchar2,--查询日期
curmain out sys_refcursor
) is
/*================================================================
功能说明:查询指定电站，指定逆变器列表，指定日期的10分钟交流电流值数据
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Temp/Day
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
   v_tablename varchar2(32);
   v_querydate date;
   v_sql varchar2(1000);
begin
   execute immediate 'truncate table tmp_info';
   --
   v_querydate := to_date(i_date,'yyyy-mm-dd');
   v_tablename:='tb_inv' || to_char(v_querydate,'yyyymmdd');
   --
   for curt in (select nvl(byname,isno)byname ,isno from tb_inverter where stationid = i_stationid) loop
      if instr(i_isnolist,curt.isno,1,1)>0  or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' )  then
         v_sql:='insert into tmp_info(idd,sv1,sv2,sv3,sv4,nv1,nv2,nv3)
                  select a.idd,:isno_ ,:byname__,:date_,fn_gettimebyfen10(a.idd),nvl(b.iac1,0),nvl(b.iac2,0),nvl(b.iac3,0) from tb_serial a left join
                 (select distinct recvdate,fen10,iac1,iac2,iac3 from '||v_tablename||' where isno = :isno__) b on a.idd =b.fen10';
         execute immediate v_sql using curt.isno,curt.byname,to_char(v_querydate,'yyyy-mm-dd'),curt.isno;
      end if;
   end loop;
   commit;
   open curmain for select sv1 isno,sv2 byname,sv3 recvdt,sv4 rtime,idd fen10,nv1 data1/*iac1*/,nv2 data2/*iac2*/,nv3 data3/*iac3*/,'A' unit,3 res_num from tmp_info order by isno,recvdt,fen10;
end SP_GET_INV_IAC_DAYex;
/


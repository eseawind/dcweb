create or replace procedure SP_GET_INV_IDC_7DAY(
i_stationid number,--电站编号
i_isnolist in varchar2,--查询逆变器列表
i_date     varchar2,--查询日期
curmain    out sys_refcursor) is
/*================================================================
功能说明:查询指定电站，指定逆变器列表，指定日期前七天(包括输入的当天)范围内的的10分钟直流电流值数据
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:Graphs/Idc/7 Days
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
   v_sql       varchar2(1000);
begin
   --
   v_querydate := to_date(i_date, 'yyyy-mm-dd') - 7;
   --
   execute immediate 'truncate table tmp_info';
   for daynum in 1 .. 7 loop
      v_querydate := v_querydate + 1;
      v_tablename := 'tb_inv' || to_char(v_querydate, 'yyyymmdd');
      for curt in (select nvl(byname,isno)byname ,isno,nvl(pvnum,3) pvnum from tb_inverter where stationid = i_stationid) loop
         if instr(i_isnolist,curt.isno,1,1)>0  or (SUBSTR (i_isnolist,1,7)='23Q0001' and SUBSTR (curt.isno,1,7)='23Q0001' )  then
            v_sql := 'insert into tmp_info(idd,sv1,sv2,sv3,nv1,nv2,nv3,nv4)
                  select a.idd,:isno_ ,:date_,fn_gettimebyfen10(a.idd),nvl(b.ipv1,0),nvl(b.ipv2,0),nvl(b.ipv3,0),:res_num_ from tb_serial a left join
                 (select distinct recvdate,fen10,ipv1,ipv2,ipv3 from ' ||
               v_tablename || ' where isno = :isno__) b on a.idd =b.fen10';
            execute immediate v_sql
            using curt.byname, to_char(v_querydate, 'yyyy-mm-dd'),curt.pvnum,curt.isno;
         end if;
      end loop;
   end loop;
   commit;
   open curmain for
      select sv1 isno,
           sv2 recvdt,
           sv3 rtime,
           idd fen10,
           nv1 data1/*idc1*/,
           nv2 data2/*idc2*/,
           nv3 data3/*idc3*/,'A' unit,nv4 res_num
      from tmp_info
      order by isno, recvdt, fen10;
end SP_GET_INV_IDC_7DAY;
/


create or replace procedure sp_report_data_service(
i_stationid number,--电站编号
i_reportid number,--报告编号,1:每日报告,2:每月报告,3:事件报告
i_itemstr varchar2,--报告配置字符串

/*
a,b,c,d,e,f,g,h,i,j,k
1:=========================每日报告
a:当日发电量
b:当日发电峰量PAC_MAX
c:当日收益
d:当日Co2减排
e:总发电量
f:总收益
g:总C02减排量
2:========================每月报告
a:当月发电量
b:本月发电量峰值
c:当月收益
d:当月c02
e:总发电量
f:总收闪
g:总c02减排
3:========================事件报告
a:没有事件，是否发送报告,1:发送，0:不发送
b:单邮件，最多事件条数,为事件数值
c:信息是否发送,1：发送，0:不发送
d:错误是否发送,1:发送，0:不发送
e:开始时间
f:结束时间
g:语言种类
example:1,1,100,1,2012-06-27 00:00:00,2012-06-27 23:59:59,en_US


*/
cur_main out sys_refcursor,
cur_slaver out sys_refcursor
) is
/*================================================================
功能说明:邮件报告发送数据服务
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:日，月,事件报告数据服务
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_sql varchar2(1000);
v_tablename varchar2(32);--当天电量所在的表名称
/*-------------日报告变量---------月报告变量-------------事件报告*/
v_val1 number;/*累计发电量--------累计发电量-------------masterid*/
v_val2 number;/*时区--------------时区-------------------信息是否发送*/
v_val3 number;/*今日发电量--------本月发电量-------------错误是否发送*/
v_val4 number;/*收益系数----------收益系数----------------事件条数-------*/
v_val5 number;/*Co2系数-----------Co2系数------------------------*/
v_val6 number;/*max pac-----------最大发电量值-------------------*/
v_val7 number;/*pac 转换系数------发电量显示系数-----------------*/
v_val8 number;/*masterid----------查询月天数---------------------*/
v_val9 number;/*------------------masterid-----------------------*/
v_str1 varchar2(30);/*货币符号----货币符号---------------语言种类*/
v_str2 varchar2(60);/*PAC单位-----发电量单位-------------用户姓名*/
v_str3 varchar2(60);/*用户姓名----月份-------------------用户姓名*/
v_str4 varchar2(60);/*用户姓名----用户姓名---------------电站名称*/
v_str5 varchar2(60);/*电站名称----用户姓名-----------------------*/
v_str6 varchar2(60);/*------------电站名称-----------------------*/
v_date1 date;/*当日日期-----------当月开始日期---事件开始日期----*/
v_date2 date;/*-------------------当月结束日期---事件结束日期----*/
v_temp number;
v_etotaloffset number;
begin
   if i_reportid = 1 then
     --日报告只发送当天的报告
     select nvl(sum(e_today),0) into v_val1 from tb_invdaily where stationid = i_stationid;
     select timezone,nvl(money,'$'),co2xs,gainxs,masterid,stationname,etotaloffset  into v_val2,v_str1,v_val5,v_val4,v_val8,v_str5,v_etotaloffset from tb_station where stationid = i_stationid;
     select firstname,secondname into v_str3,v_str4 from tb_user where userid = v_val8;
     select GetLocalCurrentDatetime(v_val2) into v_date1 from dual;
     --v_date1 :=to_date('2013-03-05 18:30:30','yyyy-mm-dd hh24:mi:ss');
     v_temp := (v_date1-trunc(v_date1))*24;
     --根据当前用户本地时间判断,在06:30之前的时间为昨天的日报,之后为当天日报
     if v_temp <6.5 then
        v_date1:=v_date1 -1;
     end if;
     v_tablename:='tb_inv' || to_char(v_date1,'yyyymmdd');
     execute immediate 'select nvl(sum(e_today),0) from (select isno,max(e_today) e_today from '||v_tablename ||' where stationid = :stationid group by isno)'
             into v_val3 using i_stationid;
     v_val1:=v_val1+v_val3 + v_etotaloffset;
     execute immediate 'truncate table tmp_info';
     v_sql := 'insert into tmp_info(sv1,nv1,nv2)
               select fn_gettimebyfen10(a.idd) rtime,a.idd fen10,nvl(b.pac,0) pac from
                           tb_serial a,
                           ( select  fen10,sum(pac) pac from
                                     ( select isno,fen10,round(avg(pac),1) pac from  ' || v_tablename||'
                                             where stationid = :stationid__ group by isno,fen10 )
                                     group by fen10 order by fen10) b
                 where a.idd = b.fen10(+) order by fen10 asc';
       execute immediate v_sql using i_stationid;
       commit;
       select max(nv2) into v_val6 from tmp_info;
      open cur_main for select  v_str3 firstname,v_str4 secondname,v_str5 stationname,to_char(fn_get_val_kwh(v_val3),'fm9999999990.00')||fn_get_unit_kwh(v_val3) e_today,
                               to_char(fn_get_val_w(v_val6),'fm9999999990.00')||fn_get_unit_w(v_val6) power_max,
                               to_char(v_val3 * v_val4,'fm9999999990.00')||v_str1 in_today,
                               to_char(fn_get_val_weight(v_val3*v_val5),'fm9999999990.00')||fn_get_unit_weight(v_val3*v_val5) Co2_today,
                               to_char(fn_get_val_kwh(v_val1),'fm9999999990.00')||fn_get_unit_kwh(v_val1) e_total,
                               to_char(v_val1*v_val4,'fm9999999990.00')||v_str1 in_Total,
                               to_char(fn_get_val_weight(v_val1*v_val5),'fm9999999990.00')||fn_get_unit_weight(v_val1*v_val5) co2_total,
                               to_char(v_date1,'yyyy-mm-dd') startdt,
                               to_char(v_date1,'yyyy-mm-dd') enddt
                        from dual;
      v_val7:=fn_get_rate_power(v_val6,v_str2);
      open cur_slaver for select sv1 rtime,nv1 fen10,round(nv2/v_val7,3) pac,v_str2 unit from tmp_info;
--===============================================================================================================================
   elsif i_reportid=2 then
   --当前日期如果在这个月天数小于3，则发送上一个月的报告，如果>3天，则发当月的月报
   select timezone,nvl(money,'$'),co2xs,gainxs,masterid,stationname,etotaloffset  into v_val2,v_str1,v_val5,v_val4,v_val9,v_str6,v_etotaloffset from tb_station where stationid = i_stationid;
   select firstname,secondname into v_str4,v_str5 from tb_user where userid = v_val9;
     select nvl(sum(e_today),0) into v_val1 from tb_invdaily where stationid = i_stationid;
     v_val1:= v_val1 + v_etotaloffset;
     --判断取本月的还是上月的数据
     select GetLocalCurrentDatetime(v_val2) into v_date1 from dual;
     if to_number(to_char(v_date1,'dd'))<3 then
         v_date1:=add_months(v_date1,-1);
     end if;
     v_date1:=to_date(to_char(v_date1,'yyyy-mm')||'-01','yyyy-mm-dd');
     v_date2:=last_day(v_date1);
     v_val8 :=to_number(to_char(last_day(v_date1),'dd'));
     execute immediate 'truncate table tmp_info';
     insert into tmp_info(sv1,idd,nv1) select nvl(recvdate,to_char(v_date1,'yyyy-mm')||'-'|| to_char(a.idd,'fm00')) recvdate,a.idd,nvl(b.e_total,0) e_total from tb_serial a,(
                               select recvdate,to_number(substr(recvdate,9,2)) idd,e_total from(
                                     select to_char(recvdate,'yyyy-mm-dd') recvdate,sum(e_today) e_total from  tb_invdaily where (recvdate between v_date1 and v_date2) and stationid = i_stationid  group by to_char(recvdate,'yyyy-mm-dd')
                                     )
                               )b where a.idd = b.idd(+) and a.idd between 1 and v_val8 order by idd;
     commit;
     select max(nv1) into v_val6 from tmp_info;
     v_str3:=to_char(v_date1,'yyyy-mm');
     select nvl(sum(e_today),0) into v_val3 from tb_invdaily where stationid = i_stationid and to_char(recvdate,'yyyy-mm') = v_str3;
     open cur_main for select
                       v_str4 firstname,v_str5 secondname,v_str6 stationname,
                       fn_get_val_kwh(v_val3)||fn_get_unit_kwh(v_val3) e_month,
                       fn_get_val_kwh(v_val6)||fn_get_unit_kwh(v_val6) pac_max,
                       trunc(v_val3 * v_val4,2)||v_str1 in_month,
                       fn_get_val_weight(v_val3*v_val5)||fn_get_unit_weight(v_val3*v_val5) co2_month,
                       fn_get_val_kwh(v_val1)||fn_get_unit_kwh(v_val1) e_total,
                       trunc(v_val1*v_val4,2)||v_str1 in_Total,
                       fn_get_val_weight(v_val1*v_val5)||fn_get_unit_weight(v_val1*v_val5) co2_total,
                       to_char(v_date1,'mm/yyyy')  startdt,
                       to_char(v_date2,'mm/yyyy')  enddt
                       from dual;
     v_val7:=fn_get_rate_kwh(v_val6,v_str2);
     open cur_slaver for select sv1 recvdate,idd,round(nv1 /v_val7,3) e_total,v_str2 e_total_unit from tmp_info;
--===============================================================================================================================
   elsif i_reportid =3 then
   --发送事件报告的时间范围取决于参数所指定的日期时间范围
     v_date1:=to_date(fn_getmidstr(i_itemstr,5,','),'yyyy-mm-dd hh24:mi:ss');
     v_date2:=to_date(fn_getmidstr(i_itemstr,6,','),'yyyy-mm-dd hh24:mi:ss');
     v_val4:=to_number(fn_getmidstr(i_itemstr,2,','));
     if to_number(fn_getmidstr(i_itemstr,3,','))= 1 then
        v_val2:=1;
     else
        v_val2:=0;
     end if;
     if to_number(fn_getmidstr(i_itemstr,4,','))=1 then
        v_val3:=3;
     else
       v_val3:=0;
     end if;
     v_str1:=fn_getmidstr(i_itemstr,7,',');
     select masterid,stationname  into v_val1,v_str4 from tb_station where stationid = i_stationid;
     select firstname,secondname into v_str2,v_str3 from tb_user where userid = v_val1;
     open cur_main for select v_str2 firstname,v_str3 secondname,v_str4 stationname,to_char(v_date1,'dd/mm/yyyy') startdt,to_char(v_date2,'dd/mm/yyyy') enddt from dual;
     open cur_slaver for select a.did,a.ssno,decode(v_str1,'zh_CN',decode(a.val1,1,'信息',2,'警告',3,'错误',to_char(a.val1)),decode(a.val1,1,'info',2,'warring',3,'error',to_char(a.val1))) msgtype,a.occdt,nvl(b.context,to_char(a.val2)) context
       from  (select did,ssno,val1,val2,occdt from tb_event_all where (occdt between v_date1 and v_date2)and ssno in (select isno ssno from tb_inverter where stationid = i_stationid) and stationid=i_stationid and c_tag = 0 and val1 in(v_val2,v_val3) and rownum < v_val4 order by did desc)a,
             (select val1,val2,context from tb_dict_ssiis where language=v_str1 and subtag = 'pmuerrcode')b
       where (a.val2 =b.val2(+)) and a.val1=b.val1 order by  occdt;
   else
     open cur_main for select 1,1,1 from dual;
   end if;

end sp_report_data_service;
/


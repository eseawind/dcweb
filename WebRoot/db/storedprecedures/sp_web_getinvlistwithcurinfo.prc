create or replace procedure sp_web_getinvlistwithcurinfo(
i_stationid number,
cur_list out sys_refcursor
) is
--网站获得逆变器列表及当前设备状态
--适用概览-发电量下列表
v_estationtoday number;
v_e_total_max number;
v_e_today_max number;
v_pac_max number;
v_unit1 varchar2(16);
v_unit2 varchar2(16);
v_unit3 varchar2(16);
v_rate1 number;
v_rate2 number;
v_rate3 number;
--
v_timezone number;
v_curdate date;
v_tablename varchar2(32);--当天电量所在的表名称
begin
   EXECUTE IMMEDIATE  'truncate table tmp_info';
   select nvl(timezone,8) into  v_timezone from tb_station where stationid = i_stationid;
              select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
   v_tablename:='tb_inv' || to_char(v_curdate,'yyyymmdd');
  execute immediate
        'insert into tmp_info(sv1,sv2,nv1,nv2,nv3,nv4,nv5)
        select f.isno,f.byname,f.state,f.e_today,f.e_total,g.pac,f.pacmax from
          (select a.isno,a.byname,a.state,a.e_today,nvl(c.e_total,0) e_total,a.pacmax,a.idid from
             (select isno,byname,state,e_today,pacmax,idid from
                 (select d.isno,d.byname,d.state,nvl(e.e_today,0) e_today,nvl(e.pacmax,0) pacmax,e.idid from
                    (select isno,nvl(byname,isno) byname,state from tb_inverter where stationid = :stationid_)d,
                    (select max(e_today) e_today,max(pac) pacmax,isno,max(idid) idid from '||v_tablename||' where stationid = :stationid__ group by isno)e
                     where d.isno = e.isno(+))
              )a,
              (select e_total,isno from tb_inverter where stationid = :stationid____x
              ) c
              where a.isno = c.isno(+)) f,
              '||v_tablename ||' g
              where f.idid = g.idid(+)
              '
                using i_stationid,i_stationid,i_stationid;
 --  select max(nv3),max(nv4),max(nv5),sum(nv4) into v_pac_max,v_e_today_max,v_e_total_max,v_estationtoday from tmp_info;
   select max(nv4),max(nv2),max(nv3),sum(nv2) into v_pac_max,v_e_today_max,v_e_total_max,v_estationtoday from tmp_info;
   v_rate1:=fn_get_rate_kwh(v_e_today_max,v_unit1);
   v_rate2:=fn_get_rate_kwh(v_e_total_max,v_unit2);
   v_rate3:=fn_get_rate_power(v_pac_max,v_unit3);
   update tmp_info set nv1 = 0 where sv1 in
          (select isno from tb_inverter where psno in(select psno from tb_pmu where stationid = i_stationid and state = 0 ));
   commit;
   open cur_list for select a.sv1 isno,a.sv2 byname,a.nv1 state,
                         round(nv4/v_rate1,3) e_today,
                         v_unit1 e_today_u,
                         round(nvl(nv5,0) /v_rate2,3) e_total,
                         v_unit2 e_total_u,
                         round(nvl(nv2,0)/v_rate3,3) pac,
                         v_unit3 pac_u,
                         round(nv3/v_rate3,3) pacmax,
                         v_unit3 pacmax_u,
                         round(decode(v_estationtoday,0,0,nv4*100/v_estationtoday),2) et_percent,nvl(b.newt,0) eve0num,nv7 evetnum from 
                         tmp_info a,
                         (select ssno,count(1) newt from tb_event_all where val1 =3 and c_tag = 0 and l_tag = 0 and stationid = i_stationid group by ssno) b
                         where a.sv1 = b.ssno(+)
                         order by state desc,isno;
end sp_web_getinvlistwithcurinfo;
/


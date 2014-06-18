create or replace procedure sp_getstationdevice(
i_stationid in number,
cur_result out sys_refcursor
) is
--获取当前电站设备列表
v_stationetotaay number;
v_pacpercent number;
v_timezone number;
v_curdate date;
v_tablename varchar2(32);--当天电量所在的表名称
v_val number;
begin
   EXECUTE IMMEDIATE  'truncate table tmp_devicelist';
   execute immediate 'truncate table tmp_info';
   select nvl(timezone,8) into  v_timezone from tb_station where stationid = i_stationid;
              select GetLocalCurrentDatetime(v_timezone) into v_curdate from dual;
              v_tablename:='tb_inv' || to_char(v_curdate,'yyyymmdd');
   execute immediate 'select sum(e_today) from (select nvl(max(e_today),0) e_today  from '|| v_tablename ||' where stationid = :1 group by isno)' into v_stationetotaay using i_stationid;
   insert into tmp_info(sv1,nv1,nv2)
   select a.ssno,a.rn,b.rn from
       (select count(1) rn,ssno from tb_event_all where val1 =3 and stationid = i_stationid and c_tag= 0 group by ssno) a,
       (select  count(1) rn,ssno from tb_event_all where val1 =3 and stationid = i_stationid and l_tag = 0 and c_tag = 0 group by ssno )b where a.ssno=b.ssno(+);
   for cur in (select a.psno,nvl(a.byname,psno) byname,a.state,nvl(b.nv1,0), fn_getinveventnewnum(a.psno,a.stationid) eve0num,nvl(b.nv2,0) evetnum,subtype pmutype from tb_pmu a,tmp_info b where a.psno = b.sv1(+) and stationid = i_stationid order by state desc,psno) loop
      insert into tmp_devicelist(devtyp,devno,byname,state,newnum,totalnum) values(1,cur.psno,cur.byname,cur.state,cur.eve0num,cur.evetnum);
      for curt in (select isno,nvl(byname,isno) byname,state,e_total,pac,pacmax,fn_getinveventnewnum(isno,stationid) eve0num,0 evetnum from tb_inverter where psno = cur.psno order by state desc,isno) loop
        execute immediate 'select nvl(max(e_today),0) from '||v_tablename ||' where isno =:isno_' into v_val using curt.isno;
        if v_stationetotaay >0 then
            v_pacpercent :=round(v_val/v_stationetotaay,2);
        else
           v_pacpercent :=0;
        end if;
         insert into tmp_devicelist(devtyp,devno,byname,state,today,total,pac,peak,percetage,newnum,totalnum)
                     values(2, curt.isno,curt.byname,decode(cur.state,0,0,curt.state),v_val,curt.e_total,curt.pac,curt.pacmax,v_pacpercent,curt.eve0num,curt.evetnum);
      end loop;
   end loop;
   commit;
   open cur_result for select devtyp,devno,byname,state,newnum,totalnum from tmp_devicelist;
end sp_getstationdevice;
/


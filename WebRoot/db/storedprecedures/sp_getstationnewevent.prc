create or replace procedure sp_getstationnewevent(
i_userid number,
i_lan in varchar2,
cur_result out sys_refcursor
) is
/*获取指定用户下的各电站新事件列表
只显示错误msgtype=3,msgtype=1,2信息和警告不显示*/
v_rownum number;
v_curdate date;
begin
   execute immediate 'truncate table tmp_station_new_event';
   for cur_s in (select a.stationid,b.stationname,b.timezone from tb_userstation a,tb_station b where (a.stationid = b.stationid and a.userid = i_userid)and a.roleid =2)  loop
   --查询该用户为管理员的电站ID号
      v_curdate := getlocalcurrentdatetime(cur_s.timezone)-5/24/60;
      for cur_dev in (select psno ssno,byname from tb_pmu where stationid = cur_s.stationid union select isno ssno,byname from tb_inverter where stationid = cur_s.stationid)  loop
         insert into tmp_station_new_event(did,STATIONNAME,ssno,byname,occdt,describle)
             select a.did,cur_s.stationname,cur_dev.ssno,nvl(cur_dev.byname,cur_dev.ssno),a.occdt,nvl(b.context,to_char(a.val2))
             from  (select did,occdt,val2 from tb_event_all where ssno =cur_dev.ssno and val1=3 and l_tag = 0 and c_tag = 0 and occdt > v_curdate order by did desc) a,
                   (select val2,context from tb_dict_ssiis where language = i_lan and val1=3 and subtag = 'pmuerrcode' ) b
                    where a.val2 =b.val2(+) ;
      end loop;
  end loop;
  select count(1) into v_rownum from tmp_station_new_event;
  if v_rownum >0 then
     update tb_event_all set l_tag = 1 where did in (select did from tmp_station_new_event);
  end if;
  commit;
  open cur_result for select stationname,ssno,byname,occdt,describle from tmp_station_new_event;
end sp_getstationnewevent;
/


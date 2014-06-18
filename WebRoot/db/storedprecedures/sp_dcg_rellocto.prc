create or replace procedure sp_dcg_rellocto(
i_to_gateip varchar2,
i_to_port varchar2,
i_from_name varchar2,
i_psno varchar2
) is
--DCG网关启动事件
--v_curdate date;--电站所在时区当前时间
begin
  insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS',nvl(i_from_name,'DCG101'),2304,-1,-1,'psno='||nvl(i_psno,'ALLONLINE')||';'||i_to_gateip||i_to_port);
   /*for cut in(select psno,stationid from tb_pmu where curgate = i_dcgatename and state = 1) loop
      v_curdate:=fn_get_station_local_date(cut.stationid);--获得该电站的所在时区的当前时间
      for curtt in (select isno from tb_inverter where psno = cut.psno and state = 1) loop
         insert into tb_event_all(did,stationid,ssno,devt,occdt,val1,val2,l_tag,c_tag,insdt) 
               values(seq_invevent_id.nextval,cut.stationid,
            curtt.isno,2,v_curdate,1,0,0,0,sysdate);
      end loop;
   end loop;*/
end sp_dcg_rellocto;
/


create or replace procedure sp_web_put_reportevent(
i_Lan varchar2,
i_stationid number,
i_state number,
i_recieverlist varchar2,
i_rep_format number,
i_nextdelay number,
i_emptysend number,
i_maxeventlimit number,
i_itemstr varchar2

) is
v_state number;
v_emptysend number;
v_nextdelay number;
begin
  if i_state is null then
    v_state:=null;
  elsif i_state = 0 then
     v_state:=1;
  else
     v_state:=0;
  end if;
  if i_recieverlist is null then
    --对于接收列表为空的情况下,不允许设置为激活状态
     v_state:=0;
  end if;
  if i_emptysend is null then
     v_emptysend :=null;
  elsif i_emptysend = 0 then
    v_emptysend:=1;
  else
    v_emptysend:=0;
  end if;
  if i_nextdelay >0 then
     v_nextdelay:=i_nextdelay;
  else
    v_nextdelay:=1;
  end if;
  update tb_station_report_event set lan=nvl(i_lan,lan),
                                     state = nvl(v_state,state),
                                     RECIVERLIST=i_recieverlist,
                                     REP_FORMAT=nvl(i_rep_format,rep_format),
                                     nextdelay=v_nextdelay,
                                     emptysend=nvl(v_emptysend,emptysend),
                                     maxeventlimit=nvl(i_maxeventlimit,maxeventlimit),
                                     ITEMSTR=nvl(i_itemstr,itemstr)
           where stationid = i_stationid;
  commit;
end sp_web_put_reportevent;
/


create or replace procedure sp_web_put_reportdaily(
i_lan varchar2,
i_stationid number,
i_reportid number,
i_state number,
i_recieverlist varchar2,
i_rep_format number,
i_sendtime varchar2,
i_itemstr varchar2
) is
v_fennum number;
v_state number;
begin
  if i_sendtime is null then
     v_fennum:=null;
  else
  v_fenNum:=converttimetofens(i_sendTime);
  end if;
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
  update tb_station_report_daily set lan=nvl(i_lan,lan),
                                     state = nvl(v_state,state),
                                     RECIVERLIST=i_recieverlist,
                                     REP_FORMAT=nvl(i_rep_format,rep_format),
                                     SENDATTIME=nvl(v_fennum,sendattime),
                                     ITEMSTR=nvl(i_itemstr,itemstr)
           where stationid = i_stationid and reportid = i_reportid;
  commit;
end sp_web_put_reportdaily;
/


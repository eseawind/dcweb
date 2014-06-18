create or replace procedure sp_create_stationreportconfig(
i_stationid number--电站编号
) is
/*创建电站报告配置记录*/
begin
  insert into tb_station_report_daily(stationid,reportid,state,rep_format,sendattime,itemstr,lan) values(i_stationid,1,0,0/*0:html,1:text*/,21*60,'0,0,0,0,0,0,0','en_US');
  insert into tb_station_report_daily(stationid,reportid,state,rep_format,sendattime,itemstr,lan) values(i_stationid,2,0,0/*0:html,1:text*/,21*60,'0,0,0,0,0,0,0','en_US');
  insert into tb_station_report_daily(stationid,reportid,state,rep_format,sendattime,itemstr,lan) values(i_stationid,3,0,0/*0:html,1:text*/,21*60,'0,0,0,0,0,0,0','en_US');
  --
  insert into tb_station_report_monthly(stationid,reportid,state,rep_format,itemstr,lan) values(i_stationid,1,0,0/*0:html,1:text*/,'0,0,0,0,0,0,0','en_US');
  insert into tb_station_report_monthly(stationid,reportid,state,rep_format,itemstr,lan) values(i_stationid,2,0,0/*0:html,1:text*/,'0,0,0,0,0,0,0','en_US');
  insert into tb_station_report_monthly(stationid,reportid,state,rep_format,itemstr,lan) values(i_stationid,3,0,0/*0:html,1:text*/,'0,0,0,0,0,0,0','en_US');
  --
  insert into tb_station_report_event(stationid,state,rep_format,nextdelay,emptysend,maxeventlimit,itemstr,lan) values(i_stationid,0,0/*0:html,1:text*/,2,0,100,'0,0','en_US');
  commit;
end sp_create_stationreportconfig;
/


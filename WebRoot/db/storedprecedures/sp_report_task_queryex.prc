create or replace procedure sp_report_task_queryex(
o_tasknum out number,--任务数
cur_result out sys_refcursor--任务结果集
) is
--查询当前邮件发送任务
v_curid number;
begin
  select to_number(key_val) into v_curid from tb_sysparam where segment = 'MAIL_TASK' and key_name = 'TASKID';
  select count(1) into o_tasknum from tb_mail_task where taskid>v_curid ;
  if o_tasknum >0 then
    open cur_result for select a.stationid,a.reportid,a.configid,a.f_html,a.reciverlist,a.itemstr,a.lan,to_char(GetLocalCurrentDatetime(nvl(b.timezone,8)),'yyyy-mm-dd hh24:mi:ss') localtime from tb_mail_task a,tb_station  b where a.stationid = b.stationid(+) and taskid >v_curid;
    v_curid :=o_tasknum+v_curid;
    update tb_sysparam set key_val = to_char(v_curid) where  segment = 'MAIL_TASK' and key_name = 'TASKID';
    commit;
   end if;
end sp_report_task_queryex;
/


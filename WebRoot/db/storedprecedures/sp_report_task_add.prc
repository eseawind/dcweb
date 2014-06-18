create or replace procedure sp_report_task_add(
i_html number,
i_stationid number,
i_reportid number,
i_configid number,
i_lan varchar2,
i_reciverlist varchar2,
i_itemstr varchar2 default null
) is
--ÈÎÎñ·ÅÖÃ
v_itemstr varchar2(500);
begin
  if i_itemstr is null then
      if i_reportid = 1 then
         v_itemstr:='1,1,1,1,1,1,1';
      elsif i_reportid=2 then
         v_itemstr:='1,1,1,1,1,1,1';
      elsif i_reportid=3 then
         v_itemstr:='1,100,1,1,2012-06-27 00:00:00,2012-06-27 23:59:59,en_US';
      else
        v_itemstr:='0,0,0,0,0,0,0';
      end if;
  else
     v_itemstr:=i_itemstr;
  end if;
   insert into tb_mail_task( taskid,
                            adddt,
                            f_html,
                            stationid,
                            reportid,
                            configid,
                            reciverlist,
                            itemstr,lan)
                 values(    seq_mail_task_id.nextval,
                            sysdate,
                            i_html,
                            i_stationid,
                            i_reportid,
                            i_configid,
                            i_reciverlist,
                            v_itemstr,i_lan);
  commit;
end sp_report_task_add;
/


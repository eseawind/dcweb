create or replace procedure sp_report_task_test(
i_reportid number default 1
) is
--²âÊÔ½Ó¿Ú
begin
    sp_report_task_add(1,36,i_reportId,1,'zh_CN','7079321@qq.com;jime6688@163.com;');
end sp_report_task_test;
/


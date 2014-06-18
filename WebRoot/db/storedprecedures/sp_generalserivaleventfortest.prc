create or replace procedure sp_generalserivaleventfortest is
--为测试生成几条事件消息,由job自动调度
v_test date;
begin
  --sp_dcg_event(36,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),'B985000A127G0005',3,34,2);
  --sp_dcg_event(365,to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),'8882000A10902151',3,26,2);
   --v_test:=sysdate();
  v_test:=sysdate();
end sp_generalserivaleventfortest;
/


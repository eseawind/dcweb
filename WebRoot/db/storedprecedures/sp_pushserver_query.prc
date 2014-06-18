create or replace procedure sp_pushserver_query(
--Push 任务查询接口
o_count out number,--返回当前需要推送消息个数
cur_result  out sys_refcursor--个数大于0时，返回消息明细
) is
v_condition number;
begin
  o_count:=0;
  v_condition:=0;
  select key_val into v_condition from tb_sysparam where segment = 'push' and key_name ='test';
  if v_condition =0 then
     update tb_sysparam set key_val = 1 where segment = 'push' and key_name ='test';
     commit;
     open cur_result for select '7707256efe8e73f2b5627c60229feb60e68d05eeca4365e4f64e1453863ef1a8' tokekstr,'a test message' msgbody,'eventid=22620;' key_val from dual;--iPhone
     --select 'cb676509fc90e44c221d845673be352f978da42858fa539f5bc87e41cf30e760' tokekstr,'a test message' msgbody,'eventid=22620;' key_val from dual;--iPad
     --select '73fb3a25bb525c8b1ddab9fa166b7292709e84de8a18bf353f5762c354cc105e' tokekstr,'wanminglaingxxxx message' msgbody,'eventid=22620;' key_val  from dual;
     o_count:=1;
  else
     o_count:=0;

  end if;
 --
end sp_pushserver_query;
/


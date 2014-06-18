create or replace procedure mp_executeonceonzero authid current_user is
v_rownum number;
v_tablename varchar2(60);
v_curdate date;
v_sql varchar2(1000);
begin
  --维护日数据表
  v_curdate :=sysdate()-10;
  for i in 1..100 loop
    v_tablename:='TB_INV'||to_char(v_curdate,'yyyymmdd');
    select  count(1) into v_rownum from all_objects t where t.object_name = v_tablename and t.OWNER = 'DCWEB';
    if v_rownum = 0 then
        v_sql:='CREATE TABLE '||v_tablename||' as select * from tb_invdata10';
         execute immediate v_sql;
         v_sql:='ALTER TABLE '||v_tablename||' ADD ( PRIMARY KEY (idid),unique(isno,fen10) )';
         execute immediate v_sql;
         v_sql :='create index idx_'||v_tablename||' on '||v_tablename||' (isno)';
         execute immediate v_sql;
         commit;
    end if;
    v_curdate:=v_curdate+1;
  end loop;
  --维护长期离线PMU,逆变器状态表
 -- update tb_inverter  set state = 0 where sysdate - ludt > 2 and state = 1;
  --update tb_pmu  set state = 0 where sysdate - ludt > 2 and state = 1;
  --清除过期注册未激活用户帐号
  delete tb_user where mailactive = 0 and sysdate - createdt >90;
  commit;
end mp_executeonceonzero;
/


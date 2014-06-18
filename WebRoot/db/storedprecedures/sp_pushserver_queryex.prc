create or replace procedure sp_pushserver_queryex(
--Push 任务查询接口新接口
--第一次调用时，o_curid输入参数可以为空或者0，从接口中获取当前最大任务号
--后次调用时，应该根据上一次调用得到的最大值作为入参调用(该值由java自行读住）
--比较入参值和出参值的变化(>0时)，决定是否打开游标,从而确定是否PUSH
--说明:由于该存储过程调用频繁，若java记住这个值，可以为该操作节省一次查询操作,另外，tokekstr原来拼写有误，改为tokenstr,请同步纠正
i_curid in number,--输入当前的id号
o_curid out number,--当前查询ID号
cur_result  out sys_refcursor--个数大于0时，返回消息明细
) is
v_condition number;
begin
  if i_curid = 0 or i_curid is null then
     select max(tid) into v_condition from tb_pushtask;
  else
    v_condition:=i_curid;
  end if;
  select nvl(max(tid),0) into o_curid from tb_pushtask;
  if o_curid >v_condition then
    --open cur_result for select '7707256efe8e73f2b5627c60229feb60e68d05eeca4365e4f64e1453863ef1a8' tokenstr,'a test message' msgbody,'eventid=22620;' key_val from dual;--iPhone
    open cur_result for select tokenstr,title msgbody,key_val from tb_pushtask where tid>v_condition;--iPhone
  end if;
end sp_pushserver_queryex;
/


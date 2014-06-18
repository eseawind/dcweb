create or replace procedure sp_web_pmu_do(
i_action number,--操作ID，1：设置状态,0:取消状态,9:升级PMU程序
i_psnolist varchar2 --PMU 序列号列表,多个PMU序列号之间用逗号隔开
) is
v_psno varchar2(60);--分解序列号
v_itemnum number;
begin
   v_itemNum :=fn_getitemnum(i_psnolist,',');
   if i_action = 1 then
       for i in 1 .. v_itemnum loop
          v_psno:=upper(fn_getmidstr(i_psnolist,i,','));
          update tb_pmu set upa = 1 where psno=v_psno;
       end loop;
       commit;
   elsif i_action = 0 then
         for i in 1 .. v_itemnum loop
          v_psno:=upper(fn_getmidstr(i_psnolist,i,','));
          update tb_pmu set upa = 0 where psno=v_psno;
       end loop;
       commit;
   elsif i_action = 9 then
       --生成Action命令，交由DCGate执行
       for i in 1 .. v_itemnum loop
          v_psno:=upper(fn_getmidstr(i_psnolist,i,','));
       insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
        values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',9100,-1,-1,'psno='|| v_psno||';');
       end loop;
   end if;
   commit;
end sp_web_pmu_do;
/


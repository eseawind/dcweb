create or replace procedure sp_web_pmu_do(
i_action number,--����ID��1������״̬,0:ȡ��״̬,9:����PMU����
i_psnolist varchar2 --PMU ���к��б�,���PMU���к�֮���ö��Ÿ���
) is
v_psno varchar2(60);--�ֽ����к�
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
       --����Action�������DCGateִ��
       for i in 1 .. v_itemnum loop
          v_psno:=upper(fn_getmidstr(i_psnolist,i,','));
       insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context)
        values(SEQ_SYS_MSG_ID.Nextval,'ORADBS','ANYONE',9100,-1,-1,'psno='|| v_psno||';');
       end loop;
   end if;
   commit;
end sp_web_pmu_do;
/


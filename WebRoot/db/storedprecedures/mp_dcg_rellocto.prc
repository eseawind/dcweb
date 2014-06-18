create or replace procedure mp_dcg_rellocto(
i_to_gateip varchar2,--ת���DcgateIP��ַ
i_to_port varchar2,--ת���DCgate�����˿�
i_from_name varchar2 default null,--��ǰ�ṩ���߷����DCGate����,��DCG101,��ָ��Ĭ��ΪDCGATE101(������)
i_psno varchar2 default null,--����ָ����PSNO�豸���к�,Ĭ�ϲ�ָ��ʱ��Ϊ��DCGate�²�������PMU
i_mode number default 0--����ģʽ,0:��ʱָ��,1:����ָ��,Ĭ��Ϊ��ʱָ��
) is
/*
�����ܴ洢����,ΪDCGate��ʱָ���µķ�������IP���˿�
*/
begin
  if i_mode = 0 then
  insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS',nvl(i_from_name,'DCG101'),2304,-1,-1,'psno='||nvl(i_psno,'ALLONLINE')||';'||i_to_gateip||':'||i_to_port);
  commit;
  
  elsif i_mode = 1 then
  insert into tb_sys_msg (idd,msgfrom,msgto,action,val1,val2,context) values(SEQ_SYS_MSG_ID.Nextval,'ORADBS',nvl(i_from_name,'DCG101'),2394,-1,-1,'psno='||nvl(i_psno,'ALLONLINE')||';'||i_to_gateip||':'||i_to_port);
  commit;
  end if;
end mp_dcg_rellocto;
/


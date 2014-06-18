create or replace procedure mp_dcg_rellocto(
i_to_gateip varchar2,--转入的DcgateIP地址
i_to_port varchar2,--转入的DCgate侦听端口
i_from_name varchar2 default null,--当前提供在线服务的DCGate名称,如DCG101,不指定默认为DCGATE101(测试用)
i_psno varchar2 default null,--具体指定的PSNO设备序列号,默认不指定时则为该DCGate下部分在线PMU
i_mode number default 0--操作模式,0:临时指定,1:永久指定,默认为临时指定
) is
/*
管理功能存储过程,为DCGate临时指定新的服务程序的IP及端口
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


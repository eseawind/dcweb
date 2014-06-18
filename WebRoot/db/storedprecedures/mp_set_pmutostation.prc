create or replace procedure mp_set_pmutostation(
i_psno varchar2,
i_stationid number
) is
--����Ŀ��ʹ��(��PMU�������������ǿ��ָ����ĳһ��վ��
begin
  update tb_inverter set stationid = i_stationid where psno in (select isno from tb_inverter where psno = upper(i_psno));
  commit;
end mp_set_pmutostation;
/


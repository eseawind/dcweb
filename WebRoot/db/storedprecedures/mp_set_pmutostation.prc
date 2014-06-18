create or replace procedure mp_set_pmutostation(
i_psno varchar2,
i_stationid number
) is
--管理目的使用(将PMU及其下属逆变器强行指定给某一电站）
begin
  update tb_inverter set stationid = i_stationid where psno in (select isno from tb_inverter where psno = upper(i_psno));
  commit;
end mp_set_pmutostation;
/


create or replace procedure sp_dcg_pmu_online(i_psno varchar2) is
begin
  update tb_pmu set state = 1/*,lldt=sysdate*/ where psno = upper(i_psno);
  commit;
end sp_dcg_pmu_online;
/


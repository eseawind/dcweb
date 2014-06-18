create or replace procedure sp_dcg_pmu_offline(
--PMU离线执行的存储过程
 i_psno varchar2--PMU序列号
) is
v_rownum number;
begin
    select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
    if v_rownum >0 then
        update tb_inverter set state = 0 where psno = upper(i_psno);
        update tb_pmu set state = 0 where psno = upper(i_psno);
        commit;
    end if;
end sp_dcg_pmu_offline;
/


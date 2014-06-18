create or replace procedure sp_dcg_syncsensor(
i_ssno number,
i_sentype number,
i_factory varchar2,
i_brand varchar2,
i_softver varchar2,
i_hardwver varchar2,
i_model number
)is
begin
  commit;
end sp_dcg_syncsensor;
/


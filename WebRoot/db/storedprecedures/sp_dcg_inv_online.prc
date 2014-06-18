create or replace procedure sp_dcg_inv_online(
i_isno varchar2
) is
begin
  update tb_inverter set state =1 where isno = upper(i_isno);
  commit;
end sp_dcg_inv_online;
/


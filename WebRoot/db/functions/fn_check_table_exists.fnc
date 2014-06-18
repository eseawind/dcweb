create or replace function fn_check_table_exists(
i_tablename varchar2--£¿£¿?è~?£¿£¿?£¿
) return number is
--?£¿£¿£¿???£¿£¿???”w
v_rownum number;
begin
  select count(1) into v_rownum from tab where tname=upper(i_tablename);
  if v_rownum > 0 then
     return 1;
  else
     return 0;
  end if;
end fn_check_table_exists;
/


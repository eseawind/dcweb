create or replace procedure sp_create_currenttable is
i_curdate varchar2(50);
i_curtab varchar2(20);
cur_tab_name varchar2(50);
begin
  i_curdate:='tb_inv'||to_char(sysdate,'yyyymmdd');
  --i_curtab:='tb_inv';

  create table i_curdate as select * from tb_inv20131228 where 1=2;

end;
/


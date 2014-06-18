create or replace function fn_gettimebyfen10(i_fen10 number) return varchar2 is
--???£¿0?£¿£¿??????£¿??£¿???£¿
  v_date date;
begin
  v_date := to_date('2012-04-29 00:00:00','yyyy-mm-dd hh24:mi:ss');
  v_date :=v_date+(i_fen10/24/6);
  --
  return(to_char(v_date,'hh24:mi'));
end fn_gettimebyfen10;
/


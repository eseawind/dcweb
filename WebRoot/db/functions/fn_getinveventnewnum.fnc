create or replace function fn_getinveventnewnum(i_isno varchar2,i_stationid number) return number is
  v_r number;
begin
  --1:ĞÅÏ¢,2:¾¯¸æ,3:´íÎó
  select count(1) into v_r from tb_event_all where val1 =3 and c_tag = 0 and l_tag = 0 and ssno =upper(i_isno) and stationid = i_stationid;
  return(v_r);
end fn_getinveventnewnum;
/


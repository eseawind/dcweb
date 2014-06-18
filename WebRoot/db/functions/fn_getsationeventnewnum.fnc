create or replace function fn_getsationeventnewnum(i_stationid number) return number is
  Result number;
begin
  --1:ĞÅÏ¢,2:¾¯¸æ,3:´íÎó
  select count(1)into result from tb_event_all where stationid = i_stationid and val1 =3 /*and ssno in(select isno from tb_inverter where stationid = i_stationid )*/ and c_tag = 0 and l_tag = 0;
  return(Result);
end fn_getsationeventnewnum;
/


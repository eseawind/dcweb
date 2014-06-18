create or replace function fn_GetInverterListString(v_isno_list in varchar2) return varchar2 is
--TTT20120214X01C,TTT20120214X01C,TTT20120214X01C
--TTT20120214X01C
--return 'TTT20120214X01C','TTT20120214X01C','TTT20120214X01C'
  Result varchar2(1000);
begin
  Result:=v_isno_list;
  return(Result);
end fn_GetInverterListString;
/


create or replace function fn_encryptforpwd(
p_in varchar2--£¿£¿£¿£¿
) return varchar2
is
/*£¿£¿DES?£¿£¿???
*/
v_in varchar2(255);
v_rtn varchar2(1000);
begin
v_in := rpad(p_in,(trunc(length(p_in)/8)+1)*8,chr(0));
dbms_obfuscation_toolkit.desencrypt(input_string=>v_in,key_string=>'voicetvoicetvoicet',encrypted_string=>v_rtn);
v_rtn:=Utl_Raw.Cast_To_Raw(v_rtn);
return v_rtn;
end fn_encryptforpwd;
/


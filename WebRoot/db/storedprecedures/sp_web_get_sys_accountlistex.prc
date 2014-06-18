create or replace procedure sp_web_get_sys_accountlistex(
cur_result out sys_refcursor
) is
/*
rolestring=x1,x2,x3,x4
x1:pmut
x2:invt
x3:usert
x4:evet
*/
begin
  open cur_result for select account,firstname,secondname,to_number(fn_getmidstr(rolestring,1,',')) updatet,to_number(fn_getmidstr(rolestring,2,',')) plantt,to_number(fn_getmidstr(rolestring,3,',')) usert,to_number(fn_getmidstr(rolestring,4,','))  devt,state from tb_user where roleid =3;
end sp_web_get_sys_accountlistex;
/


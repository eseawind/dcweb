create or replace procedure mp_set_userpwd(i_userid number,i_password varchar2) is
--�����û�����
begin
    update tb_user set pwd = fn_encryptforpwd(i_password) where userid = i_userid;
    commit;
end mp_set_userpwd;
/


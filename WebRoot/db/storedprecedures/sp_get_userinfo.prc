create or replace procedure sp_get_userinfo(i_userid number,cur_result out sys_refcursor) is
--��ȡ�û���Ϣ
begin
  open cur_result for select firstname,secondname from tb_user where userid = i_userid;
end sp_get_userinfo;
/


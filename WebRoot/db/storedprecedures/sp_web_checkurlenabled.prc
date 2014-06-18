create or replace procedure sp_web_checkurlenabled(
i_userid number,--用户编号
i_roleid number,--角色编号,--1
i_rolestr varchar2,--角色字符串
o_result out  varchar2--结果
) is
begin
  o_result:='ok';
end sp_web_checkurlenabled;
/


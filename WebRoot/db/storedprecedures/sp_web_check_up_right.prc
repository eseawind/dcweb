create or replace procedure sp_web_check_up_right(
i_userid number,--用户编号
o_result out varchar2--检测结果
) is
v_rolestr varchar2(100);
v_roleid number;
begin
   o_result:='yes';
   select roleid,rolestring into v_roleid,v_rolestr from tb_user where userid = i_userid;
   if v_roleid =4 then
       o_result:='yes';
   elsif v_roleid = 3 then
      if fn_getmidstr(v_rolestr,1,',') = '1' then
          o_result:='yes';
      else
         o_result:='no';
      end if;
   else
      o_result:='no';
   end if;
   --o_result:='no'
end sp_web_check_up_right;
/


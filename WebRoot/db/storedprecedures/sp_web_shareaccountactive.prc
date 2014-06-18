create or replace procedure sp_web_shareaccountactive(
i_stationid number,--被共享的电站编号
i_userid number,--共享接收方的用户ID
i_verifycode varchar2,--激活校验码
o_result  out varchar2--输出结果
) is
--共享电站用户帐号激活,即将停止使用20120926
v_rownum number;
v_verifycode varchar2(60);
begin
  select count(1) into v_rownum from tb_userstation where stationid = i_stationid and userid = i_userid;
  if v_rownum >0 then
     select nvl(verifycode,'') into v_verifycode from tb_userstation where stationid = i_stationid and userid = i_userid;
     if length(v_verifycode)>3 and v_verifycode = i_verifycode then
        update tb_userstation set mailactive = 1,verifycode = null where stationid = i_stationid and userid = i_userid;
        commit;
     else
        o_result:='err_verifycode';
     end if;
  else
     o_result:='err_account';
  end if;
end sp_web_shareaccountactive;
/


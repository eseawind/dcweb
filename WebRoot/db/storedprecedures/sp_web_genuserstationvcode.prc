create or replace procedure sp_web_GenUserStationVCode(
i_UserID number,--电站共享接收者的用户编号
i_Stationid number,--共享的电站编号
o_Result out varchar2--生成验证码结果
) is
--用户共享电站时，验证码生成
v_rownun number;
v_verifycode varchar2(100);
begin
  select count(1) into v_rownun from tb_userstation where stationid = i_stationid and userid = i_userid;
  if v_rownun > 0 then
     v_verifycode:=fn_getrandstringwithabc(8);
     update tb_userstation set verifycode = v_verifycode,verifydt = sysdate where userid = i_userid and stationid = i_stationid;
     commit;
     o_result:=v_verifycode;
  else
      o_result:='error_notexists';
  end if;
end sp_web_GenUserStationVCode;
/


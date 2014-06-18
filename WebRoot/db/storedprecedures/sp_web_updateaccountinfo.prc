create or replace procedure sp_web_updateaccountinfo(
i_account varchar2,
i_firstname varchar2,--姓
i_secondname varchar2,--名
i_company varchar2,--公司名称
i_webaddr varchar2,--公司网址
i_country varchar2,--国家
i_province varchar2,--省、州
i_City varchar2,
i_street varchar2,--街道门牌
i_zip varchar2,--邮编
i_telnum varchar2,--电话号码xx-xxx-xxxxxx
i_mobile varchar2,--手机号码
o_result out varchar2
) is
/*================================================================
功能说明:更新用户帐号信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:User/Modify data
    引用文件:UserDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_account varchar2(100);
v_rownum number;
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum >0 then
      update tb_user set firstname=i_firstname,secondname=i_secondname,
      company=i_company,webaddr=i_webaddr,
      country=to_number(i_country),province=to_number(i_province),street=i_street,city=i_city,
      zip=i_zip,tel=i_telnum,mobile=i_mobile where account = v_account;
      commit;
      o_result:='ok';
  else
      o_result:='err_account';
  end if;
  o_result:='ok';
end sp_web_updateaccountinfo;
/


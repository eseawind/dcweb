create or replace procedure sp_create_account(
i_account in varchar2,--用户帐号，只能是邮箱
i_password in varchar2,--初始密码
i_question nvarchar2,--用户问题
i_answer nvarchar2,--用户回答
i_firstname nvarchar2,--姓
i_secondname nvarchar2,--名
i_company nvarchar2,--公司名称
i_webaddr varchar2,--公司网址
i_country varchar2,--国家
i_City nvarchar2,--城市
i_province varchar2,--省、州
i_street varchar2,--街道门牌
i_zip varchar2,--邮编
i_telnum varchar2,--电话号码xx-xxx-xxxxxx
i_mobile varchar2,--手机号码
o_userid out number,--输出用户ID号
o_verifycode out varchar2,--用户注册码
o_result out varchar2--结果
) is
/*================================================================
功能说明:创建用户帐号
------------------------------------------------------------------
相关WEB页面及文件
    用户注册页面
    UserDaoImpl.java
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
v_pwdmd5 varchar2(100);
begin
  v_account:=trim(lower(i_account));
  select count(1) into v_rownum from tb_user where account = v_account;
  if v_rownum =0 then--系统中不存在同名帐号，可以登册
     if fn_getitemnum(v_account,'@') >1 then--合法帐号
        v_pwdmd5:= fn_encryptforpwd(i_password);
        o_verifycode:=fn_getrandstringwithabc(8);
        insert into tb_user(
              userid,account,pwd,question1,ans1,firstname,secondname,company,webaddr,country,province,city,
              street,zip,tel,roleid,mobile,a_verifycode,mailactive,verifydt,createdt)
              values (seq_userid.nextval,v_account,v_pwdmd5,i_question,i_answer,i_firstname,i_secondname,i_company,i_webaddr,to_number(i_country),to_number(i_province),i_city,i_street,i_zip,i_telnum,12,i_mobile,o_verifycode,0,sysdate,sysdate);
        select seq_userid.currval into o_userid from dual;
        commit;
        o_result:='ok';
     else
        o_result:='err_format';
     end if;
  else
     o_result:='err_accountexists';
  end if;
end sp_create_account;
/


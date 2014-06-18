create or replace procedure sp_web_query_userlist_pageex(
i_account varchar2 default null,
i_firstname varchar2 default null,
i_secondname varchar2 default null,
i_phone varchar2 default null,
i_mobile varchar2 default null,
i_country varchar2 default null,
i_province varchar2 default null,
i_city varchar2 default null,
i_company varchar2 default null,
i_rowperpage number ,--每页行数
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
/*================================================================
功能说明:按各条件查询系统中注册用户信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:系统管理员功能之用户帐号管理
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_account varchar2(100);
v_rownum  number;
v_rowperpage number;
begin
  if i_account is null then
     v_account:=null;
  else
     v_account:=trim(lower(i_account));  end if;
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  select count(1) into v_rownum from tb_user
      where (i_country is null or country = to_number(i_country))
      and (i_province is null or province = to_number(i_province))
      and (i_city is null or city like '%'||i_city||'%')
      and (v_account is null or account like '%'||v_account||'%')
      and (i_firstname is null or firstname like '%'||i_firstname||'%')
      and (i_secondname is null or secondname like '%'||i_secondname||'%')
      and (i_phone is null or tel like '%'||i_phone||'%')
      and (i_mobile is null or mobile like '%'||i_mobile||'%')
      and (i_company is null or COMPANY like '%'||i_company||'%')
      and (i_company is null or COMPANY like '%'||i_company||'%')
      ;
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  if o_pages<=0  then o_pages:=1;end if;
  open cur_result for
      select a.userid,a.account,a.mailactive,a.createdt,a.firstname,a.secondname,nvl(b.context,'nodefine') country,nvl(c.province,'nodefine') province,a.city,a.tel,a.mobile,a.company from (select * from
            (
            select x.*,rownum rn from(select userid,account,mailactive,to_char(createdt,'yyyy-mm-dd') createdt,firstname,secondname,country,country*1000+province province,city,tel,mobile,COMPANY from tb_user
            where (i_country is null or country = to_number(i_country))
            and (i_province is null or province= to_number(i_province))
            and (i_city is null or city like '%'||i_city||'%')
            and (v_account is null or account like '%'||v_account||'%')
            and (i_firstname is null or firstname like '%'||i_firstname||'%')
            and (i_secondname is null or secondname like '%'||i_secondname||'%')
            and (i_phone is null or tel like '%'||i_phone||'%')
            and (i_mobile is null or mobile like '%'||i_mobile||'%')
            and (i_company is null or COMPANY like '%'||i_company||'%')
            and (i_company is null or COMPANY like '%'||i_company||'%') order by createdt desc)x
            ) where (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage))a,
            (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN'
            )b,
            (
            select context province,val1*1000+val2 provinceid from tb_dict_ssiis where subtag= 'webprovince' and language='zh_CN'
            )c  where a.country=b.country(+) and a.province = c.provinceid(+) order by a.createdt desc;
end sp_web_query_userlist_pageex;
/


create or replace procedure sp_web_querystationpage(
--即将作废20120828
i_country varchar2,
i_province varchar2,
i_stationname varchar2,
i_rowperpage number ,--每页行数
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
v_rownum  number;
v_rowperpage number;
begin
     if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
     else v_rowperpage:=3;
     end if;
     select count(1) into v_rownum from tb_station where (i_country is null or country = to_number(i_country)) and (i_province is null or province = to_number(i_province)) and (i_stationname is null or stationname like '%'||i_stationname||'%');
     o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
     if o_pages<=0  then
     o_pages:=1;
  end if;
  open cur_result for
       select a.stationid,a.stationname,b.context country,c.province,a.city,to_char(a.createdt,'yyyy-mm-dd') createdt,a.totalpower,to_char(a.ludt,'yyyy-mm-dd') ludt,d.account
       from
          (
            select * from (select x.*,rownum rn from(select stationid,stationname,country,country*1000+province province,city,createdt,totalpower,ludt,masterid
            from tb_station
            where (i_country is null or country = to_number(i_country))
                   and (i_province is null or province = to_number(i_province))
                   and (i_stationname is null or stationname like '%'||i_stationname||'%') order by createdt desc ) x)
           where(rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage))a,
          (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN'
          )b,
          (select context province,val1*1000+val2 provinceid from tb_dict_ssiis where subtag= 'webprovince' and language='zh_CN'
          )c,
          tb_user d where a.country=b.country(+) and a.province = c.provinceid(+) and a.masterid=d.userid(+);
end sp_web_querystationpage;
/


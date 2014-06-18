create or replace procedure sp_web_query_inv_page(
i_factoryname varchar2,
i_penpai varchar2,
i_type varchar2,
i_isno varchar2,
i_rowperpage number ,--每页行数
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
/*该函数将由ex函数替换*/
v_rownum  number;
v_rowperpage number;
begin
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  select count(1) into v_rownum from tb_inverter where
                          (i_factoryname is null or factoryname like '%'||i_factoryname||'%')
                      and (i_penpai is null or penpai like '%'||i_penpai||'%')
                      and (i_isno is null or isno like upper('%'||i_isno||'%'))
                      and (i_type is null or devtypename=i_type);
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  if o_pages<=0  then
     o_pages:=1;
  end if;
      open cur_result for
          select c.isno,c.factoryname,c.penpai,c.invtype,c.stationname,d.context country,c.city
          from (select a.isno,nvl(factoryname,'null') factoryname,nvl(a.penpai,'null') penpai,a.invtype,nvl(b.stationname,'null') stationname,nvl(b.country,86) country,nvl(b.city,'null') city
                from (select *
                      from (select isno,trim(factoryname) factoryname,trim(penpai) penpai,trim(devtypename) invtype,stationid,rownum rn
                            from tb_inverter
                            where (i_factoryname is null or factoryname like '%'||i_factoryname||'%')
                            and (i_penpai is null or penpai like '%'||i_penpai||'%')
                            and (i_isno is null or isno like upper('%'||i_isno||'%'))
                            and (i_type is null or devtypename=i_type))
                      where (rn between 1 and 100)) a,
                      tb_station b
                where a.stationid = b.stationid(+)) c,
               (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN') d
          where c.country = d.country;
end sp_web_query_inv_page;
--(i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage
/


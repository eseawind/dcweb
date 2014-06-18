create or replace procedure sp_web_inv_analy(
o_totalnum out number,
cur_type out sys_refcursor,
cur_country out sys_refcursor
)  is
v_totalnum number;
begin
  select count(1) into o_totalnum from tb_inverter where stationid >0;
  if o_totalnum =0 then
     v_totalnum:=1;
  else
     v_totalnum:=o_totalnum;
  end if;
  open cur_type for select nvl(trim(pt),'other') pt,pn,trim(to_char(round((pn*100/v_totalnum),1),'990.9')) pp from (select trim(devtypename) pt,count(1) pn from tb_inverter group by trim(devtypename)) order by pn desc;
  open cur_country for select b.context,a.pn,trim(to_char(round((pn*100/v_totalnum),1),'990.9')) pp  from
                           (select country,count(1) pn from (
                              select nvl(b.country,86) country from  tb_inverter a,tb_station b where a.stationid = b.stationid(+) and a.stationid >0
                           )  group by country) a,
                           (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language='zh_CN') b
                           where a.country=b.country order by pn desc;

end sp_web_inv_analy;
/


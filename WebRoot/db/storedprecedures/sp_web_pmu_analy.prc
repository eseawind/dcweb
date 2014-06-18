create or replace procedure sp_web_pmu_analy(
o_totalnum out number,
cur_type out sys_refcursor,
cur_country out sys_refcursor
)  is
v_totalnum number;
begin
  select count(1) into o_totalnum from tb_pmu where stationid >0;
  if o_totalnum =0 then
     v_totalnum:=1;
  else
     v_totalnum:=o_totalnum;
  end if;
  --open cur_type for select 'PMU PRO' pt,150 pn,15 pp from dual union select 'PMU' pt,800 pn,80 pp from dual union select '其他' pt,50 pn,5 pp from dual;
  --open cur_country for select '英国' pc,300 pn,30 pp from dual union select '澳大利亚' pc,100 pn,10 pp from dual union select '德国' pc,220 pn,22 pp from dual union select '意大利' pc,180 pn,18 pp from dual union select '美国' pc,120 pn,12 pp from dual union select '其他' pc,80 pn,8 pp from dual;

  open cur_type for select pt,pn,trim(to_char(round((pn*100/v_totalnum),1),'990.9')) pp from (select nvl(devname,'未定义') pt,count(1) pn from tb_pmu group by devname ) order by pn desc ;
  open cur_country for select b.context,a.pn,trim(to_char(round((pn*100/v_totalnum),1),'990.9')) pp  from
                           (select country,count(1) pn from (
                              select nvl(b.country,86) country from  tb_pmu a,tb_station b where a.stationid = b.stationid(+)
                           )  group by country) a,
                           (select context,val1 country from tb_dict_ssiis where subtag= 'webcountrylist' and language='zh_CN') b
                           where a.country=b.country order by pn desc;

end sp_web_pmu_analy;
/


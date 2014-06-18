create or replace procedure sp_web_query_pmu_pageex2(
i_type varchar2,--类型
i_subtype varchar2,--型号
i_psno varchar2,--序列号
i_hardver varchar2,--硬件版本号
i_softver varchar2,--软件版本号
i_upa number,-- -1:表示全部,1:自动升级,0:禁止自动升级
i_needup number,-- -1:表示全部,1:需要升级,0:不需要升级
i_state number,--0:只查不在线,1:只查在线
i_rowperpage number ,--每页行数
i_pos number default 1,--当前行数
o_pages out number,--返回总页数
cur_result out sys_refcursor
) is
/*================================================================
功能说明:根据多条件查询PMU信息列表
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:管理员之监控器查询
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum  number;
v_rowperpage number;
begin
  if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
  else v_rowperpage:=3;
  end if;
  --
  select count(1) into v_rownum from tb_pmu where
        (i_type is null or devname = i_type)  --pmutype
        and (i_psno is null or psno like '%'||upper(i_psno)||'%')
        and (i_state =100 or state = i_state)
        and (i_upa=-1 or upa = i_upa)
        and (i_needup = -1 or upn = i_needup)
        and (i_hardver is null or hardwver = i_hardver)
        and (i_softver is null or softver = i_softver)
        and (i_subtype is null or subtype=i_subtype);
  o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
  if o_pages<=0  then
     o_pages:=1;
  end if;
  --
  open cur_result for  select c.psno,c.idex,c.pmutype,c.stationname,c.state,d.context country,c.city,c.hardwver,c.softver,c.upa
          from (select a.psno,a.idex,a.pmutype,nvl(state,0) state,a.hardwver,a.upa,a.softver,nvl(b.stationname,'null') stationname,nvl(b.country,86) country,nvl(b.city,'null') city
                from (select *
                      from (select x.*,rownum rn from(select psno,idex,pmutype,stationid,hardwver,softver,upa,state,decode(nvl(stationid,0),0,1,0) ord1
                            from tb_pmu
                            where (i_type is null or devname = i_type)  --pmutype
                                and (i_psno is null or psno like upper('%'||i_psno||'%'))
                                and (i_state =100 or state = i_state)
                                and (i_upa=-1 or upa = i_upa)
                                and (i_needup = -1 or upn = i_needup)
                                and (i_hardver is null or hardwver = i_hardver)
                                and (i_softver is null or softver = i_softver)
                                and (i_subtype is null or subtype=i_subtype) order by state desc,ord1,psno) x)
                      where (rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage)) a,
                      tb_station b
                where a.stationid = b.stationid(+)) c,
               (select context,val1 country
                from tb_dict_ssiis
                where subtag= 'webcountrylist' and language='zh_CN') d
          where c.country = d.country;
end sp_web_query_pmu_pageex2;
/


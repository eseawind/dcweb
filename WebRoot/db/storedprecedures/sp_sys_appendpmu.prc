create or replace procedure sp_sys_appendpmu(
--导入或手工添加PMU信息
i_psno varchar2,--序列号
i_idex varchar2,--注册码
i_type varchar2 default 'PMU PRO',--类型
i_devname varchar2 default 'noname',--名称
i_xh varchar2 default null,--型号
i_factory varchar2 default null,--厂家制造商
i_penpai varchar2 default null,--品牌
i_softver varchar2 default null,--软件版本号
i_hardver varchar2 default null,--硬件版本号
o_result out varchar2
) is
/*================================================================
功能说明:系统添加PMU信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:系统管理员功能之监控器管理
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
v_rownum number;
begin
  select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
  if v_rownum =0 then
    insert into tb_pmu(psno,idex,devname,pmutype,softver,hardwver,subtype,factory,penpai,
             state,evetnum,eve0num,upa,upn)
    values(upper(i_psno),i_idex,i_devname,i_type,i_softver,i_hardver,i_xh,i_factory,i_penpai,0,0,0,0,0);
    o_result:='ok';
    commit;
  else
    o_result:='err_exists';
  end if;
end sp_sys_appendpmu;
/


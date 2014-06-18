create or replace procedure sp_dcg_pmu_sync(
--PMU同步信息
i_psno varchar2,
i_DevTyp number,
i_DevName varchar2,
i_DevTypeName varchar2,
i_FactoryName varchar2,
i_PenPai varchar2,
i_SoftVer varchar2 default 'unknow',
i_HardVer varchar2
)is
v_rownum number;
begin
  select count(1) into v_rownum from tb_pmu where psno = upper(i_psno);
  if (v_rownum >0) then
      update tb_pmu set DEVNAME=i_DevName,PENPAI=i_PenPai,subtype/*PMUTYPE*/=i_DevTypeName,devtype=i_DevTyp,FACTORY=i_FactoryName,HARDWVER=i_HardVer,SOFTVER=i_softver where psno = upper(i_psno);
  else
      insert into tb_pmu (psno,DEVNAME,penpai,/*PMUTYPE*/subtype,devtype,factory,hardwver,softver,upa,upn)
      values(upper(i_psno),i_DevName,i_PenPai,i_DevTypeName,i_DevTyp,i_FactoryName,i_HardVer,i_softver,0,0);
  end if;
end sp_dcg_pmu_sync;
/


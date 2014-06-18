create or replace procedure sp_dcg_inv_sync(
i_isno varchar2,
i_psno varchar2,
i_stationid number,
i_DevNum number,
i_DevTyp number,
i_DevName varchar2,
i_DevTypeName varchar2,
i_FactoryName varchar2,
i_PenPai varchar2,
i_SoftVer varchar2,
i_HardVer varchar2,
i_SafeType number,
i_FacLLCurHz number,--1����Ƶ�����޵�ֵ��ǰ�趨ֵ(Hz)
i_FacLLCurms number,--2����Ƶ�����޵�ֵʱ�䵱ǰ�趨ֵ(ms)
i_FacLHCurHz number,--3����Ƶ�����޸�ֵ��ǰ�趨ֵ(Hz)
i_FacLHCurms number,--4����Ƶ�����޸�ֵʱ�䵱ǰ�趨ֵ(ms)
i_FacLRCurs number,--5����Ƶ�����޻ָ�ʱ�䵱ǰ�趨ֵ(s)
i_FacULCurHz number,--6����Ƶ�����޵�ֵ��ǰ�趨ֵ(Hz)
i_FacULCurms number,--7����Ƶ�����޵�ֵʱ�䵱ǰ�趨ֵ(ms)
i_FacUHCurHz number,--8����Ƶ�����޸�ֵ��ǰ�趨ֵ(Hz)
i_FacUHCurms number,--9����Ƶ�����޸�ֵʱ�䵱ǰ�趨ֵ(ms)
i_FacURCurs number,--10����Ƶ�����޻ָ�ʱ�䵱ǰ�趨ֵ(s)
i_VpvStartCur number,--11VPV��ʼʱ��
i_TStartCur number,--12T��ʼʱ��
i_VacLLCurV number,--13������ѹ���޵�ֵ��ǰ�趨ֵ(V)
i_VacLLCurms number,--14������ѹ���޵�ֵʱ�䵱ǰ�趨ֵ(ms)
i_VacLHCurV number,--15������ѹ���޸�ֵ��ǰ�趨ֵ(V)
i_VacLHCurms number,--16������ѹ���޸�ֵʱ�䵱ǰ�趨ֵ(ms)
i_VacLRCurs number,--17������ѹ���޻ָ�ʱ�䵱ǰ�趨ֵ(S)
i_VacULCurV number,--18������ѹ���޵�ֵ��ǰ�趨ֵ(V)
i_VacULCurms number,--19������ѹ���޵�ֵʱ�䵱ǰ�趨ֵ(ms)
i_VaUHCurV number,--20������ѹ���޸�ֵ��ǰ�趨ֵ(V)
i_VacUHCurms number,--21������ѹ���޸�ֵʱ�䵱ǰ�趨ֵ(ms)
i_VacURCurs number,--22������ѹ���޻ָ�ʱ�䵱ǰ�趨ֵ(s)
i_ReconnectTime number,
i_ISO_Limit number,
i_DCI_Limit number,
i_GFCI_Limit number,
i_EnabledFun number,
i_MaxOutputPower number,
i_PvNum number,
i_T13 number
)is
--v_sql varchar2(2000);
v_rownum number;
begin
  select count(1) into v_rownum from tb_inverter where isno = upper(i_isno);
  if (v_rownum >0) then
     update tb_inverter set psno=upper(i_psno),stationid=i_stationid,
                            DevNum=i_DevNum,DevTyp=i_DevTyp,
                            DevName=i_DevName,DevTypeName=i_DevTypeName,FactoryName=i_FactoryName,
                            PenPai=i_PenPai,SoftVer=i_SoftVer,HardVer=i_HardVer,SafeType=i_SafeType,
                            FacLLCurHz=i_FacLLCurHz,FacLLCurms=i_FacLLCurms,FacLHCurHz=i_FacLHCurHz,
                            FacLHCurms=i_FacLHCurms,FacLRCurs=i_FacLRCurs,
                            FacULCurHz=i_FacULCurHz,FacULCurms=i_FacULCurms,
                            FacUHCurHz=i_FacUHCurHz,FacUHCurms=i_FacUHCurms,
                            FacURCurs=i_FacURCurs,VpvStartCur=i_VpvStartCur,
                            TStartCur=i_TStartCur,VacLLCurV=i_VacLLCurV,
                            VacLLCurms=i_VacLLCurms,VacLHCurV=i_VacLHCurV,
                            VacLHCurms=i_VacLHCurms,VacLRCurs=i_VacLRCurs,
                            VacULCurV=i_VacULCurV,VacULCurms=i_VacULCurms,
                            VaUHCurV=i_VaUHCurV,VacUHCurms=i_VacUHCurms,
                            VacURCurs=i_VacURCurs,ReconnectTime=i_ReconnectTime,
                            ISO_Limit=i_ISO_Limit,DCI_Limit=i_DCI_Limit,
                            GFCI_Limit=i_GFCI_Limit,EnabledFun=i_EnabledFun,
                            MaxOutputPower=i_MaxOutputPower,PvNum=i_PvNum,
                            T13=i_T13 where isno=upper(i_isno);
     commit;
  else
       insert into tb_inverter(createdt,
                  psno,stationid,state,DevNum,isno,DevTyp,DevName,DevTypeName,FactoryName,
                  PenPai,SoftVer,HardVer,SafeType,FacLLCurHz,FacLLCurms,
                  FacLHCurHz,FacLHCurms,FacLRCurs,FacULCurHz,FacULCurms,FacUHCurHz,
                  FacUHCurms,FacURCurs,VpvStartCur,TStartCur,VacLLCurV,VacLLCurms,
                  VacLHCurV,VacLHCurms,VacLRCurs,VacULCurV,VacULCurms,
                  VaUHCurV,VacUHCurms,VacURCurs,ReconnectTime,ISO_Limit,
                  DCI_Limit,GFCI_Limit,EnabledFun,MaxOutputPower,PvNum,T13)
           values(
                  sysdate,upper(i_psno),i_stationid,1,i_DevNum,upper(i_isno),i_DevTyp,i_DevName,i_DevTypeName,i_FactoryName,
                  i_PenPai,i_SoftVer,i_HardVer,i_SafeType,i_FacLLCurHz,i_FacLLCurms,
                  i_FacLHCurHz,i_FacLHCurms,i_FacLRCurs,i_FacULCurHz,i_FacULCurms,
                  i_FacUHCurHz,i_FacUHCurms,i_FacURCurs,i_VpvStartCur,i_TStartCur,
                  i_VacLLCurV,i_VacLLCurms,i_VacLHCurV,i_VacLHCurms,i_VacLRCurs,
                  i_VacULCurV,i_VacULCurms,i_VaUHCurV,i_VacUHCurms,i_VacURCurs,
                  i_ReconnectTime,i_ISO_Limit,i_DCI_Limit,i_GFCI_Limit,
                  i_EnabledFun,i_MaxOutputPower,i_PvNum,i_T13);
                    commit;
 end if;
end sp_dcg_inv_sync;
/


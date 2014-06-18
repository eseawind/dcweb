create or replace procedure sp_web_getdeviceInfoex(
i_ssno varchar2, --�豸���к�
cur_result out sys_refcursor
) is
/*================================================================
����˵��:�Զ������豸������ʾ�豸�����Ϣ(2013-4�޸ģ����e_total���������������
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Device management
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2013-04-03
�����:������
��ע:
==================================================================*/
v_rownum number;
v_e_total number;
begin
  select count(1) into v_rownum from tb_pmu where upper(psno) = upper(i_ssno);
  if v_rownum > 0 then
     select nvl(sum(e_total),0) into v_e_total from tb_inverter where upper(psno) =upper(i_ssno);
     open cur_result for
          select psno ssno,1 TypeName,decode(devname,'nvl',null,'null',null,devname) DeviceName,subtype XH,fn_get_val_kwh(v_e_total)||fn_get_unit_kwh(v_e_total) e_total,decode(Factory,'nvl',null,'null',null,Factory) Factory,decode(penpai,'nvl',null,'null',null,penpai) PP,decode(softver,'nvl',null,'null',null,softver) SoftVer,hardwver HardwareVer from tb_pmu  where upper(psno) = upper(i_ssno);
  else
    open cur_result for
         select isno ssno,2 TypeName,decode(devname,'nvl',null,'null',null,devname) DeviceName,devtypename XH,fn_get_val_kwh(nvl(e_total,0))||fn_get_unit_kwh(nvl(e_total,0)) e_total,decode(factoryname,'nvl',null,'null',null,factoryname) Factory,decode(penpai,'nvl',null,'null',null,penpai) PP,decode(softver,'nvl',null,'null',null,softver) SoftVer,decode(hardver,'nvl',null,'null',null,hardver) HardwareVer
 from tb_inverter where upper(isno) = upper(i_ssno);
  end if;
end sp_web_getdeviceInfoex;
/


create or replace procedure sp_web_getdeviceInfo(
i_ssno varchar2, --�豸���к�
cur_result out sys_refcursor
) is
/*================================================================
����˵��:�Զ������豸������ʾ�豸�����Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:Config/Device management
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
==================================================================*/
begin
open cur_result for select psno ssno,1 TypeName,devname DeviceName,subtype XH,Factory,penpai PP,softver SoftVer,hardwver HardwareVer from tb_pmu  where upper(psno) = upper(i_ssno) union
select isno ssno,2 TypeName,devname DeviceName,devtypename XH,factoryname Factory,penpai PP,softver SoftVer,hardver HardwareVer from tb_inverter where upper(isno) = upper(i_ssno);
end sp_web_getdeviceInfo;
/


create or replace procedure sp_web_setpmubyname(i_ssno varchar2,i_byname varchar2) is
/*================================================================
����˵��:�����豸����(����PMU,ISNO)
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
  update tb_pmu  set byname = i_byname where psno = i_ssno;
  update tb_inverter set byname = i_byname where isno = i_ssno;
  commit;
end sp_web_setpmubyname;
/


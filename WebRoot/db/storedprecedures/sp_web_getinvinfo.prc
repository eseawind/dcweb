create or replace procedure sp_web_getinvinfo(
i_isno varchar2,
cur_result out sys_refcursor) is
/*================================================================
����˵��:��ȡָ����������豸��Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:�������Ϣ�鿴����
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
   open cur_result for select to_char(createdt,'yyyy-mm-dd') createdt,--��������

                              devname,--�豸����
                              factoryname,--��������
                              penpai,--Ʒ������
                              softver,--����汾��
                              hardver,--Ӳ���汾��
                              fn_get_val_kwh(nvl(e_total,0)) e_total,--�ۼƷ�����
                              fn_get_unit_kwh(nvl(e_total,0)) e_total_u,
                              to_char(nvl(h_total,0))||'H' h_total,--�ۼƷ���ʱ��
                              devtypename,--,--�豸�������ƣ�
                              nvl(byname,isno) byname--�豸����
                               from tb_inverter where isno = upper(i_isno);
end sp_web_getinvinfo;
/


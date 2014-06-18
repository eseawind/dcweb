create or replace procedure sp_sys_appendpmu(
--������ֹ����PMU��Ϣ
i_psno varchar2,--���к�
i_idex varchar2,--ע����
i_type varchar2 default 'PMU PRO',--����
i_devname varchar2 default 'noname',--����
i_xh varchar2 default null,--�ͺ�
i_factory varchar2 default null,--����������
i_penpai varchar2 default null,--Ʒ��
i_softver varchar2 default null,--����汾��
i_hardver varchar2 default null,--Ӳ���汾��
o_result out varchar2
) is
/*================================================================
����˵��:ϵͳ���PMU��Ϣ
------------------------------------------------------------------
���WEBҳ�漰�ļ�
    �˵�·��:ϵͳ����Ա����֮���������
    �����ļ�:StationDaoImpl.java
------------------------------------------------------------------
��س���ģ��
    Web
------------------------------------------------------------------
�������:2012-11-09
�����:������
��ע:
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


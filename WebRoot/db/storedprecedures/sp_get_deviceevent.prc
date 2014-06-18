create or replace procedure sp_get_deviceevent(i_sno in varchar2,i_lan varchar2,cur_result out sys_refcursor) is
--���ָ���豸���¼��б�
--i_sno:�豸���к�
--���÷�Χ:wap,web,�ֻ��ͻ���
--�ú����Ƿ��Ѿ�����ʹ�ã�
begin
  open cur_result for select a.did,a.val1 msgtype,a.occdt,nvl(b.context,to_char(a.val2)) context
       from  (select did,val1,val2,occdt from tb_event_all where ssno=i_sno and l_tag = 0 order by did desc)a,
             (select val1,val2,context from tb_dict_ssiis where language=i_lan and subtag = 'pmuerrcode')b
       where (a.val2 =b.val2(+)) and a.val1=b.val1 order by  occdt desc;
  update tb_event_all set l_tag= 1 where ssno = i_sno and l_tag =0;
  commit;
end sp_get_deviceevent;
/


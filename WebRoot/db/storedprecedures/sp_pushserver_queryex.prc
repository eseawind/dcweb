create or replace procedure sp_pushserver_queryex(
--Push �����ѯ�ӿ��½ӿ�
--��һ�ε���ʱ��o_curid�����������Ϊ�ջ���0���ӽӿ��л�ȡ��ǰ��������
--��ε���ʱ��Ӧ�ø�����һ�ε��õõ������ֵ��Ϊ��ε���(��ֵ��java���ж�ס��
--�Ƚ����ֵ�ͳ���ֵ�ı仯(>0ʱ)�������Ƿ���α�,�Ӷ�ȷ���Ƿ�PUSH
--˵��:���ڸô洢���̵���Ƶ������java��ס���ֵ������Ϊ�ò�����ʡһ�β�ѯ����,���⣬tokekstrԭ��ƴд���󣬸�Ϊtokenstr,��ͬ������
i_curid in number,--���뵱ǰ��id��
o_curid out number,--��ǰ��ѯID��
cur_result  out sys_refcursor--��������0ʱ��������Ϣ��ϸ
) is
v_condition number;
begin
  if i_curid = 0 or i_curid is null then
     select max(tid) into v_condition from tb_pushtask;
  else
    v_condition:=i_curid;
  end if;
  select nvl(max(tid),0) into o_curid from tb_pushtask;
  if o_curid >v_condition then
    --open cur_result for select '7707256efe8e73f2b5627c60229feb60e68d05eeca4365e4f64e1453863ef1a8' tokenstr,'a test message' msgbody,'eventid=22620;' key_val from dual;--iPhone
    open cur_result for select tokenstr,title msgbody,key_val from tb_pushtask where tid>v_condition;--iPhone
  end if;
end sp_pushserver_queryex;
/


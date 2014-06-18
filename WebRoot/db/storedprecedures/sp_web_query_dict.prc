create or replace procedure sp_web_query_dict(
i_subtag varchar2,--�α��,Ϊ��ȫ��
i_lan varchar2,--����
i_Val1 number,--ֵ1��-1��ʾȫ��
i_val2 number,--ֵ2,-1��ʾȫ��
i_content varchar2,--�ı����ձ�ʾȫ��
cur_result out sys_refcursor) is
begin
   open cur_result for select subtag,language,val1,val2,context from tb_dict_ssiis
        where (i_subtag is null or subtag = i_subtag) and
             (i_lan is null or language = i_lan) and
              (i_val1 = -1 or val1 = i_val1) and
              (i_val2= -1 or val2 = i_val2) and
              (i_content is null or upper(i_content)=upper(context));
end sp_web_query_dict;
/


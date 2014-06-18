create or replace procedure sp_web_query_dict(
i_subtag varchar2,--段标记,为空全部
i_lan varchar2,--语言
i_Val1 number,--值1，-1表示全部
i_val2 number,--值2,-1表示全部
i_content varchar2,--文本，空表示全部
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


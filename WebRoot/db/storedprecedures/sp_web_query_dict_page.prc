create or replace procedure sp_web_query_dict_page(
i_subtag varchar2,--�α��,Ϊ��ȫ��
i_lan varchar2,--����
i_Val1 varchar2,--ֵ1��-1��ʾȫ��
i_val2 varchar2,--ֵ2,-1��ʾȫ��
i_content varchar2,--�ı����ձ�ʾȫ��
i_rowperpage number ,--ÿҳ����
i_pos number default 1,--��ǰ����
o_pages out number,--������ҳ��
cur_result out sys_refcursor) is
v_rownum  number;
v_rowperpage number;
v_val1 number;
v_val2 number;
begin
   if i_rowperpage >=3  then v_rowperpage:=i_rowperpage;
     else v_rowperpage:=3;
   end if;
   --
   v_val1:=to_number(i_val1);
   v_val2:=to_number(i_val2);
   select count(1) into v_rownum from tb_dict_ssiis where (i_subtag is null or subtag = i_subtag) and
             (i_lan is null or language = i_lan) and
              (v_val1 is null or val1 = v_val1) and
              (v_val2 is null or val2 = v_val2) and
              (i_content is null or upper(context) like '%'||upper(i_content)||'%');
   o_pages:=trunc((v_rownum +v_rowperpage -1)/v_rowperpage,0);
     if o_pages<=0  then
     o_pages:=1;
  end if;
  --
  open cur_result for select subtag,language,val1,val2,context from (select rownum rn,subtag,language,val1,val2,context from tb_dict_ssiis
        where (i_subtag is null or subtag = i_subtag) and
             (i_lan is null or language = i_lan) and
              (v_val1 is null or val1 = v_val1) and
              (v_val2 is null or val2 = v_val2) and
              (i_content is null or upper(context) like '%'||upper(i_content)||'%') order by subtag,language,val1,val2) where rn between (i_pos-1)*v_rowperpage +1 and i_pos*v_rowperpage;
end sp_web_query_dict_page;
/


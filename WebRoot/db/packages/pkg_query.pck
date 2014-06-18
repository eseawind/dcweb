create or replace package pkg_query
as type
cur_query is ref cursor;
procedure proc_qurey
(
p_tableName        in varchar2,   --真
        p_strWhere         in varchar2,   --真真
        p_orderColumn      in varchar2,   --真真
        p_orderStyle       in varchar2,   --真真
        p_curPage          in out Number, --?
        p_pageSize         in out Number, --真真真真
        p_totalRecords     out Number,     --真真
        p_totalPages       out Number,     --?
        v_cur              out pkg_query.cur_query);   --??
end pkg_query;

create or replace package body pkg_query
is
create or replace
procedure proc_qurey
(
        p_tableName        in varchar2,   --真
        p_strWhere         in varchar2,   --真真
        p_orderColumn      in varchar2,   --真真
        p_orderStyle       in varchar2,   --真真
        p_curPage          in out Number, --?
        p_pageSize         in out Number, --真真真真
        p_totalRecords     out Number,     --真真
        p_totalPages       out Number,     --?
        v_cur              out pkg_query.cur_query --??
)
is
   v_sql VARCHAR2(1000) := '';      --sql真
    v_startRecord Number(4);          --???
    v_endRecord Number(4);           --???
begin
      --真真真真
v_sql:='select to_number(count(*)) from' || p_tableName || 'where 1=1';
      if p_strWhere is not null or p_strWhere <> '' then
         v_sql:=v_sql || p_strWhere;
      end if;
    execute immediate v_sql into p_totalRecords;

    --真真真真
     if p_pageSize<0 then
        p_pageSize:=0;
     end if;

     --真真真真真
if mod(p_totalRecords,p_pageSize) =0 then
       p_totalPages := p_totalRecords /p_pageSize;
     else
       p_totalPages := p_totalRecords / p_pageSize + 1;
     end if;

    --真真
     if p_curPage<1 then
        p_curPage:=1;
     end if;

     if p_curPage > p_totalPages then
        p_curPage:=p_totalPages;
     end if;

    --??

     v_startRecord:=(p_curPage-1)* p_pageSize+1;
     v_endRecord :=p_curPage* p_pageSize;

     v_sql := 'select * from (select a.*, rownum r from ' || '(select * from ' || p_tableName;

     if p_strWhere is not null or p_strWhere <> '' then
       v_sql := v_sql || ' where 1=1' || p_strWhere;
     end if;

     if p_orderColumn IS NOT NULL or p_orderColumn <> '' then
       v_sql := v_sql || ' order by ' || p_orderColumn || ' ' || p_orderStyle;
     end if;

       v_sql := v_sql || ') a where rownum <= ' || v_endRecord || ') b where r >= ' || v_startRecord;

     DBMS_OUTPUT.put_line(v_sql);

     open v_cur for v_sql;
end proc_qurey;
end pkg_query;
/

create or replace package body pkg_query
is
create or replace
procedure sp_web_conf_proc_qurey
(
        p_tableName        in varchar2,   --真
        p_strWhere         in varchar2,   --真真
        p_orderColumn      in varchar2,   --真真
        p_orderStyle       in varchar2,   --真真
        p_curPage          in out Number, --?
        p_pageSize         in out Number, --真真真真
        p_totalRecords     out Number,     --真真
        p_totalPages       out Number,     --?
        v_cur              out pkg_query.cur_query --??
)
is
   v_sql VARCHAR2(1000) := '';      --sql真
    v_startRecord Number(4);          --???
    v_endRecord Number(4);           --???
begin
      --真真真真
v_sql:='select to_number(count(*)) from' || p_tableName || 'where 1=1';
      if p_strWhere is not null or p_strWhere <> '' then
         v_sql:=v_sql || p_strWhere;
      end if;
    execute immediate v_sql into p_totalRecords;

    --真真真真
     if p_pageSize<0 then
        p_pageSize:=0;
     end if;

     --真真真真真
if mod(p_totalRecords,p_pageSize) =0 then
       p_totalPages := p_totalRecords /p_pageSize;
     else
       p_totalPages := p_totalRecords / p_pageSize + 1;
     end if;

    --真真
     if p_curPage<1 then
        p_curPage:=1;
     end if;

     if p_curPage > p_totalPages then
        p_curPage:=p_totalPages;
     end if;

    --??

     v_startRecord:=(p_curPage-1)* p_pageSize+1;
     v_endRecord :=p_curPage* p_pageSize;

     v_sql := 'select * from (select a.*, rownum r from ' || '(select * from ' || p_tableName;

     if p_strWhere is not null or p_strWhere <> '' then
       v_sql := v_sql || ' where 1=1' || p_strWhere;
     end if;

     if p_orderColumn IS NOT NULL or p_orderColumn <> '' then
       v_sql := v_sql || ' order by ' || p_orderColumn || ' ' || p_orderStyle;
     end if;

       v_sql := v_sql || ') a where rownum <= ' || v_endRecord || ') b where r >= ' || v_startRecord;

     DBMS_OUTPUT.put_line(v_sql);

     open v_cur for v_sql;
end sp_web_conf_proc_qurey;
end pkg_query;
/


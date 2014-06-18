create or replace function fn_dms_real(
i_dms_val varchar2
) return number is
/*?£¿£¿£¿£¿£¿
£¿£¿??£¿:[E/W/S/N]:degress-minutes-seconds
*/
v_prechar varchar2(10);
v_degress number;
v_seconds number;
v_minutes number;
v_rest varchar2(64);
begin
  --insert into tb_sys_log(idd,occdt,str1,val1,val2,context) values (seq_idd_log.nextval,sysdate,null,null,1,i_dms_val);
  --commit;
  v_prechar:=fn_getmidstr(i_dms_val,1,':');
  v_rest:=fn_getmidstr(i_dms_val,2,':');
  v_degress:=to_number(fn_getmidstr(v_rest,1,'-'));
  v_minutes:=to_number(fn_getmidstr(v_rest,2,'-'));
  v_seconds:=to_number(fn_getmidstr(v_rest,3,'-'));
  if upper(v_prechar) = 'E'  or upper(v_prechar) = 'N' then
     return v_degress+v_minutes/60+v_seconds/3600;
  else
    return -(v_degress+v_minutes/60+v_seconds/3600);
  end if;

return 0;
end fn_dms_real;
/


create or replace function fn_getitemnum(v_str varchar2,v_split varchar2) return integer is
--???£¿????£¿????£¿­Æ£¿£¿,£¿£¿£¿£¿?£¿???£¿???£¿£¿????£¿
  pos int;
  len int;
  itemnum int;
begin
  itemnum:=0;
  pos:=0;
  len:=length(v_str);
  if len>0 then
    loop
       pos:=instr(v_str,v_split,pos+1,1);
       if pos=0 then return itemnum +1;
       else
          itemNum:=itemnum+1;
          if pos =len then
             return itemnum;
          end if;
       end if;
    end loop;
  end if;
  return 0;
end fn_getitemnum;
/


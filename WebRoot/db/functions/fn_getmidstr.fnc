create or replace function fn_GetMidStr(v_str varchar2,v_pos int,v_split varchar2) return varchar2 is
--???£¿????£¿????????£¿???¦Ë£¿?£¿£¿???£¿??£¿£¿£¿£¿?£¿???£¿???£¿£¿??????£¿???£¿???§º£¿£¿£¿
  len int;
  lpos int;
  rpos int;
begin
  lpos:=0;
  rpos:=0;
  len:=length(v_str);
  if len>0 then
     for i in 1 .. v_pos loop
         lpos:=rpos;
         rpos:=instr(v_str,v_split,lpos+1,1);
         if rpos =0 then
            if i= v_pos then
               --£¿??£¿?£¿£¿????£¿????£¿£¿
              return substr(v_str,lpos+1,len-lpos);
             else
                return NULL;
             end if;
         end if;
     end loop;
     return substr(v_str,lpos+1,rpos -lpos-1);
    -- return substr(v_str,lpos+1,len-pos);
  else
     return null;
  end if;

end fn_GetMidStr;
/


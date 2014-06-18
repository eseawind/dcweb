create or replace procedure sp_dcg_getinvinfo(
i_isno varchar2,
i_psno varchar2,
i_stationid number,
o_e_total out number
) is
--获得逆变器信息
v_rownum number;
v_stationid number;
v_psno varchar2(64);
begin
  select count(1) into v_rownum from tb_inverter where isno = upper(i_isno);
       if (v_rownum >0) then
           select e_total,psno,stationid into o_e_total,v_psno,v_stationid from tb_inverter where isno = upper(i_isno);
           if v_psno is null or v_stationid is null  or v_psno<>i_psno then
               update tb_inverter set psno = upper(i_psno),stationid = i_stationid where isno = upper(i_isno);
               commit;
           end if;
       else
           insert into tb_inverter
                     (  isno,psno,stationid,createdt,state,pac,eve0num,evetnum,e_total)
               values ( upper(i_isno),upper(i_psno),i_stationid,sysdate,0,0,0,0,0);
           commit;
       end if;
end sp_dcg_getinvinfo;
/


create or replace procedure sp_dcg_dataupnewx(
i_psno varchar2,--PMU序列号
i_isno varchar2,--设备序列号
i_usedspace number,--设备已经使用空间
i_stationid number,--电站编号
i_timezone number,--电站所在时区
i_recvdt varchar2,--接收的日期时间
i_fen10 number,--10分钟数值
i_vpv1 number,
i_vpv2 number,
i_vpv3 number,
i_vpv4 number,
i_vpv5 number,
i_vpv6 number,
i_vpv7 number,
i_vpv8 number,
i_vpv9 number,
i_vpv10 number,
i_vpv11 number,
i_vpv12 number,
i_vpv13 number,
i_vpv14 number,
i_vpv15 number,
i_vpv16 number,
i_vpv17 number,
i_vpv18 number,
i_vpv19 number,
i_vpv20 number,
i_ipv1 number,
i_ipv2 number,
i_ipv3 number,
i_ipv4 number,
i_ipv5 number,
i_ipv6 number,
i_ipv7 number,
i_ipv8 number,
i_ipv9 number,
i_ipv10 number,
i_ipv11 number,
i_ipv12 number,
i_ipv13 number,
i_ipv14 number,
i_ipv15 number,
i_ipv16 number,
i_ipv17 number,
i_ipv18 number,
i_ipv19 number,
i_ipv20 number,
i_ppv1 number,
i_ppv2 number,
i_ppv3 number,
i_ppv4 number,
i_ppv5 number,
i_ppv6 number,
i_ppv7 number,
i_ppv8 number,
i_ppv9 number,
i_ppv10 number,
i_ppv11 number,
i_ppv12 number,
i_ppv13 number,
i_ppv14 number,
i_ppv15 number,
i_ppv16 number,
i_ppv17 number,
i_ppv18 number,
i_ppv19 number,
i_ppv20 number,
i_vac1 number,
i_vac2 number,
i_vac3 number,
i_iac1 number,
i_iac2 number,
i_iac3 number,
i_status number,
i_cos_phi number,
i_under_excited number,
i_pac number,
i_pacMax number,
i_sac number,
i_qac number,
i_fac number,
i_e_total number,
i_h_total number,
i_e_today number,
i_tempval number--,
) is
v_querydate date;
v_sql varchar2(2000);
--v_fen10 number;
begin
    v_querydate:=to_date(i_recvdt,'yyyy-mm-dd hh24:mi:ss');
    --v_fen10:=fn_getfen10bydate(v_querydate);
    v_sql:='
        insert into tb_inv'||to_char(v_querydate,'yyyymmdd') ||'
               ( idid,
                 psno,isno,stationid,timezone,recvdate,fen10,
                 vpv1,vpv2,vpv3,vpv4,vpv5,vpv6,vpv7,vpv8,vpv9,vpv10,
                 vpv11,vpv12,vpv13,vpv14,vpv15,vpv16,vpv17,vpv18,vpv19,vpv20,
                 ipv1,ipv2,ipv3,ipv4,ipv5,ipv6,ipv7,ipv8,ipv9,ipv10,
                 ipv11,ipv12,ipv13,ipv14,ipv15,ipv16,ipv17,ipv18,ipv19,ipv20,
                 ppv1,ppv2,ppv3,ppv4,ppv5,ppv6,ppv7,ppv8,ppv9,ppv10,
                 ppv11,ppv12,ppv13,ppv14,ppv15,ppv16,ppv17,ppv18,ppv19,ppv20,
                 vac1,vac2,vac3,iac1,iac2,iac3,
                 status,cos_phi,under_excited,pac,sac,qac,fac,
                 e_total,h_total,e_today,tempval)
        values ( seq_inv_data10_id.nextval,
                 :psno_,:isno_,:stationid_,:timezone_,:recvdate_,:fen10_,:
                 vpv1_,:vpv2_,:vpv3_,:vpv4_,:vpv5_,:vpv6_,:vpv7_,:vpv8_,:vpv9_,:vpv10_,
                 :vpv11_,:vpv12_,:vpv13_,:vpv14_,:vpv15_,:vpv16_,:vpv17_,:vpv18_,:vpv19_,:vpv20_,
                 :ipv1_,:ipv2_,:ipv3_,:ipv4_,:ipv5_,:ipv6_,:ipv7_,:ipv8_,:ipv9_,:ipv10_,
                 :ipv11_,:ipv12_,:ipv13_,:ipv14_,:ipv15_,:ipv16_,:ipv17_,:ipv18_,:ipv19_,:ipv20_,
                 :ppv1_,:ppv2_,:ppv3_,:ppv4_,:ppv5_,:ppv6_,:ppv7_,:ppv8_,:ppv9_,:ppv10_,
                 :ppv11_,:ppv12_,:ppv13_,:ppv14_,:ppv15_,:ppv16_,:ppv17_,:ppv18_,:ppv19_,:ppv20_,
                 :vac1_,:vac2_,:vac3_,:iac1_,:iac2_,:iac3_,
                 :status_,:cos_phi_,:under_excited_,:pac_,:sac_,:qac_,:fac_,
                 :e_total_,:h_total_,:e_today_,:tempval_)
                ';
   execute immediate v_sql using
                 upper(i_psno),upper(i_isno),i_stationid,i_timezone,/*trunc(*/v_querydate/*)*/,i_fen10,
                 i_vpv1,i_vpv2,i_vpv3,i_vpv4,i_vpv5,i_vpv6,i_vpv7,i_vpv8,i_vpv9,i_vpv10,
                 i_vpv11,i_vpv12,i_vpv13,i_vpv14,i_vpv15,i_vpv16,i_vpv17,i_vpv18,i_vpv19,i_vpv20,
                 i_ipv1,i_ipv2,i_ipv3,i_ipv4,i_ipv5,i_ipv6,i_ipv7,i_ipv8,i_ipv9,i_ipv10,
                 i_ipv11,i_ipv12,i_ipv13,i_ipv14,i_ipv15,i_ipv16,i_ipv17,i_ipv18,i_ipv19,i_ipv20,
                 i_ppv1,i_ppv2,i_ppv3,i_ppv4,i_ppv5,i_ppv6,i_ppv7,i_ppv8,i_ppv9,i_ppv10,
                 i_ppv11,i_ppv12,i_ppv13,i_ppv14,i_ppv15,i_ppv16,i_ppv17,i_ppv18,i_ppv19,i_ppv20,
                 i_vac1,i_vac2,i_vac3,i_iac1,i_iac2,i_iac3,
                 i_status,i_cos_phi,i_under_excited,i_pac,i_sac,i_qac,i_fac,
                 i_e_total,i_h_total,i_e_today,i_tempval;
    update tb_inverter set pac=i_pac,e_total=i_e_total,h_total=i_h_total,pacmax=i_pacmax/*,state=1*/,ludt = v_querydate  where isno = upper(i_isno);
    update tb_station set ludt = v_querydate where stationid= i_stationid;
    update tb_pmu set usedspace=i_usedspace,ludt = v_querydate where psno = upper(i_psno);
   commit;
end sp_dcg_dataupnewx;
/


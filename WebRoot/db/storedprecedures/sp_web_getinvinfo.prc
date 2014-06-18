create or replace procedure sp_web_getinvinfo(
i_isno varchar2,
cur_result out sys_refcursor) is
/*================================================================
功能说明:获取指定逆变器的设备信息
------------------------------------------------------------------
相关WEB页面及文件
    菜单路径:逆变器信息查看功能
    引用文件:StationDaoImpl.java
------------------------------------------------------------------
相关程序模块
    Web
------------------------------------------------------------------
审核日期:2012-11-09
审核人:嵇长军
备注:
==================================================================*/
begin
   open cur_result for select to_char(createdt,'yyyy-mm-dd') createdt,--创建日期

                              devname,--设备名称
                              factoryname,--厂家名称
                              penpai,--品牌名称
                              softver,--软件版本号
                              hardver,--硬件版本号
                              fn_get_val_kwh(nvl(e_total,0)) e_total,--累计发电量
                              fn_get_unit_kwh(nvl(e_total,0)) e_total_u,
                              to_char(nvl(h_total,0))||'H' h_total,--累计发电时长
                              devtypename,--,--设备类型名称，
                              nvl(byname,isno) byname--设备别名
                               from tb_inverter where isno = upper(i_isno);
end sp_web_getinvinfo;
/


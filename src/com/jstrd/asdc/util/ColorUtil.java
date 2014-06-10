package com.jstrd.asdc.util;

import java.util.Random;

public class ColorUtil {

	public static String color[]= new String[]{"#5F0F41","#68927B","#351832","#645F45","#2888CF","#0A95C8",
		"#BE8A34","#EDC253","#F5B7F6","#51B674","#1C3DCE","#52E6BB","#3D5D25","#75D866","#A9EDE5","#7EF578",
		"#36B5F8","#1CCA64","#D63B70","#014178","#289D82","#3FE61F","#3B58D8","#24BFD1","#51BC40","#4C8F25",
		"#2FDE0E","#C02993","#92B550","#6AF135","#EBCBBB","#B1F20A","#3539A4","#89E092","#181EE1","#CF4835",
		"#A7443B","#E47674","#DD374E","#2401A9","#3BB6CE","#2B4ED0","#59FDC2","#545174","#7264FD","#95DDA9",
		"#792AEF","#A2FD4A","#A2D4E8","#A7C7A0","#21A7E9","#E876F7","#1510D5","#E62E71","#6A1D32","#635BF7",
		"#57C496","#5B5054","#94CB95","#BDB19D"};
	
	public static void main(String[] args){
		String s="";
		for(int i=0;i<60;i++){
			s = s+"\""+ getRandColorCode()+"\",";
		}
		System.out.println(s);
	}
	
	/**  
     * 获取十六进制的颜色代码.例如  "#6E36B4" , For HTML ,  
     * @return String  
     */  
	public static String getRandColorCode(){   
	  String r,g,b;   
	  Random random = new Random();   
	  r = Integer.toHexString(random.nextInt(256)).toUpperCase();   
	  g = Integer.toHexString(random.nextInt(256)).toUpperCase();   
	  b = Integer.toHexString(random.nextInt(256)).toUpperCase();   
	     
	  r = r.length()==1 ? "0" + r : r ;   
	  g = g.length()==1 ? "0" + g : g ;   
	  b = b.length()==1 ? "0" + b : b ;   
	     
	  return "#"+r+g+b;   
	 }  

}

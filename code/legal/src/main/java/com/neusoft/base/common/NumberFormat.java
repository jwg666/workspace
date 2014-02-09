package com.neusoft.base.common;

import java.text.DecimalFormat;

public class NumberFormat {
	private static  DecimalFormat twoDecimal=new DecimalFormat("0.00");
	private static  DecimalFormat fourDecimal=new DecimalFormat("0.0000");
	private static  DecimalFormat numberFormat=new DecimalFormat("0000000");
	private static  DecimalFormat rateFormat = new DecimalFormat("##%");    
	//private static  DecimalFormat orderCodeFormat = new DecimalFormat("00000000");    
	public static String formmatNumber(Integer id){
	    if(!ValidateUtil.isValid(id)){
	    	return "";
	    }
		return numberFormat.format(id);
	}
	public static String formmatTwoDecimal(Number f){
		if(f==null){
			return "";
		}
		return twoDecimal.format(f);
	}
	public static String formmatRate(Number f){
		if(f==null){
			return "";
		}
		return rateFormat.format(f);
	}
	public static String formatFourDecimal(Number f){
		if(f==null){
			return "";
		}
		return fourDecimal.format(f);
	}
	public static String formatOrderCode(Number orderCode){
		return String.format("%010d", orderCode);
	}
	public static void main(String[] args) {
//		System.out.println(formatOrderCode(1234678L));
	}
}
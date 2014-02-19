/******************************************************************************
 * @File name   :      DataFormat.java
 *
 * @Author      :      licheng
 *
 * @Date        :      2012-1-16
 *
 * @Copyright Notice: 
 * Copyright (c) 2012 Haier, Inc. All  Rights Reserved.
 * This software is published under the terms of the Haier Software
 * License version 1.0, a copy of which has been included with this
 * distribution in the LICENSE.txt file.
 * 
 * 
 * ----------------------------------------------------------------------------
 * Date                   Who         Version        Comments
 * 2012-1-16 下午4:15:29        licheng     1.0            Initial Version
 *****************************************************************************/
package com.neusoft.base.common;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 */
public class DataFormat {
	
	/**
	 * Double类型的显示精度
	 */
	public static final int DOUBLE_SCALE = 2;
	/**已定义的日期格式常量*/
	public static final int	DT_YYYYMMDD			= 1 ;//2012-05-08
	public static final int	DT_YYYYMMDD_HHMMSS	= 2 ;
	public static final int	DT_HHMMSS			= 3 ;
	public static final int	DT_HHMM				= 4 ;
	public static final int DT_YYYY             = 5 ;
	public static final int DT_MMDDYYYYHHMMSS   = 6 ;
    public static final int DT_YYYYMMDD_EEEE    = 7 ; //ex:2007-06-15 星期五
    public static final int DT_YYMMDD    = 8 ; //ex:070602
    public static final int DT_YYYYMM=9;
    public static final int DT_YYYYMMDD2=10;
	public static final int DT_HHMMSS1=11;

	/**
	 * 格式化数字，例如：12345转化为12345
	 * @param dValue 被格式化的数值 
	 * @param iScale 小数点后保留位数,不足补0
	 * @return
	 */
	public static String formatNumberToString(double dValue ,int iScale)
	{
		if(Double.isNaN(dValue))
		{
			return "";
		}
		
		DecimalFormat df = null ;
		StringBuffer sPattern = new StringBuffer("##0");
		if (iScale > 0)
		{
			sPattern.append ( "." ) ;
			for (int i = 0; i < iScale; i++)
			{
				sPattern.append("0");
			}
		}
		df = new DecimalFormat(sPattern.toString( )) ;
		return df.format(dValue) ;
	}
	/**
	 * 格式化数字，例如：12345转化为12,345
	 * @param dValue 被格式化的数值 
	 * @param iScale 小数点后保留位数,不足补0
	 * @return
	 */
	public static String formatNumber(double dValue ,int iScale)
	{
		if(Double.isNaN(dValue))
		{
			return "";
		}
		
		DecimalFormat df = null ;
		StringBuffer sPattern = new StringBuffer(",##0");
		if (iScale > 0)
		{
			sPattern.append ( "." ) ;
			for (int i = 0; i < iScale; i++)
			{
				sPattern.append("0");
			}
		}
		df = new DecimalFormat(sPattern.toString( )) ;
		return df.format(dValue) ;
	}
	
	/**
	 * 该方法不能对数据库中的id值做转换，当id>1000时会出现以下问题
	 * id=12000时，该方法返回12,000 
	 */
	public static String formatNumber(long lValue)
	{
		return formatNumber((double)lValue ,0);
	}
	
	/**
	 * 解析格式化的字符串，转化为数值，例如：12,345.00转化为12345
	 * @param text 被格式化的数值
	 * @return
	 */
	public static double parseDouble(String text)
	{
		String newText = text;
		int index = newText.indexOf(',');
//		String sbNumber = "" ;
		StringBuffer sbNumber = new StringBuffer();
		while (index != -1)
		{
//			sbNumber += newText.substring(0 ,index);
			sbNumber.append(newText.substring(0, index));
			newText = newText.substring (index + 1 ,newText.length());
			index = newText.indexOf(',');
		}
//		sbNumber += newText ;
		sbNumber.append(newText);
		return Double.parseDouble(sbNumber.toString());
	}
	public static long parseLong(String text)
	{
		String newText = text;
		int index = newText.indexOf(',');
//		String sbNumber = "";
		StringBuffer sbNumber = new StringBuffer();
		while (index != -1)
		{
//			sbNumber += newText.substring(0 , index);
			sbNumber.append(newText.substring(0, index));
			newText = newText.substring(index + 1 , newText.length());
			index = newText.indexOf(',');
		}
//		sbNumber += newText;
		sbNumber.append(newText);
		return Long.parseLong(sbNumber.toString());
	}
	
	
	/**
	 * 按指定的模板获得对应的时间串
	 * @param date
	 * @param nFmt
	 * @return
	 */
	public static String formatDate(Date date, int nFmt)
	{
		if(date == null)
		{
			return "";
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat() ;
		switch (nFmt)
		{
			case DataFormat.DT_YYYYMMDD :
				dateFormat.applyPattern("yyyy-MM-dd");
				break ;
			case DataFormat.DT_YYYYMMDD_HHMMSS :
				dateFormat.applyPattern("yyyy-MM-dd HH:mm:ss");
				break ;
			case DataFormat.DT_HHMMSS :
				dateFormat.applyPattern("HH:mm:ss");
				break ;
			case DataFormat.DT_HHMM :
				dateFormat.applyPattern("HH:mm");
				break ;
			case DataFormat.DT_YYYY :
				dateFormat.applyPattern("yyyy");
				break ;
			case DataFormat.DT_MMDDYYYYHHMMSS:
				dateFormat.applyPattern("MMddyyyy:HH:mm:ss");
				break ;
            case DataFormat.DT_YYYYMMDD_EEEE:
                dateFormat.applyPattern("yyyy-MM-dd EEEE");
                break;
            case DataFormat.DT_YYMMDD:
                dateFormat.applyPattern("yyMMdd");
                break;
            case DataFormat.DT_YYYYMM:
                dateFormat.applyPattern("yyyyMM");
                break;
            case DataFormat.DT_YYYYMMDD2:
                dateFormat.applyPattern("yyyyMMdd");
                break;
            case DataFormat.DT_HHMMSS1 :
				dateFormat.applyPattern("HHmmss");
				break ;
            default :
		}
		return dateFormat.format(date);
	}
	public static String formatDate(Date date)
	{
		return formatDate(date, DT_YYYYMMDD);
	}
	public static String formatDate(Date date, String strFmt)
	{
		if(date == null)
		{
			return "";
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat(strFmt);
		return dateFormat.format(date);
	}
	/**
	 * 按指定的模板转换为相应的时间
	 * @param strDate
	 * @param nFmt
	 * @return
	 * @throws Exception
	 */
	public static Date parseDate(String strDate, int nFmt) throws Exception
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat();
		switch (nFmt)
		{
			case DataFormat.DT_YYYYMMDD :
				dateFormat.applyPattern("yyyy-MM-dd");
				break;
			case DataFormat.DT_YYYYMMDD_HHMMSS :
				dateFormat.applyPattern("yyyy-MM-dd HH:mm:ss");
				break;
			case DataFormat.DT_HHMMSS :
				dateFormat.applyPattern("HH:mm:ss");
				break;
			case DataFormat.DT_HHMM :
				dateFormat.applyPattern("HH:mm");
				break;
			default :
		}
		return dateFormat.parse(strDate);
	}
	public static Date parseDate(String strDate, String strFmt) throws Exception
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat(strFmt);
		return dateFormat.parse(strDate);
	}

	/**
	 * 按指定的分隔符分隔字符串<br>
	 * 完成类似JDK1.4 String::split的功能
	 * @param1 splitedStr 需要被分割的String
	 * @param2 splitConditon 分割的条件字符
	 * @return String[] 分隔后的数组
	 */
	public static String[] splitString(String splitedStr, String splitConditon)
	{
		int start = 0;
		int end = 0;
		ArrayList<String> list = new ArrayList<String>();
		String tmp = null;
		while (true)
		{
            if(start == splitedStr.length())
            {
                break;
            }
            
			end = splitedStr.indexOf(splitConditon, start);
			if (end == -1)
			{
				tmp = splitedStr.substring(start, splitedStr.length());
				list.add(tmp);
				break;
			}
            if(start != end)
            {
                tmp = splitedStr.substring(start, end);
                list.add(tmp);
            }
			start = end + splitConditon.length();
		}
		String[] res = new String[list.size()];
		for (int i = 0; i < list.size(); i++)
		{
			res[i] = (String) list.get(i);
		}
		return res;
	}
	
	/**
	 *  
	 */
	public static String formatString ( String strData )
	{
		if (strData == null || strData.trim().length ( ) <= 0)
		{
			return "" ;
		} else
		{
			return strData.trim() ;
		}
	}
	public static String formatStringForHtml( String strData )
	{
		if (strData == null || strData.trim().length ( ) <= 0)
		{
			return "&nbsp;" ;
		} else
		{
			return strData.trim() ;
		}
	}
	
    /**
     * 判断字符串非空(不为null，且不是空字符串)
     * 
     * @param strInput
     * @return
     */
    public static boolean isNotBlank(String strInput)
    {
        return!isBlank(strInput);
    }
    
    /**
     * 判断字符串为空(为null，或是空字符串)
     * 
     * @param strInput
     * @return
     */
    public static boolean isBlank(String strInput)
    {
        if(strInput==null
                || strInput.trim().length()<=0)
        {
            return true;
        }
        return false;
    }
    
    /**
     * 把BigDecimal类型转换为带千分号的数字字符串
     */
    public static String formatBigDecimaltoString(BigDecimal data){
		if(data==null){
			return "";
		}
		if(data==BigDecimal.ZERO){
			return "0";
		}
		return formatNumber(Double.valueOf(data.toString()), DataFormat.DOUBLE_SCALE);
	}
}

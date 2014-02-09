package com.neusoft.base.common;

import java.util.Collection;
import java.util.Map;

/**
 * 校验工具类 
 */
public class ValidateUtil {
	/**
	 * 验证字符串有效性
	 */
	public static boolean isValid(String str){
		if(str == null || "".equals(str)){
			return false ;
		}
		return true ;
	}
	
	/**
	 * 验证集合是否有效 
	 */
	public static boolean isValid(Collection coll){
		if(coll == null || coll.isEmpty()){
			return false ;
		}
		return true ;
	}
	/**
	 * 判断map的有效性 
	 */
	public static boolean isValid(Map map){
		if(map == null || map.isEmpty()){
			return false ;
		}
		return true ;
	}
	
	/**
	 * 判断数组的有效性 
	 */
	public static boolean isValid(Object[] os){
		if(os == null || os.length == 0){
			return false ;
		}
		return true ;
	}

	public static boolean isValid(Integer productid)
		{

			if(productid!=null&&productid>0)
			{
				return true;
			}
			return  false;
		}
	public static boolean isValid(Long productid)
	{

		if(productid!=null&&productid>0)
		{
			return true;
		}
		return  false;
	}

	public static boolean isValid(Float winRate) {
		// 
		if(winRate!=null&&winRate>0)
		{
			return true;
		}
		return  false;
	}
	
	public static boolean isValid(Double winRate) {
		// 
		if(winRate!=null&&winRate>0)
		{
			return true;
		}
		return  false;
	}
}

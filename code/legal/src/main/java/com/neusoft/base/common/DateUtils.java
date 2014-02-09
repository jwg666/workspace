package com.neusoft.base.common;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author Tom
 */
public class DateUtils {
	private StringBuffer buffer = new StringBuffer();
	private static final String ZERO = "0";
	public static final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyyMMdd");
	public static final SimpleDateFormat FORMAT1 = new SimpleDateFormat(
			"yyyyMMdd HH:mm:ss");
	public static final SimpleDateFormat FORMAT2 = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm");
	public static final SimpleDateFormat FORMAT3 = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat FORMAT4 = new SimpleDateFormat(
			"yyyy/MM/dd HH:mm:ss");
	public static final SimpleDateFormat FORMAT5 = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat FORMAT6 = new SimpleDateFormat("MM-dd HH:mm");
	public static final SimpleDateFormat FORMAT7 = new SimpleDateFormat(
			"yyyyMMddHHmmss");

	public static Date parse(SimpleDateFormat format, String date) {
		Date d = null;
		try {
			synchronized (format) {
				d = format.parse(date);
			}
		} catch (ParseException e) {
			//e.printStackTrace();
		}
		return d;
	}

	public static String formatDuring(Long mss) {
		if (mss == null){
			return "";
		}
		long days = mss / (1000 * 60 * 60 * 24);
		long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
		long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
		long seconds = (mss % (1000 * 60)) / 1000;
		StringBuffer sb = new StringBuffer();
		if (days > 0){
			sb.append(days).append(" 天 ");
		}
		if (hours > 0){
			sb.append(hours ).append( " 小时 ");
		}
		if (minutes > 0){
			sb.append(minutes ).append( " 分 ");
		}
		if (seconds > 0){
			sb.append(seconds ).append( " 秒 ");
		}
		return sb.toString();
	}

	public String getNowString() {
		Calendar calendar = getCalendar();
		buffer.delete(0, buffer.capacity());
		buffer.append(getYear(calendar));

		if (getMonth(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMonth(calendar));

		if (getDate(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getDate(calendar));
		if (getHour(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getHour(calendar));
		if (getMinute(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getMinute(calendar));
		if (getSecond(calendar) < 10) {
			buffer.append(ZERO);
		}
		buffer.append(getSecond(calendar));
		return buffer.toString();
	}

	private static int getDateField(Date date, int field) {
		Calendar c = getCalendar();
		c.setTime(date);
		return c.get(field);
	}

	public static int getYearsBetweenDate(Date begin, Date end) {
		int bYear = getDateField(begin, Calendar.YEAR);
		int eYear = getDateField(end, Calendar.YEAR);
		return eYear - bYear;
	}

	public static int getMonthsBetweenDate(Date begin, Date end) {
		int bMonth = getDateField(begin, Calendar.MONTH);
		int eMonth = getDateField(end, Calendar.MONTH);
		return eMonth - bMonth;
	}

	public static int getWeeksBetweenDate(Date begin, Date end) {
		int bWeek = getDateField(begin, Calendar.WEEK_OF_YEAR);
		int eWeek = getDateField(end, Calendar.WEEK_OF_YEAR);
		return eWeek - bWeek;
	}

	public static int getDaysBetweenDate(Date begin, Date end) {
		int bDay = getDateField(begin, Calendar.DAY_OF_YEAR);
		int eDay = getDateField(end, Calendar.DAY_OF_YEAR);
		return eDay - bDay;
	}


	/**
	 * 鑾峰彇date骞村悗鐨刟mount骞寸殑绗竴澶╃殑寮�鏃堕棿
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static Date getSpecficYearStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.YEAR, amount);
		cal.set(Calendar.DAY_OF_YEAR, 1);
		return getStartDate(cal.getTime());
	}

	/**
	 * 鑾峰彇date骞村悗鐨刟mount骞寸殑鏈�悗涓�ぉ鐨勭粓姝㈡椂闂�
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static Date getSpecficYearEnd(Date date, int amount) {
		Date temp = getStartDate(getSpecficYearStart(date, amount + 1));
		Calendar cal = Calendar.getInstance();
		cal.setTime(temp);
		cal.add(Calendar.DAY_OF_YEAR, -1);
		return getFinallyDate(cal.getTime());
	}

	/**
	 * 鑾峰彇date鏈堝悗鐨刟mount鏈堢殑绗竴澶╃殑寮�鏃堕棿
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static Date getSpecficMonthStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, amount);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		return getStartDate(cal.getTime());
	}

	/**
	 * 鑾峰彇褰撳墠鑷劧鏈堝悗鐨刟mount鏈堢殑鏈�悗涓�ぉ鐨勭粓姝㈡椂闂�
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static Date getSpecficMonthEnd(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getSpecficMonthStart(date, amount + 1));
		cal.add(Calendar.DAY_OF_YEAR, -1);
		return getFinallyDate(cal.getTime());
	}

	/**
	 * 鑾峰彇date鍛ㄥ悗鐨勭amount鍛ㄧ殑寮�鏃堕棿锛堣繖閲屾槦鏈熶竴涓轰竴鍛ㄧ殑寮�锛�
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static String getSpecficWeekStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 璁剧疆涓�懆鐨勭涓�ぉ涓烘槦鏈熶竴 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		SimpleDateFormat formatter = new SimpleDateFormat("MM-dd");
		return formatter.format(cal.getTime());
	}

	public static String getSpecficWeekStartTime(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 璁剧疆涓�懆鐨勭涓�ぉ涓烘槦鏈熶竴 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(cal.getTime());
	}

	/**
	 * 鑾峰彇date鍛ㄥ悗鐨勭amount鍛ㄧ殑鏈�悗鏃堕棿锛堣繖閲屾槦鏈熸棩涓轰竴鍛ㄧ殑鏈�悗涓�ぉ锛�
	 * 
	 * @param amount
	 *            鍙銆佸彲璐�
	 * @return
	 */
	public static String getSpecficWeekEnd(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 璁剧疆涓�懆鐨勭涓�ぉ涓烘槦鏈熶竴 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		SimpleDateFormat formatter = new SimpleDateFormat("MM-dd");
		return formatter.format(cal.getTime());
	}

	public static String getSpecficWeekTuesDay(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 璁剧疆涓�懆鐨勭涓�ぉ涓烘槦鏈熶竴 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(cal.getTime());
	}

	public static String getSpecficWeekEndTime(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY); /* 璁剧疆涓�懆鐨勭涓�ぉ涓烘槦鏈熶竴 */
		cal.add(Calendar.WEEK_OF_MONTH, amount);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		return formatter.format(cal.getTime());
	}

	public static Date getSpecficDateStart(Date date, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DAY_OF_YEAR, amount);
		return getStartDate(cal.getTime());
	}

	/**
	 * 寰楀埌鎸囧畾鏃ユ湡鐨勪竴澶╃殑鐨勬渶鍚庢椂鍒�3:59:59
	 * 
	 * @param date
	 * @return
	 */
	public static Date getFinallyDate(Date date) {
		synchronized (FORMAT) {
			String temp = FORMAT.format(date);
			temp += " 23:59:59";
			try {
				synchronized (FORMAT1) {
					return FORMAT1.parse(temp);
				}
			} catch (ParseException e) {
				return null;
			}
		}

	}

	/**
	 * 寰楀埌鎸囧畾鏃ユ湡鐨勪竴澶╃殑寮�鏃跺埢00:00:00
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartDate(Date date) {
		synchronized (FORMAT) {
			String temp = FORMAT.format(date);
			temp += " 00:00:00";

			try {
				synchronized (FORMAT) {
					return FORMAT1.parse(temp);
				}
			} catch (Exception e) {
				return null;
			}
		}
	}

	private int getYear(Calendar calendar) {
		return calendar.get(Calendar.YEAR);
	}

	private int getMonth(Calendar calendar) {
		return calendar.get(Calendar.MONDAY) + 1;
	}

	private int getDate(Calendar calendar) {
		return calendar.get(Calendar.DATE);
	}

	private int getHour(Calendar calendar) {
		return calendar.get(Calendar.HOUR_OF_DAY);
	}

	private int getMinute(Calendar calendar) {
		return calendar.get(Calendar.MINUTE);
	}

	private int getSecond(Calendar calendar) {
		return calendar.get(Calendar.SECOND);
	}

	private static Calendar getCalendar() {
		return Calendar.getInstance();
	}


	public static Date dateAddSub(Date date, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR)
				+ n);
		return calendar.getTime();
	}

	public static Date minuteAddSub(Date date, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, n);
		return calendar.getTime();
	}

	public static String format(SimpleDateFormat format, Date expiredTime) {
		if (expiredTime == null) {
			return "";
		}
		synchronized (format) {
			return format.format(expiredTime);
		}
	}

	public static <T extends java.util.Date> T parse(String dateString,
			DateFormat dateFormat, Class<T> targetResultType) {
		if (!ValidateUtil.isValid(dateString)){
			return null;
		}
		try {
			long time = dateFormat.parse(dateString).getTime();
			java.util.Date t = targetResultType.getConstructor(long.class)
					.newInstance(time);
			return (T) t;
		} catch (ParseException e) {
			String errorInfo = "cannot use dateformat:" + dateFormat
					+ " parse datestring:" + dateString;
			throw new IllegalArgumentException(errorInfo, e);
		} catch (Exception e) {
			throw new IllegalArgumentException("error targetResultType:"
					+ targetResultType.getName(), e);
		}
	}

	public static String getDayBefore(Date date, int day) {
		String beforeDay = "";
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(c.DAY_OF_MONTH, day);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		beforeDay = formatter.format(c.getTime());
		return beforeDay;
	}

}

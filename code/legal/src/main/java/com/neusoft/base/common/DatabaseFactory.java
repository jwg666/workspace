package com.neusoft.base.common;

import java.sql.Connection;
import java.sql.DriverManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabaseFactory {
	private static Connection connection;
	private static Logger logger = LoggerFactory.getLogger(DatabaseFactory.class);
	/**
	 * 获取连接
	 * @param dblink
	 * @return
	 */
	public static Connection getConnection(String type,String ip,String port,String dbname,String userName,String password){
		try {
			String url = "";
			/**
			 * 用jtds连接数据库，支持用于JDBC 3.0驱动Microsoft SQL Server （6.5 ，7 ，2000和2005版本）和Sybase（10 ，11 ，12 ，15 版本）的驱动程序
			 */
			if ("1".equals(type)) {//mssql,
				Class.forName("net.sourceforge.jtds.jdbc.Driver");
				url = "jdbc:jtds:sqlserver://"+ip+":"+port+";DatabaseName="+dbname;			
			}
			if ("2".equals(type)) {//oracle
				Class.forName("oracle.jdbc.driver.OracleDriver");
				url = "jdbc:oracle:thin:@//"+ip+":"+port+":"+dbname;				
			}
			if ("3".equals(type)) {//mysql
				Class.forName("com.mysql.jdbc.Driver");
				url = "jdbc:mysql://"+ip+":"+port+"/"+dbname;		
			}
			if ("4".equals(type)) {//db2
				Class.forName("com.ibm.db2.jcc.DB2Driver");
				url = "jdbc:db2://"+ip+":"+port+"/"+dbname;
			}
			
			connection = DriverManager.getConnection(url, userName, password);
		} catch (Exception e) {
			logger.error("获取连接出错，请检查", e);
		}
		
		return connection;
	}
}

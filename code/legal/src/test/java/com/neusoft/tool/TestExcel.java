package com.neusoft.tool;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.neusoft.base.common.DBUtil;
import com.neusoft.base.common.DatabaseFactory;

public class TestExcel {
	//指标1
	private String[] titles1 = {"分中心","经营体","主售达方编码","主售达方名称","产品组	","成功送HP数","HP返回派工数","成功送LES数","总单据","小微业务占比"};
	//指标2
	private String[] titles2 = {"分中心","经营体","主售达方编码","主售达方名称","产品组","总库存","HUB库存","挪库率"};
	//指标3
	private String[] titles3 = {"分中心","经营体","售达方编码","售达方名称","产品组","系统传输达标率"};
	//指标发送邮件
	private String[] mailNorm = {"",""};
	//群发统计
	private String[] mailCount = {"分中心","经营体","主售达方编码","主售达方名称","成功送HP数","HP返回派工数","成功送LES数","总单据	","小微业务占比"};
	//群发邮件
	private String[] mailAll = {};
	//指标1SQL
	private String sql1;
	//指标2SQL
	private String sql2;
	//指标3SQL
	private String sql3;
	//统计SQL
	private String sqlCount;
	private Connection connection;
	@Before	
	public void init(){
		//指标1
		sql1 = "SELECT p.branch_name 分中心,"+
       " p.bu_name 经营体,"+
       " p.cust_code 主售达方编码,"+
       " p.cust_name 主售达方名称,"+
       " COUNT(t.hp_deal_time) 成功送hp数,"+
       " COUNT(decode(t.hp_deal_flag, NULL, t.hp_deal_time)) hp返回派工数,"+
       " COUNT(decode(t.deal_flag, NULL, t.deal_time)) 成功送les数,"+
       " COUNT(c.row_id) 总单据,"+
       " decode(COUNT(c.row_id),"+
              " 0,"+
              " 0,"+
              "round(COUNT(decode(t.deal_flag, NULL, t.deal_time)) /"+
                    "COUNT(c.row_id) * 100,"+
                   " 2)) || '%' 小微业务占比"+
 " FROM bvs.ods_cust_order_les t,"+
      " bvs.ods_cust_order     c,"+
      " bvs.sys_billing_info   i,"+
      " bvs.sys_billing_info   p,"+
      " bvs.md_goods           m"+
" WHERE c.revise_flag = '20'"+
  " and c.row_id = t.origin_id(+)"+
  " AND c.cust_code = i.cust_code"+
  " AND c.goods_code = m.code"+
  " AND i.parent_code = p.cust_code"+
  "  AND i.active_flag <= '1'"+
  " AND i.open_status >= 30"+
  " AND c.order_type_code IN ('DL006', 'DL007')  "+
  " AND i.tc_flag IN ('3', '4')"+
  " AND m.prd_grp_code in"+
  "  ('AB', 'AA', 'DA', 'DB', 'FA', 'FB', 'GB', 'GC', 'FC')"+
  " and c.order_date >= to_date('2014-03-01', 'yyyy-mm-dd')"+
  " AND c.order_date < trunc(SYSDATE) "+//--截止昨天24点   "+
  " GROUP BY p.branch_name, p.bu_name, p.cust_code, p.cust_name"+
  " ORDER BY 1, 2, 3, 4";
		//指标2
		sql2 = "SELECT p.branch_name 分中心,"+
       " p.bu_name 经营体,"+
       " p.cust_code 主售达方编码,"+
       " p.cust_name 主售达方名称,"+
       " g.prd_grp_desc 产品组,"+
       " nvl(SUM(t1.aa), 0) 总库存,"+
       " nvl(SUM(t2.bb), 0) hub库存,"+
       " to_number(round(decode(nvl(SUM(t1.aa), 0),"+
                              "0,"+
                              "0,"+
                              "nvl(SUM(t2.bb), 0) / nvl(SUM(t1.aa), 0)) * 100,"+
                       "2)) || '%' 挪库率"+
  " FROM (SELECT i.cust_code,t.goods_code, SUM(t.store_amt) aa"+
        "  FROM bvs.ods_storage_amt_ws t, bvs.sys_billing_info i"+
        " WHERE i.open_status = 30"+
        "   AND t.cust_code = i.cust_code"+
        "   AND t.storage_date = To_Date('2014-02-28', 'yyyy-mm-dd')"+
        "   AND i.tc_flag IN ('3', '4')"+
        " GROUP BY i.cust_code,t.goods_code) t1,"+
      " (SELECT t.cust_code, t.goods_code,SUM(t.store_amt) bb"+
       "   FROM bvs.ods_storage_amt_ws t, bvs.stg_les_tc_store c"+
      "   WHERE c.flag1 IS NULL"+
       "    AND c.flag = 'C'"+
       "    AND t.storage_code = c.kunag"+
       "    AND  t.storage_date = To_Date('2014-02-28', 'yyyy-mm-dd')"+
       "  GROUP BY t.cust_code,t.goods_code) t2,"+
     "  bvs.sys_billing_info i,"+
     "  bvs.sys_billing_info p,"+
    "   bvs.md_goods g"+
" WHERE t1.cust_code = t2.cust_code(+)"+
 "  and t1.goods_code =t2.goods_code(+)"+
 "  AND t1.cust_code = i.cust_code"+
 "  AND i.parent_code = p.cust_code"+
"   and t1.goods_code =g.code"+
 "  and g.active_flag>='1'"+
 "  and g.prd_grp_id in('31','32','36','37','38','39','35','41','42','43','45','46','47','48','92')"+
" GROUP BY p.branch_name, p.cust_code, p.cust_name, p.bu_name,g.prd_grp_desc"+
" ORDER BY 1, 2, 3, 4,5";
		
		connection = DatabaseFactory.getConnection("2", "hrbvsdb.JXJG.corp.haier.com", "1521", "hrbvsdb", "ECODESEL", "ECODESEL0106");
	}
	@Test
	public void testWrite(){
		try{
			 //  打开文件 
	        WritableWorkbook book  =  Workbook.createWorkbook( new  File( "E:\\export\\指标.xls" ));
	        //  生成名为“第一页”的工作表，参数0表示这是第一页 
	        WritableSheet sheet1  =  book.createSheet( "指标1" ,  0 );
	        WritableSheet sheet2  =  book.createSheet( "挪库率" ,  1 );
	        WritableSheet sheet3  =  book.createSheet( "系统传输达标率" ,  2 );
	        //创建指标1第一列
	       	for (int i = 0; i < titles1.length; i++) {
				Label label = new Label(i, 1, titles1[0]);
				sheet1.addCell(label);
			}
	       	ResultSet rs = DBUtil.find(connection, sql1);
	       	int rowNum = 1;
	       	while(rs.next()){
	       		Label label = new Label(0, rowNum, rs.getString(1));
				sheet1.addCell(label);
				
				Label label2 = new Label(1, rowNum, rs.getString(2));
				sheet1.addCell(label2);
				
				Label label3 = new Label(2, rowNum, rs.getString(3));
				sheet1.addCell(label3);
				
				Label label4 = new Label(3, rowNum, rs.getString(4));
				sheet1.addCell(label4);
				
				Label label5 = new Label(4, rowNum, rs.getString(5));
				sheet1.addCell(label5);
				
				Label label6 = new Label(5, rowNum, rs.getString(6));
				sheet1.addCell(label6);
				
				Label label7 = new Label(6, rowNum, rs.getString(7));
				sheet1.addCell(label7);
				
				Label label8 = new Label(7, rowNum, rs.getString(8));
				sheet1.addCell(label8);
				
				rowNum++;
	       	}
	        //创建指标2第一列
	       	for (int i = 0; i < titles2.length; i++) {
				
			}
	        //创建指标3第一列
	       	for (int i = 0; i < titles3.length; i++) {
				
			}
	        /* 
	        * 生成一个保存数字的单元格 必须使用Number的完整包路径，否则有语法歧义 单元格位置是第二列，第一行，值为789.123
	         */ 
	  
	
	        //  写入数据并关闭文件 
	        book.write();
	        book.close();
	   }   catch  (Exception e)  {
	       e.printStackTrace();
	   } 
	}
	@After
	public void clear(){
		try {
			connection.close();
			sql1 = null;
			sql2 = null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

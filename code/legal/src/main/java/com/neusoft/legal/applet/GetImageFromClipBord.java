package com.neusoft.legal.applet;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class GetImageFromClipBord extends Applet {

	private static final long serialVersionUID = 8083172568942351418L;
	private Button getSignPicButton ;
//	@Override
//	public void init() {		
//		setLayout(new BorderLayout());
//		getSignPicButton = new Button();
//		getSignPicButton.setLabel("获取签名");
//		getSignPicButton.addMouseListener(new MouseListener() {
//			@Override
//			public void mouseClicked(MouseEvent e) {
//				Image image = getImageClipboard();
//				getGraphics().drawImage(image, 5,20,200,200,null);	
//				String url = "";
//			}
//
//			@Override
//			public void mousePressed(MouseEvent e) {
//				
//			}
//
//			@Override
//			public void mouseReleased(MouseEvent e) {
//				
//			}
//
//			@Override
//			public void mouseEntered(MouseEvent e) {
//				
//			}
//
//			@Override
//			public void mouseExited(MouseEvent e) {
//				
//			}			
//
//		});
//		this.add(getSignPicButton,BorderLayout.NORTH);
//		
//	}
	public String getSignId(){
		Image image = getImageClipboard();
		List<String> list  = new ArrayList<String>();  //要上传的文件名,如：d:\haha.doc.你要实现自己的业务。我这里就是一个空list.

		try {
			String BOUNDARY = "---------7d4a6d158c9"; // 定义数据分隔线
			URL url = new URL("http://localhost/JobPro/upload.do");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			conn.setRequestProperty("Charsert", "UTF-8");
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
			OutputStream out = new DataOutputStream(conn.getOutputStream());
			byte[] end_data = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();// 定义最后数据分隔线
			int leng = list.size();
			for(int i=0;i<leng;i++){
				String fname = list.get(i);
				File file = new File(fname);
				StringBuilder sb = new StringBuilder();
				sb.append("--");
				sb.append(BOUNDARY);
				sb.append("\r\n");
				sb.append("Content-Disposition: form-data;name=\"file"+i+"\";filename=\""+ file.getName() + "\"\r\n");
				sb.append("Content-Type:application/octet-stream\r\n\r\n");
				byte[] data = sb.toString().getBytes();
				out.write(data);
				DataInputStream in = new DataInputStream(new FileInputStream(file));
				int bytes = 0;
				byte[] bufferOut = new byte[1024];
				while ((bytes = in.read(bufferOut)) != -1) {
					out.write(bufferOut, 0, bytes);
				}
				out.write("\r\n".getBytes()); //多个文件时，二个文件之间加入这个
				in.close();
			}
			out.write(end_data);
			out.flush();
			
			// 定义BufferedReader输入流来读取URL的响应
			int res = conn.getResponseCode();
			if (res == 200) {
				InputStream in = conn.getInputStream();
				int ch;
				StringBuilder sb2 = new StringBuilder();
				while ((ch = in.read()) != -1) {
					sb2.append((char) ch);
				}
				out.close();
				conn.disconnect();
				return in.toString();
			}
		} catch (Exception e) {
			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
		}
		return "";
	}
	private String getClipseString(){
		 Clipboard sysClb=null;  
		    sysClb = Toolkit.getDefaultToolkit().getSystemClipboard();  
		    Transferable t = sysClb.getContents(null);  
		    //Transferable t = Toolkit.getDefaultToolkit().getSystemClipboard().getContents(null);  //跟上面三行代码一样  
		    try {   
		        if (null != t && t.isDataFlavorSupported(DataFlavor.stringFlavor)) {   
		        String text = (String)t.getTransferData(DataFlavor.stringFlavor);   
		        return text;   
		        }   
		    } catch (UnsupportedFlavorException e) {  
		        //System.out.println("Error tip: "+e.getMessage());  
		    } catch (IOException e) {   
		    	
		    }	
		return "";
	}
	
	private Image getImageClipboard() {   
	    Transferable t = Toolkit.getDefaultToolkit().getSystemClipboard().getContents(null);   
	    try {   
	        if (null  != t && t.isDataFlavorSupported(DataFlavor.imageFlavor)) {   
	        Image image = (Image)t.getTransferData(DataFlavor.imageFlavor);   
	        return image;   
	        }   
	    } catch (UnsupportedFlavorException e) {   
	          //System.out.println("Error tip: "+e.getMessage());  
	    } catch (IOException e) {   
	          //System.out.println("Error tip: "+e.getMessage());  
	    }   
	    return null;  
	}
}

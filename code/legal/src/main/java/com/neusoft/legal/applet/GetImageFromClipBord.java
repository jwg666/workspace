package com.neusoft.legal.applet;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;

import org.apache.commons.io.output.ByteArrayOutputStream;

public class GetImageFromClipBord extends Applet {

	private static final long serialVersionUID = 8083172568942351418L;
	private Button getSignPicButton ;
	public boolean widthDone = false;
	public boolean heightDone = false;
	@Override
	public void init() {		
		setLayout(new BorderLayout());
		getSignPicButton = new Button();
		getSignPicButton.setLabel("获取签名");
		getSignPicButton.addMouseListener(new MouseListener() {
			@Override
			public void mouseClicked(MouseEvent e) {
				String id = getSignId();
				getGraphics().drawString(id, 20, 20);
			}

			@Override
			public void mousePressed(MouseEvent e) {
				
			}

			@Override
			public void mouseReleased(MouseEvent e) {
				
			}

			@Override
			public void mouseEntered(MouseEvent e) {
				
			}

			@Override
			public void mouseExited(MouseEvent e) {
				
			}			

		});
		this.add(getSignPicButton,BorderLayout.NORTH);
		
	}
	public String getSignId(){
		BufferedImage image = getImageClipboard();
//		BufferedImage bufferedImage = new BufferedImage(image.getWidth(null), image.getHeight(null), BufferedImage.TYPE_INT_RGB);
//		Graphics2D g = bufferedImage.createGraphics();
//		g.drawImage(image, null, null);
//		waitForImage(bufferedImage);
		try {
//			File file = File.createTempFile("temp_sign", "jpeg");
//			fis = new FileOutputStream(file);
//			oos = new ObjectOutputStream(fis);
//			oos.writeObject(image);
//			oos.close();
			
			String BOUNDARY = "---------714a6d158c9"; // 定义数据分隔线
			URL url = new URL("http://127.0.0.1:8080/legal/remoting/remoteUpload.servlet");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
			conn.setRequestProperty("Charsert", "GBK");
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
			OutputStream out = new DataOutputStream(conn.getOutputStream());
			
			StringBuilder sb = new StringBuilder();
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			String fileName = "singName";
			sb.append("Content-Disposition: form-data;name=\"upload\";uploadFileName=\""+fileName+"\"\r\n");
			sb.append("Content-Type:application/octet-stream\r\n\r\n");
			byte[] begin_data = sb.toString().getBytes();
			out.write(begin_data);
			///生成图片流
			ByteArrayOutputStream bs = new ByteArrayOutputStream(); 
			ImageOutputStream imOut = ImageIO.createImageOutputStream(bs); 
			ImageIO.write(image, "png",imOut);
			ByteArrayInputStream in = new ByteArrayInputStream(bs.toByteArray());
//			ImageInputStream iis = ImageIO.createImageInputStream(imOut);
			imOut.flush();
			imOut.close();
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			///写图片流
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}
			in.close();
			
			byte[] end_data = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();// 定义最后数据分隔线
			out.write(end_data);
			out.flush();
			out.close();
			// 定义BufferedReader输入流来读取URL的响应
			int res = conn.getResponseCode();
			if (res == 200) {
				InputStream in2 = conn.getInputStream();
				int ch;
				StringBuilder sb2 = new StringBuilder();
				while ((ch = in2.read()) != -1) {
					sb2.append((char) ch);
				}
				in2.close();				
				conn.disconnect();
				return sb2.toString();
			}
		} catch (Exception e) {
			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
		}
		return "";
	}
	
	private BufferedImage getImageClipboard() {   
	    Transferable t = Toolkit.getDefaultToolkit().getSystemClipboard().getContents(null);   
	    try {   
	        if (null  != t && t.isDataFlavorSupported(DataFlavor.imageFlavor)) {   
	        	BufferedImage image = (BufferedImage)t.getTransferData(DataFlavor.imageFlavor);   
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

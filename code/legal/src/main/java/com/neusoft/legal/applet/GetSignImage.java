package com.neusoft.legal.applet;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Button;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;

//import netscape.javascript.JSObject;

public class GetSignImage extends Applet {

	private static final long serialVersionUID = 8083172568942351418L;
	private Button getSignPicButton ;
//	public boolean widthDone = false;
//	public boolean heightDone = false;
	private String baseDomain = "http://115.28.33.228:8080/legal";
	@Override
	public void init() {		
//		final Applet applet = this;
		setLayout(new BorderLayout());
		getSignPicButton = new Button();
		getSignPicButton.setLabel("»ñÈ¡Ç©Ãû");
		getSignPicButton.addMouseListener(new MouseListener() {
			@Override
			public void mouseClicked(MouseEvent e) {
//				String[] ids = {getSignId()};
				Image image = getImageClipboard();
//				getGraphics().
				getGraphics().drawImage(image,30,30,150,80,null);
//				JSObject window=JSObject.getWindow(applet);
//				window.call("setSignId", ids);
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
    
	@Override
	public void paint(Graphics g) {
		Image image = getImageClipboard();
		if (image!=null) {
			g.drawImage(image,30,30,150,80,null);
		}
		
	}

	public String getSignId(){
		BufferedImage image = getImageClipboard();
		try {
			
			String BOUNDARY = java.util.UUID.randomUUID().toString();
			URL url = new URL(baseDomain+"/remoting/remoteUpload.servlet");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
//			conn.setRequestProperty("Charsert", "GBK");
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
			ByteArrayOutputStream bs = new ByteArrayOutputStream();
			ImageOutputStream imOut = ImageIO.createImageOutputStream(bs); 
			ImageIO.write(image, "png",imOut);
			ByteArrayInputStream in = new ByteArrayInputStream(bs.toByteArray());
//			ImageInputStream iis = ImageIO.createImageInputStream(imOut);
			imOut.flush();
			imOut.close();
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}
			in.close();
			byte[] end_data = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();// ??????????????
			out.write(end_data);
			out.flush();
			out.close();
			
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
			System.out.println("????POST???????????" + e);
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
//	@SuppressWarnings({ "unchecked", "rawtypes" })
//	public String secureSign(){
//	    final Map idMap = new HashMap();
//
//	    java.security.AccessController.doPrivileged(
//	        new java.security.PrivilegedAction(){
//	            public Object run() {
//	                // execute the privileged command
////	                executeCommand(cmd);
//	                // we must return an object, so we'll return an empty string
//	            	idMap.put("id", getSignId());
//	                return "";
//	            }
//	        }
//	    );
//	    String id = (String)idMap.get("id");
//	    return id;
//	}
	
}

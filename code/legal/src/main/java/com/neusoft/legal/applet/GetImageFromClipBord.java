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
import java.io.IOException;

public class GetImageFromClipBord extends Applet {

	private static final long serialVersionUID = 8083172568942351418L;
	private Button getSignPicButton ;
	@Override
	public void init() {		
		setLayout(new BorderLayout());
		getSignPicButton = new Button();
		getSignPicButton.setLabel("获取签名");
		getSignPicButton.addMouseListener(new MouseListener() {
			@Override
			public void mouseClicked(MouseEvent e) {
				Image image = getImageClipboard();
				getGraphics().drawImage(image, 5,20,200,200,null);	
				String url = "";
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

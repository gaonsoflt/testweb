package egovframework.urtown.controller;


import java.awt.Graphics2D;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.urtown.service.EditorBrowserService;

import com.google.gson.Gson; 
import com.google.gson.reflect.TypeToken;
import com.fasterxml.jackson.databind.util.JSONPObject; 

import egovframework.com.cmm.service.Globals;
import egovframework.common.service.CommonService;
import egovframework.urtown.service.SystemMngCctvService;

@Controller
@RequestMapping(value = "/file/")
public class FileUploadController {
Logger logger = LoggerFactory.getLogger(FileUploadController.class.getName());
    
	@Resource(name = "systemMngCctvService")
	private SystemMngCctvService systemMngCctvService;

	@Resource(name = "commonService")
	private CommonService commonService;
	
	@Resource(name = "editorBrowserService")
	private EditorBrowserService editorBrowserService;
	
	
	final String defaultUrl = Globals.Filepath_ECGDir;
	final String ECGUrl = Globals.Filepath_ECGUrl;
	
	
	@RequestMapping(value = "create.do")	
	public @ResponseBody JSONPObject createFileUpload(MultipartHttpServletRequest request, HttpServletRequest request2) throws Exception{
		
		MultipartFile file = request.getFile("ECG_FILE");
		String jsonString = request.getParameter("params").toString();
		HashMap<String, Object> map = new Gson().fromJson(jsonString, new TypeToken<HashMap<String, String>>(){}.getType());

		
		//Folder에 파일 생성
		String name 			= file.getName();
		String fileName 		= file.getOriginalFilename();							//파일 이름
		String fileType			= fileName.substring(fileName.lastIndexOf(".")+1);		//파일 타입	 jpg
		String fileContentType	= file.getContentType();								//파일 타입	 image/jpeg
		long fileSize			= file.getSize();										//파일 사이즈
		String realPath 		= defaultUrl; 									//파일 경로
		
		List<Map<String, Object>> entries = new ArrayList<Map<String, Object>>();
		Map<String, Object> entry = new HashMap<String, Object>();
		
		entry.put("name", fileName);
		entry.put("type", fileType);
		entry.put("size", fileSize);
		entries.add(entry);

		File targetDir = new File(defaultUrl);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		File nFile = new File(defaultUrl);
		nFile.mkdir();
		
		
		//DB에 정보 입력
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String FILE_SNM = format.format(new Date()) + "_" + String.valueOf(ts.getTime());
		
		map.put("FILE_SNM", FILE_SNM);
		map.put("FILE_ONM", fileName);
		map.put("FILE_SIZE", fileSize);
		map.put("FILE_PATH", ECGUrl);
		map.put("FILE_EX", fileType); 
		editorBrowserService.saveFiles(map);
		 
		double angle = 270;
		BufferedImage image = ImageIO.read(file.getInputStream());
        rotate(realPath + FILE_SNM, image, angle); 

		//BufferedImage image = ImageIO.read(file.getInputStream());
		//ByteArrayOutputStream baos = new ByteArrayOutputStream(); 
		//ImageIO.write(image, fileType, baos);
        
        //BufferedImage bufferedImage = new BufferedImage(rImage.getWidth(), rImage.getHeight(), BufferedImage.TYPE_INT_BGR);
        //OutputStream out = new FileOutputStream(realPath + FILE_SNM+"_test"); //파일로 출력하기위해 파일출력스트림 생성 
		//javax.imageio.ImageIO.write(rImage, "TEST", out);
		
		
		//File Write
		/*
        FileOutputStream fos = null;
		byte[] fileByte; 
		try{
			fileByte = file.getBytes(); 
			fos = new FileOutputStream(realPath + FILE_SNM);
			fos.write(fileByte);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			fos.close();
		}
		*/
		
		
		return null;
	}
	
	
	
	
	public static void rotate(String path, BufferedImage image, double angle) {
		
	    try {
	    	int width = image.getWidth();
	    	int height = image.getHeight();
	    	
	    	BufferedImage rImage;
	    	if(angle == 90 || angle == 270){
	    		rImage = new BufferedImage(height, width, image.getType());
	    	}else{
	    		rImage = new BufferedImage(width, height, image.getType());
	    	}
	    	

	        if (angle == 90 || angle == 0) {
	            for (int i = 0; i < width; i++)
	                for (int j = 0; j < height; j++)
	                    rImage.setRGB(height- j - 1, i, image.getRGB(i, j));
	       }

		    if (angle == 180) {
		        for (int i = 0; i < width; i++)
		            for (int j = 0; j < height; j++)
		                rImage.setRGB(width - i - 1, height - j - 1, image.getRGB(i, j));
		    }
	
		    if (angle == 270) {
		        for (int i = 0; i < width; i++)
		            for (int j = 0; j < height; j++)
		                rImage.setRGB(j, width - i - 1, image.getRGB(i, j));
		    }
	    	
	    	image.flush(); 
		    String imageType = "jpg"; 
	    	File out = new File(path);
			ImageIO.write(rImage, imageType, out);
	    	
			/*
			double _angle = Math.toRadians(angle);
	        double sin = Math.abs(Math.sin(_angle));
	        double cos = Math.abs(Math.cos(_angle));
	        double w = image.getWidth();
	        double h = image.getHeight();
	        int newW = (int)Math.floor(w*cos + h*sin);
	        int newH = (int)Math.floor(w*sin + h*cos);
			 */

	    	/*
		    double sin = Math.abs(Math.sin(angle)), cos = Math.abs(Math.cos(angle));
		    int w = image.getWidth(), h = image.getHeight();
		    int neww = (int)Math.floor(w*cos+h*sin), newh = (int)Math.floor(h*cos+w*sin);
	
		    GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
		    GraphicsDevice gs = ge.getDefaultScreenDevice();
		    GraphicsConfiguration gc = gs.getDefaultConfiguration();
		    BufferedImage result = gc.createCompatibleImage(neww, newh, Transparency.TRANSLUCENT);
		    Graphics2D g = result.createGraphics();
		    g.translate((neww-w)/2, (newh-h)/2);
		    g.rotate(angle, w/2, h/2);
		    g.drawRenderedImage(image, null);
		    g.dispose();
	  
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	
	
}
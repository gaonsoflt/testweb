package egovframework.urtown.controller;
 
 
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.servlet.http.Part;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.Gson;

import egovframework.com.cmm.service.Globals;
import egovframework.dgms.service.CommonService;
import egovframework.dgms.web.CommonController;
import egovframework.urtown.service.EditorBrowserService;
import egovframework.urtown.service.MediFAQService;

 

@Controller
@MultipartConfig
public class EditorBrowserController  extends HttpServlet{
	Logger logger = LoggerFactory.getLogger(CommonController.class.getName());
	
	final String defaultUrl = Globals.Filepath_BaseDir;

	@Resource(name = "editorBrowserService")
	private EditorBrowserService editorBrowserService;
	
	@Resource(name = "commonService")
	CommonService commonService;
	
	
	@RequestMapping(value = "/editor/imageFileBrowser.do")
	public String EditorTest() throws Exception {
		return "/editor/imageFileBrowser";
	}
	 
	@RequestMapping(value = "/editor/imgRead.do")
	public @ResponseBody JSONPObject editorImgRead(@RequestParam("callback") String c, HttpServletRequest request, @RequestParam Map<String,Object> paramMap) throws Exception {
		//String path = "/upload/" + (request.getParameter("path")==null? "" : request.getParameter("path"));
		//String realPath = request.getSession().getServletContext().getRealPath(path);
		String path = request.getParameter("path")==null? "" : request.getParameter("path");
		String realPath = defaultUrl + path;
		File[] files = new File(realPath).listFiles();

		List<Map<String, Object>> entries = new ArrayList<Map<String, Object>>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		for (File file : files) { 
			if(!file.isDirectory()){ 
				String ex = file.getName();  
				ex = ex.substring( (ex.lastIndexOf(".")==-1 ? 0 : ex.lastIndexOf(".")) );
				if(".jpg.jpeg.gif.png".indexOf(ex.toLowerCase()) == -1 ) continue;
			} 
			
			Map<String, Object> entry = new HashMap<String, Object>();
			entry.put("name", file.getName());
			entry.put("type", file.isDirectory() ? "d" : "f");
			
			if( !file.isDirectory() ){
				entry.put("size", file.length());	
			}
			entries.add(entry);
		}
		return new JSONPObject(c, entries); 
	}

	
	@RequestMapping(value = "/editor/fileRead.do")
	public @ResponseBody JSONPObject editorFileRead(@RequestParam("callback") String c, HttpServletRequest request, @RequestParam Map<String,Object> paramMap) throws Exception {
		String path = request.getParameter("path")==null? "" : request.getParameter("path");
		String realPath = defaultUrl + path;
		File[] files = new File(realPath).listFiles();

		List<Map<String, Object>> entries = new ArrayList<Map<String, Object>>();
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		for (File file : files) { 
			Map<String, Object> entry = new HashMap<String, Object>();
			entry.put("name", file.getName());
			entry.put("type", file.isDirectory() ? "d" : "f");
			
			if( !file.isDirectory() ){
				entry.put("size", file.length());	
			}
			entries.add(entry);
		}
		return new JSONPObject(c, entries); 
	}
	
	@RequestMapping(value = "/editor/destroy.do")
	public @ResponseBody void editorImgDestroy(HttpServletRequest request) throws Exception {
		//String path = "/upload/" + (request.getParameter("path")==null? "" : request.getParameter("path")); 
		//String realPath = request.getSession().getServletContext().getRealPath(path + fileName);
		String path = request.getParameter("path")==null? "" : request.getParameter("path");

		String fileName = request.getParameter("name");
		String realPath = defaultUrl + path + fileName; 
		
		File file = new File(realPath);
		
		if (file.isDirectory()) {
			deleteDirectory(file);
		} else {
			file.delete();	
		}
	}

	@RequestMapping(value = "/editor/create.do")
	public @ResponseBody JSONPObject editorImgCreateFolder(@RequestParam("callback") String c, HttpServletRequest request) throws Exception {
		//String path = "/upload/" + (request.getParameter("path")==null? "" : request.getParameter("path")); 
		//String realPath = request.getSession().getServletContext().getRealPath(path + fileName);
		String path = request.getParameter("path")==null? "" : request.getParameter("path");
		String fileName = request.getParameter("name");
		String realPath = defaultUrl + path + fileName; 

		//No forder in base path, make Directory
		File targetDir = new File(defaultUrl);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		File file = new File(realPath);
		file.mkdir();
		

		List<Map<String, Object>> entries = new ArrayList<Map<String, Object>>();
		Map<String, Object> entry = new HashMap<String, Object>();
		
		entry.put("name", fileName);
		entry.put("type", "d");
		entries.add(entry);
		
		return new JSONPObject(c, entries); 
	}
	
	
	
	@RequestMapping(value = "/editor/thumbnail.do")
	public @ResponseBody void editorImgThumbnail(@RequestParam("callback") String c, HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String,Object> paramMap) throws Exception {
	/*
		String realPath = request.getSession().getServletContext().getRealPath(path);

		BufferedImage img = new BufferedImage(80, 80, BufferedImage.TYPE_INT_RGB);

		img.createGraphics().drawImage(ImageIO.read(new File(realPath)).getScaledInstance(80, 80, Image.SCALE_SMOOTH),0,0,null);
		ImageIO.write(img, "jpg", response.getOutputStream());
		
	 */ 
	}
	
	

	@RequestMapping(value = "/editor/upload.do")
	public @ResponseBody void editorImgUpload(MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		MultipartFile uploadFile = request.getFile("file");
		InputStream input = uploadFile.getInputStream();
		String fileName = uploadFile.getOriginalFilename();
		int size = input.available();
		byte[] b = new byte[size];
		input.read(b);

		String path = request.getParameter("path");

		if (path == null) {
			//path = "upload/";
			path = defaultUrl;
		} else {
			path = defaultUrl + path;
		}
		  
		String realPath = path + fileName;
		//String realPath = request.getSession().getServletContext().getRealPath(path + fileName);

		FileOutputStream output = new FileOutputStream(realPath);

		output.write(b);
		output.close();
		input.close();

		Map<String, Object> entry = new HashMap<String, Object>();

		entry.put("name", fileName);
		entry.put("type", "f");
		entry.put("size", size);

		String json = new Gson().toJson(entry);

		response.getWriter().write(json);
	}
	
	 public void paramHeader(HttpServletRequest request) {
	        Enumeration paramNames = request.getParameterNames(); 
	        while(paramNames.hasMoreElements()) { 
	            String paramName = (String)paramNames.nextElement();

	            System.out.println("Header : " + paramName); 
	        
	            String[] paramValues = request.getParameterValues(paramName); 
	        
	                if (paramValues.length == 1) { 
	                    String paramValue = paramValues[0]; 
	                    if (paramValue.length() == 0) 
	                        System.out.println("Value : No Value"); 
	                    else 
	                       System.out.println(paramValue); 
	                } else { 
	                    for(int i=0; i<paramValues.length; i++) { 
	                        System.out.println("Value : " + paramValues[i]); 
	                    } 
	                } 
	            } 
	        }

	private static void deleteDirectory(File folder) {
	    File[] files = folder.listFiles();
	    if(files != null) {
	        for(File file: files) {
	            if(file.isDirectory()) {
	            	deleteDirectory(file);
	            } else {
	            	file.delete();
	            }
	        }
	    }
	    folder.delete();
	}
	
	
	@RequestMapping(value="/editor/saveFiles.do")
	public @ResponseBody String saveFiles(@RequestParam List<MultipartFile> files, MultipartHttpServletRequest request) 
		   throws Exception{
		Iterator it = files.iterator();
		
		while( it.hasNext() ){
			MultipartFile file = (MultipartFile)it.next(); 
			HashMap<String, Object> map = new HashMap();
			
			//2. File Exist
			if(!file.isEmpty()){
				String fileNm, fileType, filePath; 
				//fileNm2 = file.getName();	//파일 파라미터 이름
				byte[] fileByte;
				Long fileSize;
				
				//File Info
				Timestamp ts = new Timestamp(System.currentTimeMillis());
				
				//Create Storage File Name : YMD_Timestamp
				SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
				String FILE_SNM = format.format(new Date()) + "_" + String.valueOf(ts.getTime());
				
				
				//FIND FILE_SQ
				HashMap<String, Object> keySeq = new HashMap<String, Object>();
				keySeq.put("SEQ_NM", "SEQ_TB_FILE_INFO");
				
				String Sequence = (String)commonService.getSequence((HashMap<String, Object>)keySeq); 
				String ex = file.getOriginalFilename();
				ex = ex.substring(ex.lastIndexOf(".")+1);
						
						
						
				
				map.put( "REG_USER_SQ", request.getParameter("REG_USER_SQ") );
				map.put( "NOTICE_SQ", request.getParameter("NOTICE_SQ") );  
				map.put( "FILE_SQ", request.getParameter("FILE_SQ") );  
				map.put( "FILE_ONM", file.getOriginalFilename() ); 
				map.put( "FILE_SIZE", file.getSize() );
				map.put( "FILE_PATH", defaultUrl );
				map.put( "FILE_SNM", FILE_SNM );
				map.put( "FILE_EX", ex );
				//map.put( "FILE_SQ", Sequence );	
				
				FileOutputStream fos = null;
				fileNm = file.getOriginalFilename();
				filePath = defaultUrl + "/" + FILE_SNM; 
				
				//File Write
				try{
					fileByte = file.getBytes(); 
					fos = new FileOutputStream(filePath);
					fos.write(fileByte);
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					fos.close();
				}

				//File Data Input
				editorBrowserService.saveFiles(map);
			}
		}
		
		return "";
	}


	@RequestMapping(value="/editor/removeFiles.do")
	public @ResponseBody String removeFiles(@RequestParam String[] fileNames, HttpServletRequest request) 
			throws Exception{
			
		HashMap<String, Object> map = new HashMap<String, Object>();
		String FileSq = request.getParameter("FILE_SQ");
		map.put("FILE_SQ", FileSq);
		 
		try{
			//File Remove
			List list = (List)editorBrowserService.selectFiles(map);
			Iterator it = list.iterator();
			while(it.hasNext()){
				Map<String, Object> dataMap = (HashMap<String, Object>) it.next();
				String fileSNM = dataMap.get("FILE_SNM").toString();
				String filePath = defaultUrl + "/" + fileSNM;
				File f = new File(filePath);
				f.delete();
			}
			
			//File Data Delete
			editorBrowserService.removeFiles(map);
		}catch(Exception e){
		}//try~catch
		
        
		return "";
	}
	

	@RequestMapping(value="/editor/loadFiles.do", produces = "application/text; charset=utf8")
	public @ResponseBody String loadFiles(HttpServletRequest request) 
			throws Exception{

		String js = "";
		HashMap<String, Object> map = new HashMap<String, Object>();
		String noticeSq = request.getParameter("NOTICE_SQ");
		map.put("NOTICE_SQ", noticeSq);
		 
		try{
			//File Load
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			List list = (List)editorBrowserService.selectFiles(map);
			if(list.size() > 0){ 
				Iterator it = list.iterator();  
				
				js = "[";
				while(it.hasNext()){
					Map<String, Object> dataMap = (HashMap<String, Object>)it.next();
					String dataName = dataMap.get("FILE_SQ").toString() + "," +  dataMap.get("FILE_SNM").toString() 
									  + "," + dataMap.get("FILE_ONM");
					
					resultMap.put("FILE_SQ", dataMap.get("FILE_SQ")); 
					resultMap.put("size", dataMap.get("FILE_SIZE"));
					resultMap.put("doc", dataMap.get("FILE_EX"));
					resultMap.put("name", dataName);
					
					js += JSONObject.toJSONString(resultMap)+",";
				}//while 
				
				js = js.substring(0, js.length()-1) + "]";
			}
		}catch(Exception e){
			
		}//try~catch
		
        
		return js;
	}
	
	@RequestMapping(value = "/editor/downloadFiles.do")
	public String downloadFiles() throws Exception {
		return "/urtown/download";
	}
	
	
	
	
	//public @ResponseBody JSONPObject editorImgRead(HttpServletRequest request, @RequestParam("callback") String c, @RequestParam Map<String,Object> paramMap) throws Exception {
	//String json = new Gson().toJson(entries);
	//System.out.println(json);
	//return new JSONObject(json);
	//return json;
}

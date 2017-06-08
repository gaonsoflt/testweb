package egovframework.dgms.web;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Hex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.Globals;
import egovframework.com.login.service.CmmLoginUser;
import egovframework.com.user.service.UserInfoVo;
import egovframework.dgms.service.DataEcgService;
import egovframework.dgms.util.AnalyECGdata;

@Controller
public class DataEcgController {
	Logger logger = LoggerFactory.getLogger(DataEcgController.class.getName());
	    
	@Resource(name = "dataEcgService")
	private DataEcgService dataEcgService;
	
	@RequestMapping(value = "/dgms/dataEcg.do")
	public String dgmsDataEcg(Model model, ModelMap modelmap,@RequestParam Map<String,Object> paramMap) throws Exception {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();

        String threemonthago=formatter.format(monthago);
        modelmap.put("todate", today);
        modelmap.put("fromdate", threemonthago);
	    
        if (paramMap.get("mdate")!=null && paramMap.get("mdate")!="")
		{
			modelmap.put("todate", paramMap.get("mdate"));
			modelmap.put("fromdate", paramMap.get("mdate"));
		}
        
		return "dgms/dataEcg";
	}


	
	
	@RequestMapping(value = "/dgms/selectDataEcgDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectDataEcgDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {
	
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	
		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)dataEcgService.selectDataEcgInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", dataEcgService.selectDataEcgInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	
	/********************************************************
	 * ECG 측정 상세 정보 조회.
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/dgms/selectEcgInfoBySeq.do")
	public @ResponseBody HashMap<String, Object> selectEcgInfoBySeq(@RequestParam Map<String,Object> paramMap) throws Exception {
		HashMap<String, Object> rtnList = (HashMap<String, Object>)dataEcgService.selectEcgInfoBySeq((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		
		return result;
	}
	
	@RequestMapping(value = "/dgms/mngEcgdata.do")
	public String mngEcgdata(Model model, ModelMap modelmap) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();
        
        modelmap.put("today", today);
		return "dgms/mngEcgdata";
	}
	
	@RequestMapping(value = "/dgms/myEcgdata.do")
	public String myEcgdata(Model model, ModelMap modelmap) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();
        
        modelmap.put("today", today);
		return "dgms/myEcgdata";
	}
	
	/********************************************************
	 * ECG 파일 등록.
	 * @param paramMap 
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/dgms/uploadecgfile.do", headers = "content-type=multipart/*", method = RequestMethod.POST)
	public @ResponseBody String uploadecgfile(@RequestParam(value = "file") MultipartFile multipartFile,@RequestParam Map<String,Object> paramMap,HttpSession session) throws Exception {
		String retVal="0";
		String path="D:\\Sample.dat";
		String uploadpath = "";
		String uploadurl = "";
		
		/*if (request.getParameter("filegubun").equals("public"))
		{
			uploadpath =env.getProperty("publicfile.path");
			uploadurl =env.getProperty("publicfile.url");
		}
		else
		{
			uploadpath =env.getProperty("privatefile.path");
			uploadurl =env.getProperty("privatefile.url");
		}*/
		
		//파일정보
        String sFileInfo = "";
        String realFileNm = "";
        long filesize=0;
        //파일명을 받는다 - 일반 원본파일명
        String filename ="";
        //파일 확장자
        String filename_ext = "";
        //파일 기본경로
        //String dftFilePath = request.getSession().getServletContext().getRealPath("/");
        //파일 기본경로 _ 상세경로
        //String filePath = dftFilePath + "resource" + File.separator + "photo_upload" + File.separator;
        
		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			MultipartFile file = multipartFile;
			
			filename = file.getOriginalFilename();
			filesize = file.getSize();
			filename_ext = filename.substring(filename.lastIndexOf(".")+1);
			//확장자를소문자로 변경
	        filename_ext = filename_ext.toLowerCase();
	        
			inputStream = file.getInputStream();
			
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	        String today= formatter.format(new java.util.Date());
	        
	        realFileNm = filename;
	        if (filename_ext.toLowerCase().equals("ecg"))
	        {
	        	uploadpath = Globals.Filepath_ecgdir;
	        }
	        else if (filename_ext.toLowerCase().equals("dat"))
	        {
	        	uploadpath = Globals.Filepath_actecgdir;
	        }
	        String rlFileNm = uploadpath + realFileNm;
	         
			File newFile = new File(rlFileNm);
			if (!newFile.exists()) {
				newFile.createNewFile();
			}
			outputStream = new FileOutputStream(newFile);
			int read = 0;
			byte[] bytes = new byte[1024];

			while ((read = inputStream.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}
			
			if(inputStream != null) {
				inputStream.close();
	         }
			outputStream.flush();
			outputStream.close();
			
			//String path="E:\\M120160630195849.ECG";
			//insertTB_ECG_MEASURE_IF(file,"01031328289",session);
			//insertTB_ACT_ECG_MEASURE_IF(file,paramMap.get("user_id").toString(),session);
			if (filename_ext.toLowerCase().equals("ecg"))
	        {
				insertTB_ECG_MEASURE_IF(newFile,paramMap.get("USER_ID").toString(),paramMap.get("CHECKUP_DT").toString(),session);
	        }
	        else if (filename_ext.toLowerCase().equals("dat"))
	        {
	        	insertTB_ACT_ECG_MEASURE_IF(newFile,paramMap.get("USER_ID").toString(),paramMap.get("CHECKUP_DT").toString(),session);
	        }
			
			retVal="1";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	private void insertTB_ECG_MEASURE_IF(File file,String clientid,String chk_dt,HttpSession session) throws Exception {
		//writeErrorPrint("file.isFile():"+file.isFile()+"\r\n");
		if (file.isFile()) {
			String filepath =file.getAbsolutePath();
			AnalyECGdata aECGdata = AnalyECGdata.CreateECGdata(filepath);

			BufferedInputStream b = null;
	    	InputStream i = null;

	    	try {
				i = new FileInputStream(filepath);//M120160630195849.ECG M120160630195714.ECG M420160714165913.HRV
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

	    	// input stream => buffed input stream 
	        b = new BufferedInputStream(i);

	        int numByte = b.available();
	        byte[] buf = new byte[numByte];
	        b.read(buf, 0, numByte);
    		double start_pos=16;
    		double Xais = (start_pos-16)/4;

    		StringBuffer strBuf = new StringBuffer();
    	     for(int j=0; j < ((numByte-16)/4); j++)  //((numByte-16)/4)
    	     {
	    	      int value01 = (byte)buf[(int) (start_pos+j*4)];
	    	      int value02 = (byte)buf[(int) (start_pos+j*4+1)] << 8;
	    	      if(value01 < 0)
	    	      {
	    	       value01 = 256 + value01;
	    	      }
	    	      if(value02 < 0)
	    	      {
	    	       value02 = 65536 + value02;
	    	      }
	    	      int value0 = value01+value02;
	    	  
	    	      int value11 = (byte)buf[(int) (start_pos+j*4+2)];
	    	      int value12 = (byte)buf[(int) (start_pos+j*4+3)] << 8;
	    	      if(value11 < 0)
	    	      {
	    	       value11 = 256 + value11;
	    	      }
	    	      if(value12 < 0)
	    	      {
	    	       value12 = 65536 + value12;
	    	      }
	    	      int value1 = value11+value12;       
	    	      //mCurrentSeries0.add(0.01*Xais++ , (double)(value0+value1)/600);
	    	      //System.out.println();
	    	      if(j==((numByte-16)/4)-1)
	    	      {
	    	    	  strBuf.append(String.valueOf((Double.parseDouble(String.format("%.5f", (double)(value0+value1)/6000)))));
	    	      }
	    	      else
	    	      {
	    	    	  strBuf.append(String.valueOf((Double.parseDouble(String.format("%.5f", (double)(value0+value1)/6000)))+","));
	    	      }
	    	      
    	     }
    	     String strval = strBuf.toString();    
			/*analysisText1.setText(aECGdata.MinimumHR + " Minimum at "+aECGdata.MinimumHRTime);
			analysisText2.setText(aECGdata.AverageHR + " Average");
			analysisText3.setText(aECGdata.MaximumHR + " Maximum at "+aECGdata.MaximumHRTime);
			analysisText4.setText(aECGdata.Tachycardia + " Beats in tachycardia (>100 bpm), "+aECGdata.percentTachycardia + "% total" );
			analysisText5.setText(aECGdata.Bradycardia + " Beats in bradycardia (<50 bpm), "+aECGdata.percentBradycardia +"% total");
			analysisText6.setText(aECGdata.SecondMaximumRR + " mSecs Max R-R at "+aECGdata.SecondMaximumRRTime);*/

    	    CmmLoginUser userDetails = (CmmLoginUser)session.getAttribute("userLoginInfo");
    	     
			HashMap<String, Object> hash = new HashMap<String, Object>();
			hash.put("USER_ID", clientid);
			hash.put("CRE_USR", userDetails.getUsername());
			hash.put("AVG_HEART", aECGdata.AverageHR);                              
			hash.put("ECG_RAW_DATA", aECGdata.fname);
			hash.put("FREQ_CNT", aECGdata.Tachycardia);
			hash.put("INFREQ_CNT", aECGdata.Bradycardia);
			hash.put("MAX_HEART", aECGdata.MaximumHR);
			hash.put("MAX_RRS", aECGdata.SecondMaximumRR);
			hash.put("MEASURE_DT", aECGdata.startTime);//.replaceAll(".", "-")
			hash.put("MIN_HEART", aECGdata.MinimumHR);
			hash.put("RECORD_PERIOD", 0);
			hash.put("UNUSUAL_CNT", aECGdata.ArrhymiasCount);
			hash.put("ECG_RAW_CLOB", strval);
			
			dataEcgService.insertEcgData(hash);
		}		
	}
	
	private void insertTB_ACT_ECG_MEASURE_IF(File file,String clientid,String chk_dt,HttpSession session) throws Exception {
		//writeErrorPrint("file.isFile():"+file.isFile()+"\r\n");
		if (file.isFile()) {
			String filepath =file.getAbsolutePath();
			
			BufferedInputStream b = null;
	    	InputStream i = null;

	    	try {
				i = new FileInputStream(filepath);//M120160630195849.ECG M120160630195714.ECG M420160714165913.HRV
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

	    	// input stream => buffed input stream 
	        b = new BufferedInputStream(i);

	        int numByte = b.available();
	        byte[] buf = new byte[numByte];
	        b.read(buf, 0, numByte);
	        
	        StringBuffer strBufECG = new StringBuffer();		// 총 ECG 데이터
	        int event_result = 0;
	        int pvc_result = 0;
	        int brady_result = 0;		//빈맥
	        int tarchy_result = 0;	//서맥
	        int leadoff_result = 0;	//서맥
	        int rpoint_result = 0;
	        int battery_result = 0;
	        
	        int min_heart_result = 0;	//최소 심박
	        int max_heart_result = 0;	//최대 심박
	        double avg_heart_result = 0;	//평균 심박
	        
	        int min_r_r_interval = 0;	//최소 R-R
	        int max_r_r_interval = 0;	//최대 R-R
	        double avg_r_r_interval = 0;	//평균 R-R
	        
	        String date_result = "";
	        
	        int dataCount = numByte/13;
	        for(int k = 0; k < dataCount; ++k) {
	        	byte[] byteData = new byte[13];
	        	System.arraycopy( buf, (k*13), byteData, 0, 13 );

		        // 날짜
		        int year = byteData[2] >>2;
		        int month = ((byteData[2] <<6)>>4) | (byteData[3]>>6);
		        int day = (byteData[3] << 2)>>3;
		        int pm_am = byteData[3] & (0x01);
		        int hour = byteData[4] << 4;
		        int minute = ((byteData[4] & 0x0f)<<2) | (byteData[5]>>6);
		        int second = (byteData[5] & 0x3f);
	
		        // 빈맥/서맥 데이터
		        int event = ((byteData[6]&0xff) & 0x80) >> 7;
		        int pvc = ((byteData[6]&0xff) & 0x40) >> 6;
		    	int brady = ((byteData[6]&0xff) & 0x20) >> 5;
		    	int tarchy = ((byteData[6]&0xff) & 0x10) >> 4;
		    	int LeadOff = ((byteData[6]&0xff) & 0x0c) >> 2;
		    	int r_point = ((byteData[6]&0xff) & 0x02) >> 1;

		    	// 배터리/심박
		    	int battery = (((byteData[7]&0xff)<<6)>>>1) | ((byteData[8]&0xff)>>>3);
		    	int heart_rate = ((byteData[8]&0xff)&0x07)+(byteData[9]&0xff);
		    	
		    	int ecg = (((byteData[10]&0xff)<<24)|((byteData[11]&0xff)<<16)|((byteData[12]&0xff)<<8))>>>8;
		    	
		    	event_result += event;
		    	pvc_result += pvc;
		    	brady_result += brady;
		    	tarchy_result += tarchy;
		    	leadoff_result += LeadOff;
		    	rpoint_result += r_point;
		    	
		    	if(r_point == 0) {
		    		// R Point가 0일 때는 심박수 값이 된다.
		    		if(min_heart_result == 0)
		    			min_heart_result = heart_rate;
		    		else
		    			min_heart_result = Math.min(min_heart_result, heart_rate);
		    		max_heart_result = Math.max(max_heart_result, heart_rate);
		    		
		    		if(avg_heart_result == 0)
		    			avg_heart_result = heart_rate;
		    		else 
		    			avg_heart_result = (avg_heart_result + heart_rate)/2;
		    	} else {
		    		// R Point가 1일 때는 R-R Interval 값이 된다.
		    		if(min_r_r_interval == 0)
		    			min_r_r_interval = heart_rate;
		    		else
		    			min_r_r_interval = Math.min(min_r_r_interval, heart_rate);
		    		max_r_r_interval = Math.max(max_r_r_interval, heart_rate);
		    		
		    		if(avg_r_r_interval == 0)
		    			avg_r_r_interval = heart_rate;
		    		else 
		    			avg_r_r_interval = (avg_r_r_interval + heart_rate)/2;
		    	}
		    	
		    	if(k ==0) {
		    		battery_result = battery;
		    		date_result = (year+"."+month+"."+day +" "+hour+":"+minute+":"+second);
		    	}
		    	
		    	if (date_result.startsWith("0"))
		    	{
		    		date_result = chk_dt;
		    	}
		    	strBufECG.append(String.format("%.4f,", ((float)ecg/(float)1000000)));
	        }
	        
	        
	        CmmLoginUser userDetails = (CmmLoginUser)session.getAttribute("userLoginInfo");
   	     
			HashMap<String, Object> hash = new HashMap<String, Object>();
			hash.put("USER_ID", clientid);						//유저아이디
			hash.put("MEASURE_DT", date_result);			//측정일시
			hash.put("EVENT", String.valueOf(event_result>0 ? 1:0));				//event
			hash.put("FREQ_CNT", brady_result);			//빈맥횟수
			hash.put("INFREQ_CNT", tarchy_result);		//서맥횟수
			hash.put("LEADOFF", leadoff_result);			//Lead_off
			hash.put("RPOINT", rpoint_result);				//R-Point
			hash.put("BATTERY", battery_result);			//배터리
			hash.put("MAXHEART_RATE", max_heart_result);		//최대 심박수
			hash.put("MINHEART_RATE", min_heart_result);			//최소 심박수
			hash.put("AVGHEART_RATE", (int)avg_heart_result);	//평균 심박수
			hash.put("MAXRRINTERVAL", max_r_r_interval);			//최대 R-R Interval
			hash.put("MINRRINTERVAL", min_r_r_interval);			//최소 R-R Interval
			hash.put("AVGRRINTERVAL", (int)avg_r_r_interval);	//평균 R-R Interval
			hash.put("ECG_RAW_DATA", file.getName());				//파일이름
			hash.put("CRE_USR", userDetails.getUsername());		//생성자
			hash.put("ECG_RAW_CLOB", strBufECG.toString());		//심전도 RAW 데이터
			hash.put("PVC_CNT", pvc_result);				// pvc 

			dataEcgService.insertActEcgData(hash);
		}
	}
	
	@RequestMapping(value = "/dgms/dataActEcg.do")
	public String dgmsDataActEcg(Model model, ModelMap modelmap,@RequestParam Map<String,Object> paramMap) throws Exception {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();

        String threemonthago=formatter.format(monthago);
        modelmap.put("todate", today);
        modelmap.put("fromdate", threemonthago);
	    
        if (paramMap.get("mdate")!=null && paramMap.get("mdate")!="")
		{
			modelmap.put("todate", paramMap.get("mdate"));
			modelmap.put("fromdate", paramMap.get("mdate"));
		}
        
		return "dgms/dataActEcg";
	}


	
	
	@RequestMapping(value = "/dgms/selectDataActEcgDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectDataActEcgDetailInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {
	
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	
		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)dataEcgService.selectDataActEcgInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", dataEcgService.selectDataActEcgInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	
	/********************************************************
	 * ECG 측정 상세 정보 조회.
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/dgms/selectActEcgInfoBySeq.do")
	public @ResponseBody HashMap<String, Object> selectActEcgInfoBySeq(@RequestParam Map<String,Object> paramMap) throws Exception {
		HashMap<String, Object> rtnList = (HashMap<String, Object>)dataEcgService.selectActEcgInfoBySeq((HashMap<String, Object>)paramMap);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);
		
		return result;
	}
	
	@RequestMapping(value = "/dgms/mngdataEcg.do")
	public String dgmsmngDataEcg(Model model, ModelMap modelmap,@RequestParam Map<String,Object> paramMap) throws Exception {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();

        String threemonthago=formatter.format(monthago);
        modelmap.put("todate", today);
        modelmap.put("fromdate", threemonthago);
	    
        if (paramMap.get("mdate")!=null && paramMap.get("mdate")!="")
		{
			modelmap.put("todate", paramMap.get("mdate"));
			modelmap.put("fromdate", paramMap.get("mdate"));
		}
        
		return "dgms/mngdataEcg";
	}

	@RequestMapping(value = "/dgms/mngdataActEcg.do")
	public String dgmsmngDataActEcg(Model model, ModelMap modelmap,@RequestParam Map<String,Object> paramMap) throws Exception {
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String today= formatter.format(new java.util.Date());
	    
        Calendar cal = 
        		Calendar.getInstance(new SimpleTimeZone(0x1ee6280, "KST"));
        cal.add(Calendar.MONTH ,-1); // 3달전 날짜 가져오기

        java.util.Date monthago = cal.getTime();

        String threemonthago=formatter.format(monthago);
        modelmap.put("todate", today);
        modelmap.put("fromdate", threemonthago);
	    
        if (paramMap.get("mdate")!=null && paramMap.get("mdate")!="")
		{
			modelmap.put("todate", paramMap.get("mdate"));
			modelmap.put("fromdate", paramMap.get("mdate"));
		}
        
		return "dgms/mngdataActEcg";
	}
	/*
	
	@RequestMapping(value = "/dgms/insertDataEcgInfoJsonp.do")
	public @ResponseBody JSONPObject insertDataEcgInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertDataEcgInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
	
		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 
	
		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataEcgService.insertDataEcgInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	@RequestMapping(value = "/dgms/updateDataEcgInfoJsonp.do")
	public @ResponseBody JSONPObject updateDataEcgInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateDataEcgInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
	
		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 
	
		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataEcgService.updateDataEcgInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	
	
	@RequestMapping(value = "/dgms/deleteDataEcgInfoJsonp.do")
	public @ResponseBody JSONPObject deleteDataEcgInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteDataEcgInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();
	
		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 
	
		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				dataEcgService.deleteDataEcgInfo(paramMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
*/

}
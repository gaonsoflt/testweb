package egovframework.dgms.web;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.Globals;
import egovframework.dgms.service.MyPrescriptService;

@Controller("myPrescriptController")
public class myPrescriptController {
Logger logger = LoggerFactory.getLogger(myPrescriptController.class.getName());
	
	@Resource(name = "myPrescriptService")
	private MyPrescriptService myPrescriptService;


	/**
	 * 처방전 정보를 조회함
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/selectMyPrescriptInfoJsonp.do")
	public @ResponseBody JSONPObject selectMyPrescriptInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params){
		HashMap<String, Object> paramMap = new HashMap<String, Object> ();
		
		logger.debug("Params:" + params);
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		logger.debug("ParamMap:" + paramMap);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)myPrescriptService.selectMyPrescriptInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		
		return new JSONPObject(c, rtnMap);
	}
	
	/**
	 * 처방전 정보를 생성함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/insertMyPrescriptInfoJsonp.do")
	public @ResponseBody JSONPObject insertMyPrescriptInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				myPrescriptService.insertMyPrescriptInfo(paramMap);
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
	
	/**
	 * 처방전 정보를 삭제함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/deleteMyPrescriptInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMyPrescriptInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				myPrescriptService.deleteMyPrescriptInfo(paramMap);
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
	
	/**
	 * 처방전 정보를 갱신함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/updateMyPrescriptInfoJsonp.do")
	public @ResponseBody JSONPObject updateMyPrescriptInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				myPrescriptService.updateMyPrescriptInfo(paramMap);
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
	
	
	
	
	
	
	/**
	 * 처방약 정보를 조회함
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/selectMyPrescriptMedcInfoJsonp.do")
	public @ResponseBody JSONPObject selectMyPrescriptMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params){
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		logger.debug("paramMap:"+paramMap); 
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)myPrescriptService.selectMyPrescriptMedcInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", myPrescriptService.selectMyPrescriptMedcInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	
	/**
	 * 처방약 정보를 생성함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/insertMyPrescriptMedcInfoJsonp.do")
	public @ResponseBody JSONPObject insertMyPrescriptMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/insertMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				if (i==0)
				{
					rtnMap=paramMap;
				}
				myPrescriptService.insertMyPrescriptMedcInfo(paramMap);
			}
			SendDosageData(rtnMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	/**
	 * 처방약 정보를 삭제함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/deleteMyPrescriptMedcInfoJsonp.do")
	public @ResponseBody JSONPObject deleteMyPrescriptMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				myPrescriptService.deleteMyPrescriptMedcInfo(paramMap);
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
	
	/**
	 * 처방약 정보를 갱신함
	 * @param c
	 * @param model
	 * @return params
	 * @throws 
	 */
	@RequestMapping(value = "/dgms/updateMyPrescriptMedcInfoJsonp.do")
	public @ResponseBody JSONPObject updateMyPrescriptMedcInfoJsonp(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMyPrescriptInfoJsonp.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				if (i==0)
				{
					rtnMap=paramMap;
				}
				myPrescriptService.updateMyPrescriptMedcInfo(paramMap);
			}
			
			SendDosageData(rtnMap);	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			HashMap<String, Object> rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c, models);
	}
	
	public String SendDosageData(HashMap<String, Object> rtnMap) throws Exception
	{
		String retVal="N";
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)myPrescriptService.selectdosageData((HashMap<String, Object>)rtnMap);
		String drugboxip = Globals.MEDC_ServerIP;
		int drugboxport =  Integer.parseInt(Globals.MEDC_ServerPort);
		if (rtnList.get(0) !=null)
		{
		    Socket cSocket = null;
		    cSocket = new Socket(drugboxip,drugboxport);
		    
	    	String retACK="";//01#393939#00000001#20160701#20160930
	    	try
	    	{
	    		// 소켓의 출력스트림을 얻는다.
	            OutputStream out = cSocket.getOutputStream(); 
	            DataOutputStream dos = new DataOutputStream(out); // 기본형 단위로 처리하는 보조스트림
	            
	            /*○ 전송 패킷
				START CODE#처방ID#PID#시작일(8자리)#종료일(8자리)
				Ex) 01#393939#00000001#20160701#20160930
				ACK 패킷
				START CODE#처방ID#SUCCESS/FAIL
				Ex) 01#393939#00 (수신 성공)
				   01##99(수신 실패)
				*/
					            
	            //DB 에서 신규로 등록된 처방정보 정보 가져와서 전송
	            retACK = "01#"+ rtnList.get(0).get("PRSC_SEQ").toString()+"#"+rtnList.get(0).get("EQUIPMENT_ID").toString()+"#"+rtnList.get(0).get("PRSC_STDT").toString()+"#"+rtnList.get(0).get("PRSC_EDDT").toString();
	            // 원격 소켓(remote socket)에 데이터를 보낸다.
	            //dos.writeUTF(retACK);
	            dos.write(retACK.getBytes());
	            dos.flush();
	            //DB 저장
	        	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	            Calendar c1 = Calendar.getInstance();
	            String strToday = sdf.format(c1.getTime());

	            System.out.println(strToday + " 결과를 전송했습니다.");

	            
	            InputStream is = cSocket.getInputStream();
	            DataInputStream dis = new DataInputStream(is);
	            
	            byte[] buffer = new byte[1024];
				int readBytes = 0;
				String readUTF ="";
				while ( (readBytes = dis.read( buffer )) != -1 ) {
					byte[] tmp = new byte[readBytes];
					System.arraycopy( buffer, 0, tmp, 0, readBytes );
					
					readUTF = new String(tmp);
					
					break;
				}
				
		        String[] tmp = readUTF.split("\\#");
		        
		        String data1="";
		        String data2="";
		        String data3="";
		        
		        if (tmp.length==3)
		        {
		        	data1=tmp[0];
		        	data2=tmp[1];
		        	data3=tmp[2];
		
		        	//DB 저장

		        	System.out.println(strToday + " 결과를 받았습니다.");
		        }
		        
		        // 스트림과 소켓을 달아준다.
	            dos.close();
	            dis.close();
	            cSocket.close();
	            
		        List<HashMap<String, Object>> rtnalarmList = (List<HashMap<String, Object>>)myPrescriptService.selectdosagealarmData((HashMap<String, Object>)rtnMap);
		        if (rtnalarmList !=null && rtnalarmList.size()>0)
				{
		        	/*○ 알람 정보(02)
					전송 패킷
					START CODE#처방ID#알람ID#알람 시작 시간(4자리)#알람 종료 시간(4자리)#메시지#약제코드#투약량(개수) 
						약의 개수가 여러 종류일 수 있기 때문에 약제코드 + 투약량은 종류에 따라 반복됩니다.
					Ex) 02#393939#123#0900#0910#아버지 약드세요!#660700860#2#669501400#3
					(처방 약이 2종류이고 약제코드가 660700860 인 약 2개, 669501400 인 약이 3개인 경우)
					ACK 패킷
					START CODE#처방ID#알람ID#SUCCESS/FAIL
					Ex) 02#393939#123#00(수신 성공)
					   02##99(수신 실패)

					*/
		        	String retACKAlarm = "";//02#393939#123#0900#0910#아버지 약드세요!#660700860#2#669501400#3
		        	String prescriptiondata="";
		        	int MAXDOSAGE_ONCE = Integer.parseInt(rtnalarmList.get(0).get("MAXDOSAGE_ONCE").toString());
		        	String PRSC_SEQ = rtnalarmList.get(0).get("PRSC_SEQ").toString();
		        	String EQUIPMENT_ID = rtnalarmList.get(0).get("EQUIPMENT_ID").toString();
		        	for(int j=0;j<rtnalarmList.size();j++)
		        	{
			            //DB 에서 신규로 등록된 처방정보 정보 가져와서 전송
		        		prescriptiondata = prescriptiondata+"#"+ rtnalarmList.get(j).get("PRSCMEDC_CD").toString()+"#"+rtnalarmList.get(j).get("DOSAGE").toString();
			            
		        	}
		        	
		        	for(int k=0;k<MAXDOSAGE_ONCE;k++)
		        	{
		        		Socket calarmSocket = null;
					    calarmSocket = new Socket(drugboxip,drugboxport);
					    DataOutputStream dosAlarm = null;
					    DataInputStream disAlarm =null;
					    
		        		retACKAlarm = "";
		        		// 소켓의 출력스트림을 얻는다.
			            OutputStream outAlarm = calarmSocket.getOutputStream(); 
			            dosAlarm = new DataOutputStream(outAlarm); // 기본형 단위로 처리하는 보조스트림
			            
		        		if (k==0)
		            	{
		            		retACKAlarm = "02#"+PRSC_SEQ+"#"+EQUIPMENT_ID+"#0700#0800#약 드실 시간입니다!"+prescriptiondata;
		            	}
		        		else if(MAXDOSAGE_ONCE==3 && k==1)
		        		{
		        			retACKAlarm = "02#"+PRSC_SEQ+"#"+EQUIPMENT_ID+"#1200#1300#약 드실 시간입니다!"+prescriptiondata;
		        		}
		        		else if(MAXDOSAGE_ONCE==2 && k==1)
		        		{
		        			retACKAlarm = "02#"+PRSC_SEQ+"#"+EQUIPMENT_ID+"#1900#2000#약 드실 시간입니다!"+prescriptiondata;
		        		}
		        		else if(MAXDOSAGE_ONCE==3 && k==2)
		        		{
		        			retACKAlarm = "02#"+PRSC_SEQ+"#"+EQUIPMENT_ID+"#1900#2000#약 드실 시간입니다!"+prescriptiondata;
		        		}
			        	// 원격 소켓(remote socket)에 데이터를 보낸다.
		        		//retACKAlarm="02#393939#123#0900#0910#아버지 약드세요!#660700860#2#669501400#3";
			            dosAlarm.write(retACKAlarm.getBytes());
			            dosAlarm.flush();
			            
			            InputStream isAlarm = calarmSocket.getInputStream();
			            disAlarm = new DataInputStream(isAlarm);
			            
			            byte[] bufferAlarm = new byte[1024];
						int readAlarmBytes = 0;
						String readUTFAlarm ="";
						while ( (readAlarmBytes = disAlarm.read( bufferAlarm )) != -1 ) {
							byte[] tmpAlarm = new byte[readAlarmBytes];
							System.arraycopy( bufferAlarm, 0, tmpAlarm, 0, readAlarmBytes );
							
							readUTFAlarm = new String(tmpAlarm);
							
							break;
						}
						
				        //String readUTFAlarm = disAlarm.readUTF();  
				        String[] tmpAlarm = readUTFAlarm.split("\\#");
				        
				        String dataAlarm1="";
				        String dataAlarm2="";
				        String dataAlarm3="";
				        String dataAlarm4="";
				        if (tmpAlarm.length==4)
				        {
				        	dataAlarm1=tmpAlarm[0];
				        	dataAlarm2=tmpAlarm[1];
				        	dataAlarm3=tmpAlarm[2];
				        	dataAlarm4=tmpAlarm[3];
				        	//DB 저장

				        	System.out.println(dataAlarm1 + " 결과를 받았습니다.");
				        }			
				        
				        dosAlarm.close();
			            disAlarm.close();
			        	calarmSocket.close();
		        	}
		        	
				}
		        
	    	}
	        catch(Exception e)
	        {
	        	e.printStackTrace();
	        }

		}
		return retVal;
	}
	
	@RequestMapping(value = "/dgms/myPrescript.do")
	public String dgmsMyPrescript(Model model) throws Exception {
		return "dgms/myPrescript";
	}
}
package egovframework.dgms.web;

import java.net.*;
import java.text.*;
import java.util.*;

import javax.annotation.*;

import org.apache.commons.collections.map.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.Gson;
import com.google.gson.JsonArray;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.windowsazure.messaging.service.*;
import egovframework.dgms.service.*;
import egovframework.dgms.util.PwdEncryptor;

@Controller
public class AppInfController {
	Logger logger = LoggerFactory.getLogger(AppInfController.class.getName());
	
	@Resource(name = "appInfService")
	private AppInfService appInfService;
	
	@Resource(name = "dataMedcService")
	private DataMedcService dataMedcService;
	
	@Resource(name = "dataBldService")
	private DataBldService dataBldService;
	
	@Resource(name = "dataEcgService")
	private DataEcgService dataEcgService;
	
	@Resource(name = "mngUserService")
	private MngUserService mngUserService;
	
	@Resource(name = "mngGrpService")
	private MngGrpService mngGrpService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@Resource(name = "mngIntegService")
	private MngIntegService mngIntegService;
	
	@Resource(name = "myPrescriptController")
	private myPrescriptController myprescriptController;
	
	@Autowired
	private AzurePushService azurePushService;


	@RequestMapping(value = "/appinf/selectTLoginUser.do")
	public ModelAndView selectTLoginUser(@RequestParam Map<String,Object> paramMap) throws Exception {
		ModelAndView model = new ModelAndView();

		azurePushService.createRegistration("2229000000", "01049198289","01049198289", "11", "cgkpe9GxXeU:APA91bE29MeXPiGv2cOijHfxNLfdLx9uiC1g5k7_huZx4wBi2IrZ6_K0vb2ycLwxwxyxxUa_mG_4Qrr3elnz-swWsz9Zm3JG5OBiNi2QbC5w06v_oOu87ozi0quHni-VyYuFVh0GT0rf");
		model.setViewName("jsonView");
		return model;
	}
	
	/*
	@RequestMapping(value="/appinf/insertTestUser.do")
	public @ResponseBody String insertTestUser(){
		String str = "true";
		
		// 테스트 유저 추가
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("USER_SEQ", "12");
		paramMap.put("AREA_ID", "2229000000");
		paramMap.put("USER_NM", "가온이웃");
		paramMap.put("MOBILE_NO", "01011112222");
		paramMap.put("USER_ID", "nbh01");
		paramMap.put("LOGIN_PWD", "1111");
		paramMap.put("SEX", "M");
		paramMap.put("BIRTHDAY", "700101");
		paramMap.put("ADDR_CIDO", "");
		paramMap.put("ADDR_CIGUNGU", "");
		paramMap.put("USER_TYPE", "");
		paramMap.put("USE_YN", "1");
		paramMap.put("PATIENT_SEQ", "");
		paramMap.put("AUTH_TYPE", "");
		paramMap.put("CRE_USR", "user");
		paramMap.put("CRE_DT", "");
		paramMap.put("MOD_USR", "user");
		paramMap.put("MOD_DT", "");
		
		HashMap<String, Object> paramGroup = new HashMap<String, Object>();
		paramGroup.put("USER_ID", "01031328289");
		paramGroup.put("GRPMBR_ID", "nbh01");
		paramGroup.put("GRPMBR_NM", "가온이웃");
		paramGroup.put("PAT_RELATION", "100777");
		paramGroup.put("AGE", "50");
		paramGroup.put("MOBILE_NO", "01011112222");
		paramGroup.put("ADDR_CIGUNGU_SEQ", "100795");
		paramGroup.put("APP_RGST_ID", "aaaaaa");
		paramGroup.put("CRE_USR", "admin");
		paramGroup.put("MOD_USR", "admin");
	
		try {
			mngUserService.insertMngUserInfo(paramMap);
			mngGrpService.insertMngGrpInfo(paramGroup);
		} catch (Exception e) {
			e.printStackTrace();
			str = "false";
			return str;
		}
		return str;
	}
	*/

	
	
	/********************************************************
	 * 로그인을 요청한다.
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000", "deviceid":"D001", "regid":"qwertyuiop"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/appLogin.do")
	public @ResponseBody HashMap<String, Object> loginUser(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "";		// 결과 코드
		String notice = "";	// 공지사항
		String userSeq = "";
		String userType = "";
		String errorMsg = "";
		
		try {
			if (paramMap.get("pw")!=null && !paramMap.get("pw").toString().trim().equals(""))
			{
				paramMap.put("pw",PwdEncryptor.getEncrypt(paramMap.get("pw").toString().trim()));
			}
			List rtnList = appInfService.selectUserInfo((HashMap<String, Object>)paramMap);
			
			
			if(rtnList.size() < 1) { code = "010";}
			else if(rtnList.size() > 1) { code = "011";}
			else {
				CaseInsensitiveMap mapUser = (CaseInsensitiveMap)rtnList.get(0);
				// 로그인 성공
				code = "000";
				userSeq = (String)mapUser.get("USER_SEQ");
				userType = (String)mapUser.get("USER_TYPE");
				
				if (mapUser.get("REG_ID")==null)
				{
					appInfService.insertDeviceInfo((HashMap<String, Object>)paramMap);
				}
				else
				{
					appInfService.updateDeviceInfo((HashMap<String, Object>)paramMap);
				}
				
				azurePushService.createRegistration(mapUser.get("area_id").toString(),mapUser.get("user_id").toString(), mapUser.get("mobile_no").toString(), mapUser.get("user_seq").toString(), paramMap.get("regid").toString());
			}
		}catch(Exception e) {
			code = "012";
			errorMsg = "서버와의 연결이 원할하지 않습니다. 장애가 계속 될 경우 관리자에게 문의 해 주시기 바랍니다.";
		}
		
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", errorMsg);
		HashMap<String, Object> resultBody = new HashMap<String, Object>();
		resultBody.put("notice", notice);
		resultBody.put("userSeq", userSeq);
		resultBody.put("userType", userType);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}
	
	
	
	/********************************************************
	 * 메인 대시보드에 보여질 정보 조회.
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/selectMeasureScheduleInfo.do")
	public @ResponseBody HashMap<String, Object> selectMeasureScheduleInfo(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "";
		List<HashMap<String, Object>> rtnList = null;
		try {
			rtnList = (List<HashMap<String, Object>>)appInfService.selectMeasureScheduleInfo((HashMap<String, Object>)paramMap);
			code = "000";
			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put("rtnList", rtnList);
		} catch (Exception e) {
			code = "020";
		}
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", rtnList);
		result.put("header", resultHeader);
		
		return result;
	}
	
	@RequestMapping(value = "/appinf/mobiledaymedc.do")
	public String mobiledaymedc(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobiledaymedc";
	}
	
	@RequestMapping(value = "/appinf/mobiledayecg.do")
	public String mobiledayecg(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobiledayecg";
	}
	
	@RequestMapping(value = "/appinf/mobiledaybld.do")
	public String mobiledaybld(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobiledaybld";
	}
	
	/********************************************************
	 * 해당일자에 측정된 약상자 데이터 조회
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/selectmobiledaymedcData.do")
	public @ResponseBody HashMap<String, Object> selectmobiledaymedcData(@RequestParam Map<String,Object> paramMap) throws Exception {
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)dataMedcService.selectmobiledaymedcData((HashMap<String, Object>)paramMap);

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);

		return result;
	}
	
	/********************************************************
	 * 해당일자에 측정된 심전도 데이터 조회
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/selectmobiledayecgData.do")
	public @ResponseBody HashMap<String, Object> selectmobiledayecgData(@RequestParam Map<String,Object> paramMap) throws Exception {
		String code = "";
		List<HashMap<String, Object>> rtnList = null;
		try {
			rtnList = (List<HashMap<String, Object>>)dataEcgService.selectmobiledayecgData((HashMap<String, Object>)paramMap);
		} catch (Exception e) {
		}

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);

		return result;
	}
	
	/********************************************************
	 * 해당일자에 측정된 혈압기 데이터 조회
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/selectmobiledaybldData.do")
	public @ResponseBody HashMap<String, Object> selectmobiledaybldData(@RequestParam Map<String,Object> paramMap) throws Exception {
		String code = "";
		List<HashMap<String, Object>> rtnList = null;
		try {
			rtnList = (List<HashMap<String, Object>>)dataBldService.selectmobiledaybldData((HashMap<String, Object>)paramMap);
		} catch (Exception e) {
		}

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);

		return result;
	}
	
	/********************************************************
	 * 비상 알림 위치 정보 갱신
	 * @param paramMap post / json type
	 *              {"user_id":"1234", "mobile_no":"01031328289", "gps_lat":"12.345", "gps_lon":"67.890", "cre_usr":"abc"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/setSosPosition.do")
	public @ResponseBody HashMap<String, Object> setSosPosition(@RequestBody Map<String,Object> paramMap) throws Exception {
		
		String code = "000";
		try {
			appInfService.insertGPSInfo((HashMap<String, Object>)paramMap);
			String myName = "";
			List<HashMap<String, Object>> groupMemberList = (List<HashMap<String, Object>>)appInfService.getGroupMemberInfo((HashMap<String, Object>)paramMap);
			for(int i = 0; i < groupMemberList.size(); ++i) {
				HashMap<String, Object> memberInfo = groupMemberList.get(i);
				if(((String)memberInfo.get("USER_ID")).equalsIgnoreCase((String)paramMap.get("user_id"))) {
					myName = (String)memberInfo.get("USER_NM");
					break;
				}
			}
			
			SimpleDateFormat df = new SimpleDateFormat("MM월 dd일 hh시");
			String strDate = df.format(new Date());
			
			String title = "[농촌 부모 안전 돌보미]";
			String message = myName+"님께서 "+strDate+" 응급상황 발생하였습니다. 알림을 누르면 요청하신 위치를 확인하실 수 있습니다.";
			
			// 가족/이웃에게 푸시를 전송한다.
			
			for(int i = 0; i < groupMemberList.size(); ++i) {
				HashMap<String, Object> memberInfo = groupMemberList.get(i);
				//나에게는 푸시를 보내지 않는다.
				if(((String)memberInfo.get("USER_ID")).equalsIgnoreCase((String)paramMap.get("user_id"))) {
					continue;
				}
				
				HashMap<String, Object> paramPush = new HashMap<String, Object>();
				paramPush.put("sys_gubun", "gps");
				paramPush.put("mobile_no", memberInfo.get("MOBILE_NO"));
				paramPush.put("user_seq", memberInfo.get("USER_SEQ"));
				paramPush.put("title", title);
				paramPush.put("cont", message);
				paramPush.put("link", "gps");
				appInfService.insertMobilePushInfo((HashMap<String, Object>)paramPush);
			}
			
		}catch (Exception e) {
			code = "001";
		}
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");
		
		HashMap<String, Object> resultBody = new HashMap<String, Object>();

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}
	
	/********************************************************
	 * 비상 알림 위치 정보 조회
	 * @param paramMap post / json type
	 *              {"user_id":"1234"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/getSosPosition.do")
	public @ResponseBody HashMap<String, Object> getSosPosition(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "000";
		HashMap<String, Object> resultBody = new HashMap<String, Object>();
		
		try {
			List rtnList = (List<HashMap<String, Object>>)appInfService.selectLastGPSInfo((HashMap<String, Object>)paramMap);
			
			if(rtnList.size() == 0) {
				code = "030";
			} else {
				//CaseInsensitiveMap mapPosition = (CaseInsensitiveMap)rtnList.get(0);
				HashMap<String, Object> mapPosition = (HashMap<String, Object>)rtnList.get(0);
				resultBody.put("lat", (String)mapPosition.get("GPS_LAT"));
				resultBody.put("lon", (String)mapPosition.get("GPS_LON"));
				resultBody.put("mobile_no", (String)mapPosition.get("MOBILE_NO"));
				resultBody.put("date", (String)mapPosition.get("SCRE_DT"));
			}
			
		}catch (Exception e) {
			code = "001";
		}
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}
	
	/********************************************************
	 * 환자 그룹 정보 조회
	 * @param paramMap post / json type
	 *              {"id":"1234"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/getGroupInfo.do")
	public @ResponseBody HashMap<String, Object> getGroupInfo(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "000";
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");
		
		HashMap<String, Object> resultBody = new HashMap<String, Object>();
//		resultBody.put("lat", "35.236121");
//		resultBody.put("lon", "128.57498");

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}
	
	/********************************************************
	 * 환자 그룹 무전 초대
	 * @param paramMap post / json type
	 *              {"id":"1234"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/inviteGroupWalkieTalkie.do")
	public @ResponseBody HashMap<String, Object> inviteGroupWalkieTalkie(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "000";
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");
		
		HashMap<String, Object> resultBody = new HashMap<String, Object>();
//		resultBody.put("lat", "35.236121");
//		resultBody.put("lon", "128.57498");

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}
	
	/********************************************************
	 * 처방 약품 코드 정보 조회
	 * @param paramMap post / json type
	 *              {"drug_name":"코디오반정"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/getDrugInfo.do")
	public @ResponseBody HashMap<String, Object> getDrugInfo(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "000";
		
		HashMap<String, Object> resultBody = new HashMap<String, Object>();
		
		try {
			// 의약품 정보를 검색한다.
			for(int i = 0; i < paramMap.size(); ++i) {
				HashMap<String, Object> paramDrug = new HashMap<String, Object>();
				String drugname = "%"+URLDecoder.decode((String)paramMap.get(String.valueOf(i+1)), "UTF-8")+"%";
				paramDrug.put("drug_name", drugname);
				List rtnDrug = (List<HashMap<String, Object>>)appInfService.selectDrugInfo((HashMap<String, Object>)paramDrug);
				
				String drugCode = "";
				if(rtnDrug.size() != 0)
					drugCode = (String)((HashMap<String, Object>)rtnDrug.get(0)).get("DRUG_CD");
				resultBody.put(String.valueOf(i+1), drugCode);
			}
		}catch (Exception e) {
			code = "001";
		}
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);

		return result;
	}
	
	/********************************************************
	 * 처방전 정보 등록
	 * @param paramMap post / json type
	 *              {"id":"1234"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/setPrescriptionInfo.do")
	public @ResponseBody HashMap<String, Object> setPrescriptionInfo(@RequestBody Map<String,Object> paramMap) throws Exception {
		String code = "000";
		
		try {
			// 처방 정보를 추가한다.
			appInfService.insertMyPrescriptInfo((HashMap<String, Object>)paramMap);
			List rtnPrescript = (List<HashMap<String, Object>>)appInfService.selectMyPrescriptInfo((HashMap<String, Object>)paramMap);
			
			// 저장 된 처방 정보 SEQ를 얻어온다.
			if(rtnPrescript.size() > 0) {
				HashMap<String, Object> prescriptionInfo = (HashMap<String, Object>)rtnPrescript.get(0);
				String PRSC_SEQ = (String)prescriptionInfo.get("PRSC_SEQ");
				
				// 처방 약품 정보를 추가한다.
				List<HashMap<String, Object>> listMedc = (List<HashMap<String, Object>>)paramMap.get("medc");
				for(int i = 0; i < listMedc.size(); ++i) {
					HashMap<String, Object> medcInfo = listMedc.get(i);
					String medcName = URLDecoder.decode((String)medcInfo.get("name"), "UTF-8");
					
					HashMap<String, Object> paramMedc = new HashMap<String, Object>();
					paramMedc.put("PRSC_SEQ", PRSC_SEQ);
					paramMedc.put("PRSCMEDC_CD", (String)medcInfo.get("code"));
					paramMedc.put("PRSCMEDC_NM", medcName);
					paramMedc.put("DOSAGE", (String)medcInfo.get("quantity"));						//1회투여량
					paramMedc.put("DOSAGE_ONCE", (String)medcInfo.get("count"));					//1일투여횟수
					paramMedc.put("DOSAGE_ONCE_DAY", (String)medcInfo.get("days"));			//총투약일수
					paramMedc.put("USAGE", "1");																	//용법
					paramMedc.put("CRE_USR", (String)paramMap.get("user_id"));						//등록자
					
					appInfService.insertMyPrescriptMedcInfo((HashMap<String, Object>)paramMedc);
				}
				
				//
				myprescriptController.SendDosageData((HashMap<String, Object>)paramMap);
			} else {
				code = "001";
			}
		}catch (Exception e) {
			code = "001";
		}
		
		HashMap<String, Object> resultHeader = new HashMap<String, Object>();
		resultHeader.put("code", code);
		resultHeader.put("msg", "");
		
		HashMap<String, Object> resultBody = new HashMap<String, Object>();

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("body", resultBody);
		result.put("header", resultHeader);
		
		return result;
	}

	/********************************************************
	 * 문진표 정보를 들고온다
	 * @param model, paramMap 
	 *              {user_id:admin}
	 * @return String
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/getMedcInquiry.do")
	public String getMedcInquiry(ModelMap model, @RequestParam Map<String,Object> paramMap) throws Exception {
		String c = "";
		List<HashMap<String, Object>> list = appInfService.selectMedcInquiryAnswer(paramMap);
		String count = (list.size() < 1 ? "0" : ((Map)list.get(0)).get("CNT").toString());
		
		model.put("count", count); 
		model.put("list", list);
		model.put("user_id", paramMap.get("user_id")); 
		
		return "dgms/mobilemedcexam";
	}

	/********************************************************
	 * 문진표 정보를 작성한다
	 * @param model, paramMap  
	 * @return HashMap<String, Object>
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/setMedcInquiry.do")
	public @ResponseBody HashMap<String, Object> setMedcInquiry(ModelMap model, @RequestParam Map<String,Object> paramMap) throws Exception {  
		String js = paramMap.get("list").toString(); 
		
		JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(js);
        
        String mAnswer = jsonObject.get("mAnswer").toString().replace("{", "").replace("}", ""); 
        String InquiryName = jsonObject.get("InquiryName").toString(); 
        String userId = jsonObject.get("userId").toString(); 
        JSONArray slideContent = (JSONArray) jsonObject.get("sAnswer");
        Iterator i = slideContent.iterator();
        //mAnswer insert
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("SEQ_NM", "SEQ_TB_INQUIRY_MANSWER");
        String SEQ_TB_INQUIRY_MANSWER = commonService.getSequence(map);
        
        map.put("MANSWER_SEQ", SEQ_TB_INQUIRY_MANSWER);
        map.put("INQUIRY_NAME", InquiryName);
        map.put("MAIN_ANSWER", mAnswer);
        map.put("CRE_USR", userId);			//수정할 것
        
        //mainAnswer insert
        appInfService.insertMedcInquiryManswer(map);
        
        while(i.hasNext()){
        	JSONObject slide = (JSONObject)i.next();
        	if(slide.get("value") == null) continue;
        	String index = slide.get("index").toString();
        	String value=slide.get("value").toString();
        	
        	map.put("MQUESTION_NUMBER", index);
        	map.put("SUB_ANSWER", value);
        	
        	//sAnswer insert
            appInfService.insertMedcInquirySanswer(map); 
        }

		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("result", "complete"); 
		
		return result;
	}

	/********************************************************
	 * 문진표 정보를 수정한다
	 * @param model, paramMap  
	 * @return HashMap<String, Object>
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/updateMedcInquiry.do")
	public @ResponseBody HashMap<String, Object> updateMedcInquiry(ModelMap model, @RequestParam Map<String,Object> paramMap) throws Exception {  
		String js = paramMap.get("list").toString(); 
		
		JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(js);
        
        String mAnswer = jsonObject.get("mAnswer").toString().replace("{", "").replace("}", ""); 
        String InquiryName = jsonObject.get("InquiryName").toString(); 
        String[] numberList = jsonObject.get("SAnswerIndex").toString().replace("[", "").replace("]", "").split(","); 
        String userId = jsonObject.get("userId").toString(); 
        JSONArray slideContent = (JSONArray) jsonObject.get("sAnswer");
        Iterator i = slideContent.iterator();
        //mAnswer insert
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("SEQ_NM", "SEQ_TB_INQUIRY_MANSWER");
        String SEQ_TB_INQUIRY_MANSWER = commonService.getSequence(map);
        
        map.put("MANSWER_SEQ", jsonObject.get("ManswerSEQ").toString());
        map.put("INQUIRY_NAME", InquiryName);
        map.put("MAIN_ANSWER", mAnswer);
        map.put("CRE_USR", userId);			//수정할 것
        
        //mainAnswer insert
        appInfService.updateMedcInquiryManswer(map);
        
        
        while(i.hasNext()){
        	JSONObject slide = (JSONObject)i.next();
        	
        	if(slide.get("value") == null) continue;
        	
        	String index = slide.get("index").toString();
        	String value=slide.get("value").toString();
        	int aindex = Integer.parseInt(index)-1;
        	
        	map.put("MQUESTION_NUMBER", index);
        	map.put("SUB_ANSWER", value);
        	
        	//sAnswer insert
        	if("-1".equals(numberList[aindex])){
                appInfService.insertMedcInquirySanswer(map);  
        	}else{ 
                appInfService.updateMedcInquirySanswer(map); 
                numberList[aindex] = "-1";
        	}
        }
        
        for(int j=0; j<numberList.length; j++){
        	if(!"-1".equals(numberList[j])){
            	map.put("MQUESTION_NUMBER", (j+1));
                appInfService.deleteMedcInquirySanswer(map); 
        	}//if
        }//for
        
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("result", "complete"); 
		
		return result;
	}
	
	
	
	/********************************************************
	 *약정보 등록
	 * @param paramMap post / json type
	 *              {"id":"1234"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/appinf/insertdruginfo.do")
	public String insertdruginfo(@RequestParam Map<String,Object> paramMap) throws Exception {
		String code = "1";
		paramMap.put("DRUG_KO_NM", paramMap.get("DRUG_KO_NM").toString().replaceAll("◁﻿", "%").replaceAll("▷﻿", "+"));
		appInfService.insertDrugInfo((HashMap<String, Object>)paramMap);
		
		return code;
	}

	
	/**
	 * 모바일기기사용내역통합관리로 이동한다.
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/mobilemnginteg.do")
	public String mobilemnginteg(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobilemnginteg";
	}
	
	
	/**
	 * 
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/selectMngIntegDetailInfoJsonp.do")
	public @ResponseBody JSONPObject  selectMngIntegDetailInfoJsonp(@RequestParam("callback") String c,@RequestParam Map<String,Object> paramMap) { 
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> rtnList = null; 
		
		try {
			rtnList = (List<HashMap<String, Object>>)mngIntegService.selectMngIntegDetailInfoJsonp((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", mngIntegService.selectMngIntegInfoTot((HashMap<String, Object>)paramMap));
			
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
		}
		return new JSONPObject(c,rtnMap);
	}
	
	/**
	 * 코드ID로 조회
	 * @param c
	 * @param params
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/appinf/getCodeListByCdID.do")
	public @ResponseBody JSONPObject getCodeListByCdID(@RequestParam("callback") String c,@RequestParam("params") String params) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = (List<HashMap<String, Object>>)commonService.getCodeListByCdID((HashMap<String, Object>)paramMap);
		return new JSONPObject(c,rtnList);
	}
	
	/**
	 * 모바일 FAQ로 이동한다.
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/mobilefaq.do")
	public String mobilefaq(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobilefaq";
	}
	
	/**
	 * 모바일 게시판 목록으로 이동한다.
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/mobileboardlist.do")
	public String mobileboardlist(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobileboardlist";
	}
	
	/**
	 * 모바일 게시판글 보기 화면으로 이동한다.
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/mobileboardview.do")
	public String mobileboardview(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobileboardview";
	}
	
	/**
	 * 모바일커뮤니티 화면을 출력한다
	 * @param model
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appinf/mobilecommunity.do")
	public String mobilecommunity(ModelMap model,@RequestParam Map<String,Object> paramMap) throws Exception {
		//model.put("mdate", paramMap.get("mdate"));
		model.put("user_id", paramMap.get("user_id"));
		return "dgms/mobilecommunity";
	}
	
}

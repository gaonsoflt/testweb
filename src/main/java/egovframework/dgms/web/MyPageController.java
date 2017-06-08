package egovframework.dgms.web;

import java.util.ArrayList;
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
import egovframework.dgms.service.MyPageService;
import egovframework.dgms.util.PwdEncryptor;

@Controller
public class MyPageController {
Logger logger = LoggerFactory.getLogger(MyPageController.class.getName());

	@Resource(name = "myPageService")
	private MyPageService myPageService;

	@RequestMapping(value = "/dgms/myPage.do")
	public String dgmsMyPage(Model model) throws Exception {
		return "dgms/myPage";
	}
	
	
	/**
	 * 측정기기대여를 조회함
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectMyPageInfo.do")
	public @ResponseBody JSONPObject  selectMyPageInfo(@RequestParam("callback") String c, @RequestParam("params") String params) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		logger.debug("params:"+params); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params);
		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		try {
			rtnList = (List<HashMap<String, Object>>)myPageService.selectMyPageInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", myPageService.selectMyPageInfoTot((HashMap<String, Object>)paramMap));
			
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
	 * 측정기기대여를 수정함
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/updateMyPageInfo.do")
	public @ResponseBody JSONPObject updateMyPageInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateMyPageInfo.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				paramMap.put("NEW_PWD",PwdEncryptor.getEncrypt(paramMap.get("NEW_PWD").toString().trim()));
				myPageService.updateMyPageInfo(paramMap);
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
}
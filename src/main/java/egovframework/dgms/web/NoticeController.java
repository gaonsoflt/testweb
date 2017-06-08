package egovframework.dgms.web;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import egovframework.dgms.service.CommonService;
import egovframework.dgms.service.NoticeService;
import egovframework.urtown.service.EditorBrowserService;

@Controller
public class NoticeController {
Logger logger = LoggerFactory.getLogger(NoticeController.class.getName());

@Resource(name = "noticeService")
private NoticeService noticeService;

@Resource(name = "editorBrowserService")
private EditorBrowserService editorBrowserService;

@Resource(name = "commonService")
private CommonService commonService;

final String defaultUrl = Globals.Filepath_BaseDir;




	@RequestMapping(value = "/dgms/notice.do")
	public String dgmsNotice(Model model) throws Exception {
		return "dgms/notice";
	}
	
	
	/**
	 * 공지사항 게시글 데이터 가져옴
	 * @param c
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "/dgms/selectNoticeInfoJsonp.do")
	public @ResponseBody JSONPObject  selectNoticeInfoJsonp(@RequestParam("callback") String c, @RequestParam("params") String params) {
		logger.debug("---------------->/dgms/selectNoticeInfoJsonp.do");

		logger.debug("params:"+params); 

		List<HashMap<String, Object>> rtnList = null;
		HashMap<String, Object> paramMap = new HashMap<String, Object>(); 
		paramMap = (HashMap<String, Object>) EgovWebUtil.parseJsonToMap(params); 
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		logger.debug("paramMap:"+paramMap); 
		
		try {
			rtnList = (List<HashMap<String, Object>>)noticeService.selectNoticeInfo((HashMap<String, Object>)paramMap);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", noticeService.selectNoticeInfoTot((HashMap<String, Object>)paramMap));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap = new HashMap<String, Object>();
			rtnMap.put("error", e.toString());
			return new JSONPObject(c, rtnMap);
		}
		return new JSONPObject(c,rtnMap);
	}
	
	

	/**
	 * 공지사항 게시글 생성
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/insertNoticeInfoJsonp.do")
	public @ResponseBody JSONPObject insertNoticeInfoJsonp(@RequestParam("callback") String c, @RequestParam(value="models", required=false) String models) {
		logger.debug("---------------->/dgms/insertNoticeInfoJsonp.do");
		
		logger.debug("models:"+models); 
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>(); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				//HashMap<String, Object> keySeq = new HashMap<String, Object>();
				//keySeq.put("SEQ_NM", "SEQ_NOTICE");
				
				//String Sequence = (String)commonService.getSequence((HashMap<String, Object>)keySeq); 
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				//paramMap.put("NOTICE_SQ", models);
				paramMap.put("NOTICE_SQ", paramMap.get("NOTICE_SQ"));
				noticeService.insertNoticeInfo(paramMap);
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
	 * 공지사항 게시글 삭제
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/deleteNoticeInfo.do")
	public @ResponseBody JSONPObject deleteNoticeInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {
		logger.debug("---------------->/dgms/deleteNoticeInfo.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				noticeService.deleteNoticeInfo(paramMap); 
			
				//File Remove
				List list = (List)editorBrowserService.selectFiles(paramMap);
				Iterator it = list.iterator();
				
				while(it.hasNext()){
					Map<String, Object> dataMap = (HashMap<String, Object>) it.next();
					String fileSNM = dataMap.get("FILE_SNM").toString();
					String filePath = defaultUrl + "/" + fileSNM;
					File f = new File(filePath);
					f.delete();
				}
				
				//File Data Delete
				editorBrowserService.removeFiles(paramMap);
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
	 * 공지사항 게시글 수정
	 * @param c
	 * @param models
	 * @return
	 */
	@RequestMapping(value = "/dgms/updateNoticeInfo.do")
	public @ResponseBody JSONPObject updateNoticeInfo(@RequestParam("callback") String c, @RequestParam("models") String models) {  
		logger.debug("---------------->/dgms/updateNoticeInfo.do");
		List<Map<String, Object>> paramMapList = new ArrayList<Map<String, Object>>();

		logger.debug("models:"+models); 
		paramMapList = (ArrayList<Map<String, Object>>) EgovWebUtil.parseJsonToList(models);
		logger.debug("paramMapList:"+paramMapList); 

		try {
			for(int i=0; i < paramMapList.size(); i++){
				HashMap<String, Object> paramMap = (HashMap<String, Object>)paramMapList.get(i);
				noticeService.updateNoticeInfo(paramMap);
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
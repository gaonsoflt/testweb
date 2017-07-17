package egovframework.espa.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionMgrService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("questionMgrService")
public class QuestionMgrServiceImpl extends EgovAbstractServiceImpl implements QuestionMgrService { 
	Logger logger = LoggerFactory.getLogger(QuestionMgrServiceImpl.class.getName());

	@Autowired
	private ConfigService config;
	
	@Resource(name = "questionMgrMapper")
	private QuestionMgrMapper questionMapper;
	
	@Resource(name = "questionConditionMapper")
	private QuestionConditionMapper questionConditionMapper;
	
	@Resource(name = "questionGradingMapper")
	private QuestionGradingMapper questionGradingMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	
	@Override
	public List<Map<String, Object>> getQuestionList(Map<String, Object> map) throws Exception {
		return questionMapper.selectQuestionList(map);
	}

	@Override
	public List<Map<String, Object>> getQuestion(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = questionMapper.selectQuestion(map);
		// init default value(timeout, ban_keyword) from espa config
//		if(result.size() > 0) {
//			if(result.get(0).get("timeout") == null) {
//				result.get(0).put("timeout", Long.valueOf(config.getEspaConfigVoValue("DEFAULT_TIMEOUT"))); 
//				result.get(0).put("ban_keyword", config.getEspaConfigVoValue("DEFAULT_BAN_KW")); 
//			}
//		}
		return result;
	}
	

	@Override
	public List<Map<String, Object>> getQuestion(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("question_seq", seq);
		return getQuestion(param);
	}

	@Override
	public int getQuestionAllCount(Map<String, Object> map) throws Exception {
		return questionMapper.selectQuestionAllCount(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.insertQuestion(map);
		logger.debug("[BBAEK] get pk:" + map);
//		List<Map<String, Object>> list;
//		if(map.get("condition") != null) {
//			list = (List<Map<String, Object>>) map.get("condition");
//			for (Map<String, Object> param : list) {
//				logger.debug("[BBAEK] create condition param:" + param);
//				param.put("question_seq", map.get("question_seq"));
//				execute += questionConditionService.createCondition(param);
//			}
//		}
		
//		if(map.get("grading") != null) {
//			list = (List<Map<String, Object>>) map.get("grading");
//			for (Map<String, Object> param : list) {
//				logger.debug("[BBAEK] create grading param:" + param);
//				param.put("question_seq", map.get("question_seq"));
//				execute += questionGradingMapper.insertGrading(param);
//			}
//		}
		return execute;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int updateQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.updateQuestion(map);
		logger.debug("[BBAEK] delete question condition/answer:" + map.get("question_seq"));
		List<Map<String, Object>> list;
//		if(map.get("condition") != null) {
//			questionConditionMapper.deleteCondition(map);
//			list = (List<Map<String, Object>>) map.get("condition");
//			for (Map<String, Object> param : list) {
//				logger.debug("[BBAEK] create condition param:" + param);
//				param.put("question_seq", map.get("question_seq"));
//				execute += questionConditionService.createCondition(param);
//			}
//		}
		
//		if(map.get("grading") != null) {
//			questionGradingMapper.deleteGrading(map);
//			list = (List<Map<String, Object>>) map.get("grading");
//			for (Map<String, Object> param : list) {
//				logger.debug("[BBAEK] create grading param:" + param);
//				param.put("question_seq", map.get("question_seq"));
//				execute += questionGradingMapper.insertGrading(param);
//			}
//		}
		return execute;
	}

	@Override
	public int deleteQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.deleteQuestion(map);
		execute += questionConditionMapper.deleteCondition(map);
		execute += questionGradingMapper.deleteGrading(map);
		return execute;
	}

	@Override
	public List<Map<String, Object>> getSupportLanguage(Map<String, Object> map) throws Exception {
		String value = config.getEspaConfigVoValue("LANGUAGE");
		List<Map<String, Object>> rtn = new ArrayList<>();
		for (String str : value.split(",")) {
			Map<String, Object> lang = new HashMap<>();
			lang.put("text", str);
			lang.put("value", str);
			rtn.add(lang);
		};
		return rtn;
	}
	
	@Override
	public int saveQuestion(Map<String, Object> map) throws Exception {
		map.put("mod_usr", userService.getLoginUserInfo().getUsername());
		int exeCnt = 0;
		logger.debug("param: " + map);
		exeCnt = updateQuestion(map);
		logger.debug("update: " + exeCnt);
		if(exeCnt <= 0) {
			map.put("reg_usr", userService.getLoginUserInfo().getUsername());
			logger.debug("param: " + map);
			exeCnt = createQuestion(map);
			logger.debug("insert: " + exeCnt);
		}
		return exeCnt;
	}
}
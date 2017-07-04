package egovframework.espa.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionMgrService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


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
	
	
	@Override
	public List<HashMap<String, Object>> getQuestionList(HashMap<String, Object> map) throws Exception {
		return questionMapper.selectQuestionList(map);
	}

	@Override
	public List<HashMap<String, Object>> getQuestion(HashMap<String, Object> map) throws Exception {
		List<HashMap<String, Object>> result = questionMapper.selectQuestion(map);
		// init default value(timeout, ban_keyword) from espa config
		if(result.size() > 0) {
			if(result.get(0).get("timeout") == null) {
				result.get(0).put("timeout", Long.valueOf(config.getEspaConfigVoValue("DEFAULT_TIMEOUT"))); 
				result.get(0).put("ban_keyword", config.getEspaConfigVoValue("DEFAULT_BAN_KW")); 
			}
		}
		return result;
	}

	@Override
	public int getQuestionAllCount(HashMap<String, Object> map) throws Exception {
		return questionMapper.selectQuestionAllCount(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createQuestion(HashMap<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.insertQuestion(map);
		logger.debug("[BBAEK] get pk:" + map);
		List<HashMap<String, Object>> list;
//		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) map.get("condition");
//		for (HashMap<String, Object> param : list) {
//			logger.debug("[BBAEK] create condition param:" + param);
//			param.put("question_seq", map.get("question_seq"));
//			execute += questionConditionService.createCondition(param);
//		}
		list = (List<HashMap<String, Object>>) map.get("grading");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create grading param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionGradingMapper.insertGrading(param);
		}
		return execute;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int updateQuestion(HashMap<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.updateQuestion(map);
		logger.debug("[BBAEK] delete question condition/answer:" + map.get("question_seq"));
		questionConditionMapper.deleteCondition(map);
		questionGradingMapper.deleteGrading(map);
		List<HashMap<String, Object>> list;
//		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) map.get("condition");
//		for (HashMap<String, Object> param : list) {
//			logger.debug("[BBAEK] create condition param:" + param);
//			param.put("question_seq", map.get("question_seq"));
//			execute += questionConditionService.createCondition(param);
//		}
		list = (List<HashMap<String, Object>>) map.get("grading");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create grading param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionGradingMapper.insertGrading(param);
		}
		return execute;
	}

	@Override
	public int deleteQuestion(HashMap<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.deleteQuestion(map);
		execute += questionConditionMapper.deleteCondition(map);
		execute += questionGradingMapper.deleteGrading(map);
		return execute;
	}

	@Override
	public List<HashMap<String, Object>> getSupportLanguage(HashMap<String, Object> map) throws Exception {
		String value = config.getEspaConfigVoValue("LANGUAGE");
		List<HashMap<String, Object>> rtn = new ArrayList<>();
		for (String str : value.split(",")) {
			HashMap<String, Object> lang = new HashMap<>();
			lang.put("text", str);
			lang.put("value", str);
			rtn.add(lang);
		};
		return rtn;
	}
}
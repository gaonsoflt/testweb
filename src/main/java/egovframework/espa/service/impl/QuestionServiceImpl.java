package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionGradingService;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionConditionService;
import egovframework.espa.service.QuestionService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionService")
public class QuestionServiceImpl extends EgovAbstractServiceImpl implements QuestionService { 
	Logger logger = LoggerFactory.getLogger(QuestionServiceImpl.class.getName());

	@Autowired
	private ConfigService config;
	
	@Resource(name = "questionMapper")
	private QuestionMapper questionMapper;
	
	@Resource(name = "questionConditionService")
	private QuestionConditionService questionConditionService;
	
	@Resource(name = "questionGradingService")
	private QuestionGradingService questionGradingService;

	
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
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) map.get("condition");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create condition param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionConditionService.createCondition(param);
		}
		list = (List<HashMap<String, Object>>) map.get("grading");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create grading param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionGradingService.createGrading(param);
		}
		return execute;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int updateQuestion(HashMap<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.updateQuestion(map);
		logger.debug("[BBAEK] delete question condition/answer:" + map.get("question_seq"));
		questionConditionService.deleteCondition(map);
		questionGradingService.deleteGrading(map);
		
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) map.get("condition");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create condition param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionConditionService.createCondition(param);
		}
		list = (List<HashMap<String, Object>>) map.get("grading");
		for (HashMap<String, Object> param : list) {
			logger.debug("[BBAEK] create grading param:" + param);
			param.put("question_seq", map.get("question_seq"));
			execute += questionGradingService.createGrading(param);
		}
		return execute;
	}

	@Override
	public int deleteQuestion(HashMap<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.deleteQuestion(map);
		execute += questionConditionService.deleteCondition(map);
		execute += questionGradingService.deleteGrading(map);
		return execute;
	}
}
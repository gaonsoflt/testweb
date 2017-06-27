package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.espa.core.agent.ESPAExecuteAgent;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.handler.ESPAExecuteResultHandler;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionExecuteService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionExecuteService")
public class QuestionExecuteServiceImpl extends EgovAbstractServiceImpl implements QuestionExecuteService { 
	Logger logger = LoggerFactory.getLogger(QuestionExecuteServiceImpl.class.getName());

	@Autowired
	private ConfigService config;
	
	@Resource(name = "questionMapper")
	private QuestionMapper questionMapper;
	
	@Resource(name = "questionConditionMapper")
	private QuestionConditionMapper conditionMapper;
	
	@Resource(name = "questionGradingMapper")
	private QuestionGradingMapper gradingMapper;
	
	@Override
	public void executeTest(HashMap<String, Object> map) throws Exception {
		ESPAExecuteVO executeVO = new ESPAExecuteVO();
		HashMap<String, Object> result = ((List<HashMap<String, Object>>) questionMapper.selectQuestion(map)).get(0);
		List<HashMap<String, Object>> conditionList = (List<HashMap<String, Object>>) conditionMapper.selectConditionList(map);
		List<HashMap<String, Object>> gradingList = (List<HashMap<String, Object>>) gradingMapper.selectGradingList(map);
		executeVO.setQuestionSeq(result.get("question_seq").toString());
		executeVO.setCode(result.get("test_code").toString());
		executeVO.setLanguage(result.get("lang_name").toString());
		executeVO.setTimeout(Long.valueOf((result.get("timeout") != null) ? result.get("timeout").toString() : "-1"));
		executeVO.setBanKeyword((result.get("ban_keyword") != null) ? result.get("ban_keyword").toString() : "");
		executeVO.setCondition(conditionList);
		executeVO.setGrading(gradingList);
		executeVO.setTest(true);
		
		logger.debug("[BBAEK] testcode: " + executeVO.getCode());
		
		ESPAExecuteAgent agent = new ESPAExecuteAgent(executeVO, config);
		agent.setResultHandler(new ESPAExecuteResultHandler() {
			@Override
			public void handleResult(List<ESPAExecuteResultVO> vl) {
				try {
					for (ESPAExecuteResultVO vo : vl) {
						logger.debug("param: " + vo);
						gradingMapper.updateGradingTestResult(vo);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
		try {
			agent.execute();
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public void execute(HashMap<String, Object> map) throws Exception {
		ESPAExecuteVO executeVO = new ESPAExecuteVO();
		// TODO: 사용자가 제출한 코드를 가져 와야함
		HashMap<String, Object> result = ((List<HashMap<String, Object>>) questionMapper.selectQuestion(map)).get(0);
		List<HashMap<String, Object>> conditionList = (List<HashMap<String, Object>>) conditionMapper.selectConditionList(map);
		List<HashMap<String, Object>> gradingList = (List<HashMap<String, Object>>) gradingMapper.selectGradingList(map);
		executeVO.setQuestionSeq(result.get("question_seq").toString());
		executeVO.setCode(result.get("test_code").toString());
		executeVO.setLanguage(result.get("lang_name").toString());
		executeVO.setTimeout(Long.valueOf((result.get("timeout") != null) ? result.get("timeout").toString() : "-1"));
		executeVO.setBanKeyword((result.get("ban_keyword") != null) ? result.get("ban_keyword").toString() : "");
		executeVO.setCondition(conditionList);
		executeVO.setGrading(gradingList);
		executeVO.setTest(false);
		logger.debug("[BBAEK] testcode: " + executeVO.getCode());
		
		ESPAExecuteAgent agent = new ESPAExecuteAgent(executeVO, config);
		agent.execute();
	}
	
}
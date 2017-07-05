package egovframework.espa.service.impl;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.espa.core.agent.ESPAExecuteAgent;
import egovframework.espa.core.execute.handler.ESPAExecuteResultHandler;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionExecuteService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionExecuteService")
public class QuestionExecuteServiceImpl extends EgovAbstractServiceImpl implements QuestionExecuteService { 
	Logger logger = LoggerFactory.getLogger(QuestionExecuteServiceImpl.class.getName());

	@Autowired
	private ConfigService config;
	
	@Resource(name = "questionMgrMapper")
	private QuestionMgrMapper questionMapper;
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "questionAnswerHistoryMapper")
	private QuestionAnswerHistoryMapper answerHisMapper;
	
	@Resource(name = "questionGradingHistoryMapper")
	private QuestionGradingHistoryMapper gradingHisMapper;
	
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
		executeVO.setQuestionSeq(Long.valueOf(result.get("question_seq").toString()));
		executeVO.setCode(result.get("test_code").toString());
		executeVO.setLanguage(result.get("lang_type").toString());
		executeVO.setTimeout(Long.valueOf((result.get("timeout") != null) ? result.get("timeout").toString() : "-1"));
		executeVO.setBanKeyword((result.get("ban_keyword") != null) ? result.get("ban_keyword").toString() : "");
		executeVO.setMaxCodeSize(Long.valueOf(result.get("max_codesize").toString()));
		executeVO.setCondition(conditionList);
		executeVO.setGrading(gradingList);
		executeVO.setTest(true);
		executeVO.setGradingHandler(null); // custom grading handler

		logger.debug("[BBAEK] execute code: " + executeVO.getCode());
		
		ESPAExecuteAgent agent = new ESPAExecuteAgent(executeVO, config);
		agent.setResultHandler(new ESPAExecuteResultHandler() {
			@Override
			public void handleResult(ESPAExecuteVO vo) {
				try {
					if(vo.getError() == null) {
						for (ESPAExecuteResultVO result : vo.getResultList()) {
							logger.debug("param: " + result);
							gradingMapper.updateGradingTestResult(result);
							//result.getException();
						}
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
		final ESPAExecuteVO executeVO = new ESPAExecuteVO();
		HashMap<String, Object> result = ((List<HashMap<String, Object>>) deployMapper.readDeployedQuestionDetailByUser(map)).get(0);
		List<HashMap<String, Object>> conditionList = (List<HashMap<String, Object>>) conditionMapper.selectConditionList(result);
		List<HashMap<String, Object>> gradingList = (List<HashMap<String, Object>>) gradingMapper.selectGradingList(result);
		executeVO.setDeploySeq(Long.valueOf(result.get("deploy_seq").toString()));
		executeVO.setUserSeq(Long.valueOf(result.get("user_seq").toString()));
		executeVO.setCode(result.get("answer").toString());
		executeVO.setQuestionSeq(Long.valueOf(result.get("question_seq").toString()));
		executeVO.setSubmitDt((Timestamp) result.get("submit_dt"));
		executeVO.setLanguage(result.get("lang_type").toString());
		executeVO.setTimeout(Long.valueOf((result.get("timeout") != null) ? result.get("timeout").toString() : "-1"));
		executeVO.setBanKeyword((result.get("ban_keyword") != null) ? result.get("ban_keyword").toString() : "");
		executeVO.setMaxCodeSize(Long.valueOf(result.get("max_codesize").toString()));
		executeVO.setCondition(conditionList);
		executeVO.setGrading(gradingList);
		executeVO.setTest(false);
		executeVO.setGradingHandler(null); // custom grading handler
		
		logger.debug("[BBAEK] execute code: " + executeVO.getCode());
		
		ESPAExecuteAgent agent = new ESPAExecuteAgent(executeVO, config);
		agent.setResultHandler(new ESPAExecuteResultHandler() {
			@Override
			public void handleResult(ESPAExecuteVO vo) {
				try {
					if(vo.getError() == null) {
						for (ESPAExecuteResultVO result : vo.getResultList()) {
							logger.debug("param: " + result);
							gradingHisMapper.createGradingHistory(result);
						}
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
	
}
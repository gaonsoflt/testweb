package egovframework.espa.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionAnswerService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;

@Service("questionAnswerService")
public class QuestionAnswerServiceImpl extends EgovAbstractServiceImpl implements QuestionAnswerService {
	Logger logger = LoggerFactory.getLogger(QuestionAnswerServiceImpl.class.getName());

	@Resource(name = "questionAnswerHistoryMapper")
	private QuestionAnswerHistoryMapper answerHisMapper;

	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;


	@Override
	public boolean saveAnswer(Map<String, Object> map) throws Exception {
		if(map.get("deploy_seq") == null) {
			return false;
		}
		logger.debug("check available deployed question: " + map.get("deploy_seq"));
		map.put("user_seq", userService.getLoginUserInfo().getUserseq());
		
		// check submission time
		logger.debug("check submission time");
		if(deployMapper.readAvailableDeployedQuestion(map) <= 0) {
			throw new Exception("Submission time has been finished.");
		}
		
		// check max submit count
		logger.debug("check max submit count");
		if(answerHisMapper.checkUserSubmitCount(map)) {
			throw new Exception("The number of submissions has been exceeded.");
		}
		
		logger.debug("request parameter: " + map);
		logger.debug("insert answer to history table");
		if(answerHisMapper.insertAnswerHistory(map) > 0) {
			return true; 
		}
		return false;
	}
}
package egovframework.espa.service.impl;

import java.util.HashMap;

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
	public boolean saveAnswer(HashMap<String, Object> map) {
		try {
			if(map.get("deploy_seq") == null) {
				throw new Exception("deploy seq is null");
			}
			logger.debug("check available deployed question: " + map.get("deploy_seq"));
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			if(deployMapper.readAvailableDeployedQuestion(map) <= 0) {
				throw new Exception("there are not available deployed question");
			}
			
			logger.debug("request parameter: " + map);
			logger.debug("insert answer to history table");
			answerHisMapper.insertAnswerHistory(map);
			
			return true; 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
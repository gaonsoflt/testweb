package egovframework.espa.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionGradingHistoryService;
import egovframework.espa.util.QuestionUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("questionGradingHistoryService")
public class QuestionGradingHistoryServiceImpl extends EgovAbstractServiceImpl implements QuestionGradingHistoryService{ 
	
	@Resource(name = "questionGradingHistoryMapper")
	private QuestionGradingHistoryMapper gradingHisMapper;
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public List<HashMap<String, Object>> getGradingResultListByUser(HashMap<String, Object> map) throws Exception {
		List<HashMap<String, Object>> result = new ArrayList<>();
		map.put("user_seq", userService.getLoginUserInfo().getUserseq());
		for (HashMap<String, Object> question : deployMapper.readDeployedQuestionListByUser(map)) {
			map.put("deploy_seq", question.get("deploy_seq"));
			map.put("question_seq", question.get("qestion_seq"));
			
			List<HashMap<String, Object>> grading = gradingHisMapper.readLatestGradingHistoryByUser(map);
			if(grading.size() > 0) {
				float score = QuestionUtil.calculateScore(grading);
				question.put("submit_dt", grading.get(0).get("submit_dt"));
				question.put("score", score);
			} else {
				question.put("score", 0);
			}
			result.add(question);
		}
		return result;
	}
	
	@Override
	public List<HashMap<String, Object>> getGradingResultList(HashMap<String, Object> map) throws Exception {
		List<HashMap<String, Object>> result = deployMapper.readDeployedQuestionList(map);
		return result;
	}

	@Override
	public List<HashMap<String, Object>> getUserGrading(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
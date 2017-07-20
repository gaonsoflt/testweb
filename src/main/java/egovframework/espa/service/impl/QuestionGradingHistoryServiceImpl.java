package egovframework.espa.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionGradingHistoryService;
import egovframework.espa.util.QuestionUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("questionGradingHistoryService")
public class QuestionGradingHistoryServiceImpl extends EgovAbstractServiceImpl implements QuestionGradingHistoryService{ 
	Logger logger = LoggerFactory.getLogger(QuestionGradingHistoryServiceImpl.class.getName());

	@Resource(name = "questionGradingHistoryMapper")
	private QuestionGradingHistoryMapper gradingHisMapper;
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public List<Map<String, Object>> getGradingResultListByUser(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		map.put("user_seq", userService.getLoginUserInfo().getUserseq());
		logger.debug("params: " + map);
		for (Map<String, Object> question : deployMapper.readDeployedQuestionListByUser(map)) {
			map.put("deploy_seq", question.get("deploy_seq"));
			map.put("question_seq", question.get("qestion_seq"));
			logger.debug("params: " + map);
			List<Map<String, Object>> grading = gradingHisMapper.readLatestGradingHistoryByUser(map);
			if(grading.size() > 0) {
				float score = QuestionUtil.calculateScore(grading);
				question.put("submit_dt", grading.get(0).get("submit_dt"));
				question.put("score", score);
			} else {
				question.put("submit_dt", "");
				question.put("score", 0);
			}
			result.add(question);
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> getDeployedQuestinResultList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = gradingHisMapper.readDeployedQuestinResultList(map);
		return result;
	}
	
	@Override
	public Map<String, Object> getDeployedQuestinResult(Map<String, Object> map) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			logger.debug("params: " + map);
			rtnMap = gradingHisMapper.readDeployedQuestionResult(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> getDeployedQuestinResult(long deploySeq) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("deploy_seq", deploySeq);
		return getDeployedQuestinResult(param);
	}
	
	@Override
	public List<Map<String, Object>> getGradingResultOfUserList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		logger.debug("params: " + map);
		for (Map<String, Object> resultUser : gradingHisMapper.readGradingResultUserList(map)) {
			logger.debug("params: " + map);
			List<Map<String, Object>> grading = gradingHisMapper.readLatestGradingHistoryByUser(resultUser);
			if(grading.size() > 0) {
				float score = QuestionUtil.calculateScore(grading);
				resultUser.put("submit_dt", grading.get(0).get("submit_dt"));
				resultUser.put("score", score);
			} else {
				resultUser.put("submit_dt", "");
				resultUser.put("score", 0);
			}
			result.add(resultUser);
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> getUserAnswerHistoryList(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = new ArrayList<>();
		logger.debug("params: " + map);
		for (Map<String, Object> resultUser : gradingHisMapper.readUserAnswerHistories(map)) {
			logger.debug("params: " + map);
			List<Map<String, Object>> grading = gradingHisMapper.readGradingHistoryByUser(resultUser);
			if(grading.get(0).get("err_code") == null) {
				float score = QuestionUtil.calculateScore(grading);
//				resultUser.put("submit_dt", grading.get(0).get("submit_dt"));
				resultUser.put("avg_exectime", QuestionUtil.calculateAvgExectime(grading));
				resultUser.put("score", score);
			} else {
//				resultUser.put("submit_dt", "");
				resultUser.put("avg_exectime", 0);
				resultUser.put("score", 0);
			}
			result.add(resultUser);
		}
		return result;
	}

	@Override
	public Map<String, Object> getUserGradingResultDetail(Map<String, Object> map) throws Exception {
		Date date = new Date(Long.valueOf(map.get("submit_dt").toString()));
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateText = df2.format(date);
		map.put("submit_dt", dateText);
		logger.debug("params: " + map);
		List<Map<String, Object>> gradingList = gradingHisMapper.readGradingHistoryByUser(map);
		List<Map<String, Object>> gradings = new ArrayList<>();
		if(gradingList.get(0).get("err_code") == null) {
			map.put("score", QuestionUtil.calculateScore(gradingList));
			for (Map<String, Object> _grading : gradingList) {
				float score = 100 / gradingList.size() * Float.valueOf(_grading.get("score_rate").toString());
				_grading.put("score", score);
				gradings.add(_grading);
			}
			map.put("grading", gradings);
			map.put("answer", gradingList.get(0).get("answer"));
			map.put("err_code", null);
			map.put("err_msg", null);
		} else {
			map.put("score", 0);
			map.put("grading", gradings);
			map.put("answer", null);
			map.put("err_code", gradingList.get(0).get("err_code"));
			map.put("err_msg", gradingList.get(0).get("err_msg"));
		}
		return map;
	}
}
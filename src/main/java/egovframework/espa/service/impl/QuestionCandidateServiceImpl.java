package egovframework.espa.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.espa.service.QuestionCandidateService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionCandidateService")
public class QuestionCandidateServiceImpl extends EgovAbstractServiceImpl implements QuestionCandidateService{ 
	Logger logger = LoggerFactory.getLogger(QuestionCandidateServiceImpl.class.getName());
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "questionCandidateMapper")
	private QuestionCandidateMapper candidateMapper;

	@Override
	public List<Map<String, Object>> getDeployedQuestionList(Map<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("param: " + param);
		}
		return deployMapper.readNotFinishDeployList(param);
	}

	@Override
	public List<Map<String, Object>> getCandidateList(Map<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("param: " + param);
		}
		return candidateMapper.readCandidateList(param);
	}

	@Override
	public List<Map<String, Object>> getNotCandidateList(Map<String, Object> param) throws Exception {
		if(logger.isDebugEnabled()) {
			logger.debug("param: " + param);
		}
		return candidateMapper.readNotCandidateList(param);
	}
	
	@Override
	public int saveCandidate(Map<String, Object> param) throws Exception {
		int executeCnt = 0;
		if(logger.isDebugEnabled()) {
			logger.debug("param: " + param);
		}
		if(candidateMapper.deleteCandidateByDeploySeq(param) > 0) {
			List<Map<String, Object>> candidateList = EgovWebUtil.parseJsonToList(param.get("candidate").toString());
			for (Map<String, Object> candidate : candidateList) {
				candidate.put("deploy_seq", param.get("deploy_seq"));
				executeCnt += candidateMapper.createCandidate(candidate);
			}
		}
		return executeCnt;
	}
}
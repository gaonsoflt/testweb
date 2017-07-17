package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionDeployService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("questionDeployService")
public class QuestionDeployServiceImpl extends EgovAbstractServiceImpl implements QuestionDeployService { 
	Logger logger = LoggerFactory.getLogger(QuestionDeployServiceImpl.class.getName());
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "questionCadidateMapper")
	private QuestionCadidateMapper candidateMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public List<Map<String, Object>> getDeployList(Map<String, Object> map) throws Exception {
		return deployMapper.readDeployList(map);
	}

	@Override
	public List<Map<String, Object>> getDeploy(Map<String, Object> map) throws Exception {
		return deployMapper.readDeploy(map);
	}

	@Override
	public int getDeployAllCount(Map<String, Object> map) throws Exception {
		return deployMapper.readDeployAllCount(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createDeploy(Map<String, Object> map) throws Exception {
		int executeCnt = 0;
		List<Map<String, Object>> groups = (List<Map<String, Object>>) map.get("groups");
		for (Map<String, Object> group : groups) {
			map.put("group_id", group.get("cd_id"));
			executeCnt = deployMapper.createDeploy(map);
			logger.debug("get pk: " + map.get("deploy_seq"));
			candidateMapper.createCandidate(map);
		}
		return executeCnt;
	}

	@Override
	public int updateDeploy(Map<String, Object> map) throws Exception {
		return deployMapper.updateDeploy(map);
	}

	@Override
	public int deleteDeploy(Map<String, Object> map) throws Exception {
		return deployMapper.deleteDeploy(map);
	}

	@Override
	public Map<String, Object> getGroupOfDeployedQuestionByUser(Map<String, Object> map) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			logger.debug("params: " + map);
			List<Map<String, Object>> rtnList = deployMapper.readGroupsOfAvailableDeployedQuestion(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> getGroupOfDeployedQuestion(Map<String, Object> map) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			logger.debug("params: " + map);
			List<Map<String, Object>> rtnList = deployMapper.readGroupsOfAvailableDeployedQuestion(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getDeployedQuestionListByUser(Map<String, Object> map) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			List<Map<String, Object>> rtnList = deployMapper.readDeployedQuestionListByUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public Map<String, Object> getDeployedQuestionDetailByUser(Map<String, Object> map) {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			logger.debug("params: " + map);
			rtnMap = deployMapper.readDeployedQuestionDetailByUser(map);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
}
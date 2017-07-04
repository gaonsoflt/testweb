package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

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
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public List<HashMap<String, Object>> getDeployList(HashMap<String, Object> map) throws Exception {
		return deployMapper.readDeployList(map);
	}

	@Override
	public List<HashMap<String, Object>> getDeploy(HashMap<String, Object> map) throws Exception {
		return deployMapper.readDeploy(map);
	}

	@Override
	public int getDeployAllCount(HashMap<String, Object> map) throws Exception {
		return deployMapper.readDeployAllCount(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createDeploy(HashMap<String, Object> map) throws Exception {
		int executeCnt = 0;
		List<HashMap<String, Object>> groups = (List<HashMap<String, Object>>) map.get("groups");
		for (HashMap<String, Object> group : groups) {
			map.put("group_id", group.get("cd_id"));
			executeCnt = deployMapper.createDeploy(map);
		}
		return executeCnt;
	}

	@Override
	public int updateDeploy(HashMap<String, Object> map) throws Exception {
		return deployMapper.updateDeploy(map);
	}

	@Override
	public int deleteDeploy(HashMap<String, Object> map) throws Exception {
		return deployMapper.deleteDeploy(map);
	}

	@Override
	public HashMap<String, Object> getGroupOfDeployedQuestionByUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			logger.debug("params: " + map);
			List<HashMap<String, Object>> rtnList = deployMapper.readGroupsOfAvailableDeployedQuestion(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public HashMap<String, Object> getGroupOfDeployedQuestion(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			logger.debug("params: " + map);
			List<HashMap<String, Object>> rtnList = deployMapper.readGroupsOfAvailableDeployedQuestion(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public HashMap<String, Object> getDeployedQuestionListByUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			List<HashMap<String, Object>> rtnList = deployMapper.readDeployedQuestionListByUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public HashMap<String, Object> getDeployedQuestionDetailByUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			logger.debug("params: " + map);
			rtnMap = deployMapper.readDeployedQuestionDetailByUser(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
}
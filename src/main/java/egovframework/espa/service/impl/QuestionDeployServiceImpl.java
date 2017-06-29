package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionDeployService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionDeployService")
public class QuestionDeployServiceImpl extends EgovAbstractServiceImpl implements QuestionDeployService { 
	Logger logger = LoggerFactory.getLogger(QuestionDeployServiceImpl.class.getName());
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper questionDeployMapper;

	@Override
	public List<HashMap<String, Object>> getDeployList(HashMap<String, Object> map) throws Exception {
		return questionDeployMapper.readDeployList(map);
	}

	@Override
	public List<HashMap<String, Object>> getDeploy(HashMap<String, Object> map) throws Exception {
		return questionDeployMapper.readDeploy(map);
	}

	@Override
	public int getDeployAllCount(HashMap<String, Object> map) throws Exception {
		return questionDeployMapper.readDeployAllCount(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createDeploy(HashMap<String, Object> map) throws Exception {
		int executeCnt = 0;
		List<HashMap<String, Object>> groups = (List<HashMap<String, Object>>) map.get("groups");
		for (HashMap<String, Object> group : groups) {
			map.put("group_id", group.get("cd_id"));
			executeCnt = questionDeployMapper.createDeploy(map);
		}
		return executeCnt;
	}

	@Override
	public int updateDeploy(HashMap<String, Object> map) throws Exception {
		return questionDeployMapper.updateDeploy(map);
	}

	@Override
	public int deleteDeploy(HashMap<String, Object> map) throws Exception {
		return questionDeployMapper.deleteDeploy(map);
	}
}
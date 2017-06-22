package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionConditionService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionConditionService")
public class QuestionConditionServiceImpl extends EgovAbstractServiceImpl implements QuestionConditionService{ 
	
	@Resource(name = "questionConditionMapper")
	private QuestionConditionMapper conditionMapper;
	
	@Override
	public List<HashMap<String, Object>> getConditionList(HashMap<String, Object> map) throws Exception {
		return conditionMapper.selectConditionList(map);
	}

	@Override
	public int createCondition(HashMap<String, Object> map) throws Exception {
		return conditionMapper.insertCondition(map);
	}

	@Override
	public int updateCondition(HashMap<String, Object> map) throws Exception {
		return conditionMapper.updateCondition(map);
	}

	@Override
	public int deleteCondition(HashMap<String, Object> map) throws Exception {
		return conditionMapper.deleteCondition(map);
	}
}
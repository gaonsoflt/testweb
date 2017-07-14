package egovframework.espa.service.impl;

import java.util.Map;
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
	public List<Map<String, Object>> getConditionList(Map<String, Object> map) throws Exception {
		return conditionMapper.selectConditionList(map);
	}

	@Override
	public int createCondition(Map<String, Object> map) throws Exception {
		return conditionMapper.insertCondition(map);
	}

	@Override
	public int updateCondition(Map<String, Object> map) throws Exception {
		return conditionMapper.updateCondition(map);
	}

	@Override
	public int deleteCondition(Map<String, Object> map) throws Exception {
		return conditionMapper.deleteCondition(map);
	}
}
package egovframework.espa.service.impl;

import java.util.Map;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionGradingService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionGradingService")
public class QuestionGradingServiceImpl extends EgovAbstractServiceImpl implements QuestionGradingService{ 
	
	@Resource(name = "questionGradingMapper")
	private QuestionGradingMapper gradingMapper;
	 
	@Override
	public List<Map<String, Object>> getGradingList(Map<String, Object> map) throws Exception {
		return gradingMapper.selectGradingList(map);
	}

	@Override
	public int createGrading(Map<String, Object> map) throws Exception {
		return gradingMapper.insertGrading(map);
	}

	@Override
	public int updateGrading(Map<String, Object> map) throws Exception {
		return gradingMapper.updateGrading(map);
	}

	@Override
	public int deleteGrading(Map<String, Object> map) throws Exception {
		return gradingMapper.deleteGrading(map);
	}
}
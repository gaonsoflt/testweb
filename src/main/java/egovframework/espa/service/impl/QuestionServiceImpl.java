package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("questionService")
public class QuestionServiceImpl extends EgovAbstractServiceImpl implements QuestionService { 
	
	@Resource(name = "questionMapper")
	private QuestionMapper questionMapper;
	
	@Override
	public List<HashMap<String, Object>> getQuestionList(HashMap<String, Object> map) throws Exception {
		return questionMapper.selectQuestionList(map);
	}

	@Override
	public List<HashMap<String, Object>> getQuestion(HashMap<String, Object> map) throws Exception {
		return questionMapper.selectQuestion(map);
	}

	@Override
	public int getQuestionAllCount(HashMap<String, Object> map) throws Exception {
		return questionMapper.selectQuestionAllCount(map);
	}

	@Override
	public int createQuestion(HashMap<String, Object> map) throws Exception {
		return questionMapper.insertQuestion(map);
	}

	@Override
	public int updateQuestion(HashMap<String, Object> map) throws Exception {
		return questionMapper.updateQuestion(map);
	}

	@Override
	public int deleteQuestion(HashMap<String, Object> map) throws Exception {
		return questionMapper.deleteQuestion(map);
	}
}
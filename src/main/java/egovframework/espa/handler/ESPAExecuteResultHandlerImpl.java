package egovframework.espa.handler;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.service.impl.QuestionMapper;

@Service
public class ESPAExecuteResultHandlerImpl implements ESPAExecuteResultHandler {
	@Resource(name = "questionMapper")
	private QuestionMapper questionMapper;	
	
	@Override
	public void handleResult(List<ESPAExecuteResultVO> vo) {
		try {
			questionMapper.selectQuestionAllCount(new HashMap<String, Object>());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

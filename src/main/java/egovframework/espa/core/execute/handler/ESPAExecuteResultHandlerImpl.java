package egovframework.espa.core.execute.handler;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.impl.QuestionMgrMapper;

@Service
public class ESPAExecuteResultHandlerImpl implements ESPAExecuteResultHandler {
	@Resource(name = "questionMgrMapper")
	private QuestionMgrMapper questionMapper;	
	
	@Override
	public void handleResult(ESPAExecuteVO vo) {
		// test code
		try {
			questionMapper.selectQuestionAllCount(new HashMap<String, Object>());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

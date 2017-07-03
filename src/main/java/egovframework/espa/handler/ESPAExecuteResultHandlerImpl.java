package egovframework.espa.handler;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.service.impl.QuestionMgrMapper;

@Service
public class ESPAExecuteResultHandlerImpl implements ESPAExecuteResultHandler {
	@Resource(name = "questionMgrMapper")
	private QuestionMgrMapper questionMapper;	
	
	@Override
	public void handleResult(List<ESPAExecuteResultVO> vo) {
		try {
			questionMapper.selectQuestionAllCount(new HashMap<String, Object>());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

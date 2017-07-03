package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.QuestionExecuteService;
import egovframework.espa.service.QuestionService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("questionService")
public class QuestionServiceImpl extends EgovAbstractServiceImpl implements QuestionService { 
	Logger logger = LoggerFactory.getLogger(QuestionServiceImpl.class.getName());
	
	@Resource(name = "questionDeployMapper")
	private QuestionDeployMapper deployMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	@Override
	public HashMap<String, Object> readDeployedQuestionListForSubmit(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			List<HashMap<String, Object>> rtnList = deployMapper.readDeployedQuestionListForSubmit(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public HashMap<String, Object> readDeployedQuestionDetailForSubmit(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			map.put("user_seq", userService.getLoginUserInfo().getUserseq());
			logger.debug("params: " + map);
			rtnMap = deployMapper.readDeployedQuestionDetailForSubmit(map).get(0);
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
}
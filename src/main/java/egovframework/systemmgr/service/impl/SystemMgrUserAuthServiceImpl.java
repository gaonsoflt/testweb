package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.systemmgr.controller.SystemMgrUserAuthController;
import egovframework.systemmgr.service.SystemMgrUserAuthService;

@Service("systemMgrUserAuthService")
public class SystemMgrUserAuthServiceImpl implements SystemMgrUserAuthService {
	Logger logger = LoggerFactory.getLogger(SystemMgrUserAuthServiceImpl.class);

	@Resource(name = "systemMgrUserAuthMapper")
	private SystemMgrUserAuthMapper userAuthMapper;

	@Override
	public List<HashMap<String, Object>> selectUserAuthByUserType(HashMap<String, Object> map) throws Exception {
		return userAuthMapper.selectUserAuthByUserType(map);
	}
	
	@Override
	public HashMap<String, Object> selectUserAuth(HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userAuthMapper.selectUserAuth(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public void updateInsertUserAuth(HashMap<String, Object> map) throws Exception {
//		userAuthMapper.updateInsertUserAuth(map);
		int execute = 0;
		execute = userAuthMapper.updateUserAuth(map);
		logger.debug("update =====================> " + execute);
		if(execute <= 0) {
			execute = userAuthMapper.insertUserAuth(map);
			logger.debug("insert =====================> " + execute);
		}
	}

	@Override
	public List<HashMap<String, Object>> getUserAuth(HashMap<String, Object> map) throws Exception {
		return userAuthMapper.getUserAuth(map);
	}
}

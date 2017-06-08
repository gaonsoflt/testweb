package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.SystemMgrUserAuthService;

@Service("systemMgrUserAuthService")
public class SystemMgrUserAuthServiceImpl implements SystemMgrUserAuthService {
	
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
		userAuthMapper.updateInsertUserAuth(map);
	}

	@Override
	public List<HashMap<String, Object>> getUserAuth(HashMap<String, Object> map) throws Exception {
		return userAuthMapper.getUserAuth(map);
	}
}

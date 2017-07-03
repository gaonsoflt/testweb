package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.systemmgr.service.SystemMgrUserGroupService;
import egovframework.systemmgr.service.SystemMgrUserService;

@Service("systemMgrUserGroupService")
public class SystemMgrUserGroupServiceImpl implements SystemMgrUserGroupService {
	Logger logger = LoggerFactory.getLogger(SystemMgrUserGroupServiceImpl.class);

	@Resource(name = "systemMgrUserGroupMapper")
	private SystemMgrUserGroupMapper userGroupMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	

	@Override
	public HashMap<String, Object> getNoGroupUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.readNoGroupUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public HashMap<String, Object> getGroupUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.readGroupUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public HashMap<String, Object> getGroupByUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.readGroupByUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
	
	@Override
	public HashMap<String, Object> getGroupByLoginUser() {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_seq", userService.getLoginUserInfo().getUserseq());
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.readGroupByUser(param);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public int updateGroupUser(HashMap<String, Object> map) throws Exception {
		int executeCnt = 0;
		String group_id;
		userGroupMapper.deleteGroupUser(map);
		group_id = map.get("group_id").toString();
		List<Map<String, Object>> users = EgovWebUtil.parseJsonToList(map.get("users").toString());
		for (Map<String, Object> param : users) {
			param.put("group_id", group_id);
			executeCnt = userGroupMapper.updateInsertGroupUser((HashMap<String, Object>) param);
		}
		return executeCnt;
	}

	@Override
	public int deleteGroupUser(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}

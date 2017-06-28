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

@Service("systemMgrUserGroupService")
public class SystemMgrUserGroupServiceImpl implements SystemMgrUserGroupService {
	Logger logger = LoggerFactory.getLogger(SystemMgrUserGroupServiceImpl.class);

	@Resource(name = "systemMgrUserGroupMapper")
	private SystemMgrUserGroupMapper userGroupMapper;

	@Override
	public HashMap<String, Object> readNoGroupUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.selectNoGroupUser(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}

	@Override
	public HashMap<String, Object> readGroupUser(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			List<HashMap<String, Object>> rtnList = userGroupMapper.selectGroupUser(map);
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
	public int deleteGroupUser(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}
}

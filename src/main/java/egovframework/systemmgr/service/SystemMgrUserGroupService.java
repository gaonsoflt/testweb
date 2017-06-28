package egovframework.systemmgr.service;

import java.util.HashMap;

public interface SystemMgrUserGroupService {

	public HashMap<String, Object> readNoGroupUser(HashMap<String, Object> map);
	
	public HashMap<String, Object> readGroupUser(HashMap<String, Object> map);
	
	public int updateGroupUser(HashMap<String, Object> map) throws Exception;	
	
	public int deleteGroupUser(HashMap<String, Object> map);
}

package egovframework.systemmgr.service;

import java.util.HashMap;

public interface SystemMgrUserGroupService {

	public HashMap<String, Object> getNoGroupUser(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> getGroupUser(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> getGroupByUser(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> getGroupByLoginUser() throws Exception;
	
	public int updateGroupUser(HashMap<String, Object> map) throws Exception;	
	
	public int deleteGroupUser(HashMap<String, Object> map)  throws Exception;
}

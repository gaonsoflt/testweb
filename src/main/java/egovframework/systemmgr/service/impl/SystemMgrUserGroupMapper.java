package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("systemMgrUserGroupMapper")
public interface SystemMgrUserGroupMapper {

	public List<HashMap<String, Object>> readNoGroupUser(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readGroupUser(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> readGroupByUser(HashMap<String, Object> map) throws Exception;
	
	public int updateInsertGroupUser(HashMap<String, Object> map) throws Exception;
	
	public int deleteGroupUser(HashMap<String, Object> map) throws Exception;
}

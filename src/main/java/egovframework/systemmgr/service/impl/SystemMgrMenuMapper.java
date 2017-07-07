package egovframework.systemmgr.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.systemmgr.dao.SystemMgrMenuVO;

@Mapper("systemMgrMenuMapper")
public interface SystemMgrMenuMapper {

	public List<Map<String, Object>> selectMenuInfo(Map<String, Object> map) throws Exception;
	
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(Map<String, Object> map) throws Exception;
	
	public SystemMgrMenuVO getMenuInfo(Map<String, Object> map) throws Exception;
	
	public int createMenuInfo(Map<String, Object> map) throws Exception;
	
	public int updateMenuInfo(Map<String, Object> map) throws Exception;
	
	public int deleteMenuInfo(Map<String, Object> map) throws Exception;
	
	public int deleteMenuInfoByBBS(Map<String, Object> map) throws Exception;
}

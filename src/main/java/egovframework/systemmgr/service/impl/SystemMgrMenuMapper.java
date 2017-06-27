package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.systemmgr.dao.SystemMgrMenuVO;

@Mapper("systemMgrMenuMapper")
public interface SystemMgrMenuMapper {

	public List<HashMap<String, Object>> selectMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(HashMap<String, Object> map) throws Exception;
	
	public SystemMgrMenuVO getMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void createMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMenuInfo(HashMap<String, Object> map) throws Exception;
}

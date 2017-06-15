package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMgrLoginHistoryMapper")
public interface SystemMgrLoginHistoryMapper {

	public List<HashMap<String, Object>> selectLoginHistory(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception;
	
	public int insertLoginHistory(HashMap<String, Object> map) throws Exception;
	/*
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception; 
	*/
}

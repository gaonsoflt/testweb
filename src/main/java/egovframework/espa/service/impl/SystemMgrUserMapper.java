package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMgrUserMapper")
public interface SystemMgrUserMapper {
	
	public List<HashMap<String, Object>> selectSystemMgrUserInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMgrUserInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception; 
}

package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMngLoginLogMapper")
public interface SystemMngLoginLogMapper {

	public List<HashMap<String, Object>> selectSystemMngLoginLog(HashMap<String, Object> map) throws Exception;
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception;
	/*	
	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception; 
	*/
}

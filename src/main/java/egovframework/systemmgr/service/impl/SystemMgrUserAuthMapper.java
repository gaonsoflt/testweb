package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("systemMgrUserAuthMapper")
public interface SystemMgrUserAuthMapper {

	public List<HashMap<String, Object>> selectUserAuthByUserType(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectUserAuth(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserAuth(HashMap<String, Object> map) throws Exception;
	
	public void updateInsertUserAuth(HashMap<String, Object> map) throws Exception;
	
	public int updateUserAuth(HashMap<String, Object> map) throws Exception;
	
	public int insertUserAuth(HashMap<String, Object> map) throws Exception;
}

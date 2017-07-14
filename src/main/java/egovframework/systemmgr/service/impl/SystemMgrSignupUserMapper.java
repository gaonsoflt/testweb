package egovframework.systemmgr.service.impl;

import java.util.Map;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMgrSignupUserMapper")
public interface SystemMgrSignupUserMapper {
	
	public List<Map<String, Object>> readSignupUserList(Map<String, Object> map) throws Exception;
	
	public int readSignupUserListCount(Map<String, Object> map) throws Exception;
	
	public int existUserID(Map<String, Object> map) throws Exception;
	
	public int createSignupUser(Map<String, Object> map) throws Exception;
	
	public int deleteSignupUser(Map<String, Object> map) throws Exception;
	
	public int approvalSignupUser(Map<String, Object> map) throws Exception;
	
	public int confirmEmail(Map<String, Object> map) throws Exception;
}

package egovframework.systemmgr.service;

import java.util.List;
import java.util.Map;

public interface SystemMgrSignupUserService {

	public List<Map<String, Object>> getSignupUserList(Map<String, Object> param) throws Exception;
	
	public boolean existSignupUser(Map<String, Object> param) throws Exception;
	
	public int getSignupUserListCount(Map<String, Object> param) throws Exception;
	
	public int registerSignupUser(Map<String, Object> param) throws Exception;
	
	public int approveSignupUser(String userID, boolean approval) throws Exception;
	
	public int deleteSignupUser(Map<String, Object> param) throws Exception;
	
	public boolean confirmEmail(String uuid) throws Exception;
}

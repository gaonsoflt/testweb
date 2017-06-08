package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMgrUserAuthService {

	public List<HashMap<String, Object>> selectUserAuthByUserType(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> selectUserAuth(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserAuth(HashMap<String, Object> map) throws Exception;
	
	public void updateInsertUserAuth(HashMap<String, Object> map) throws Exception;
}

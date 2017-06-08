package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMgrMenuService {

	public List<HashMap<String, Object>> selectMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void createMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMenuInfo(HashMap<String, Object> map) throws Exception;
}

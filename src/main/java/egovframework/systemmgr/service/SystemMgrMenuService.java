package egovframework.systemmgr.service;

import java.util.HashMap;
import java.util.List;

import egovframework.systemmgr.dao.SystemMgrMenuVO;

public interface SystemMgrMenuService {

	public List<HashMap<String, Object>> selectMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(HashMap<String, Object> map) throws Exception;
	
	
	public void createMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMenuInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMenuInfo(HashMap<String, Object> map) throws Exception;
	
	
	// cache menu info
	public List<SystemMgrMenuVO> getMenuVo();
	
	public SystemMgrMenuVO getMenuVo(String menuId);
	
	public void refreshCachedMenu(HashMap<String, Object> param) throws Exception;
	public void refreshCachedMenu() throws Exception;
}

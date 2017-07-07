package egovframework.systemmgr.service;

import java.util.Map;
import java.util.List;

import egovframework.systemmgr.dao.SystemMgrMenuVO;

public interface SystemMgrMenuService {

	public List<Map<String, Object>> selectMenuInfo(Map<String, Object> map) throws Exception;
	
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(Map<String, Object> map) throws Exception;
	
	
	public void createMenuInfo(Map<String, Object> map) throws Exception;
	
	public void updateMenuInfo(Map<String, Object> map) throws Exception;
	
	public void deleteMenuInfo(Map<String, Object> map) throws Exception;
	
	
	// cache menu info
	public List<SystemMgrMenuVO> getMenuVo();
	
	public SystemMgrMenuVO getMenuVo(String menuId);
	
	public void refreshCachedMenu(Map<String, Object> param) throws Exception;
	public void refreshCachedMenu() throws Exception;
}

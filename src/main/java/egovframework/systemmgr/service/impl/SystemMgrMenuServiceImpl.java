package egovframework.systemmgr.service.impl;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.systemmgr.dao.SystemMgrMenuVO;
import egovframework.systemmgr.service.SystemMgrMenuService;
import egovframework.systemmgr.service.SystemMgrUserService;

@Service("systemMgrMenuService")
public class SystemMgrMenuServiceImpl implements SystemMgrMenuService {
	Logger logger = LoggerFactory.getLogger(SystemMgrMenuServiceImpl.class.getName());

	@Resource(name = "systemMgrMenuMapper")
	private SystemMgrMenuMapper menuInfoMapper;
	
	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;
	
	private List<SystemMgrMenuVO> menuVo;
	
	@Override
	public List<SystemMgrMenuVO> getMenuVo() {
		return menuVo;
	}

	@Override
	public SystemMgrMenuVO getMenuVo(String menuId) {
		int idx = getMenuVo().indexOf(new SystemMgrMenuVO(menuId));
		if(idx < 0)
			return null;
		return getMenuVo().get(idx);
	}

	@Override
	public void refreshCachedMenu() throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("USER_NO", userService.getLoginUserInfo().getUserseq());
		refreshCachedMenu(param);
	}
	
	@Override
	public void refreshCachedMenu(Map<String, Object> map) throws Exception {
		logger.debug("refresh cached menu data");
		logger.debug("[BBAEK] refresh before: " + getMenuVo());
		menuVo = menuInfoMapper.getMenuInfoByUserAuth(map);
		logger.debug("[BBAEK] refresh after: " + getMenuVo());
	}
	
	@Override
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(Map<String, Object> map) throws Exception {
		if(menuVo == null) {
			refreshCachedMenu(map);
		}
		return menuVo;
	}

	@Override
	public List<Map<String, Object>> selectMenuInfo(Map<String, Object> map) throws Exception {
		return menuInfoMapper.selectMenuInfo(map);
	}

	@Override
	public void createMenuInfo(Map<String, Object> map) throws Exception {
		menuInfoMapper.createMenuInfo(map);
    	refreshCachedMenu();
	}

	@Override
	public void updateMenuInfo(Map<String, Object> map) throws Exception {
		menuInfoMapper.updateMenuInfo(map);
    	refreshCachedMenu();
	}

	@Override
	public void deleteMenuInfo(Map<String, Object> map) throws Exception {
		menuInfoMapper.deleteMenuInfo(map);
    	refreshCachedMenu();
	}
}

package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.systemmgr.dao.SystemMgrMenuVO;
import egovframework.systemmgr.service.SystemMgrMenuService;

@Service("systemMgrMenuService")
public class SystemMgrMenuServiceImpl implements SystemMgrMenuService {
	Logger logger = LoggerFactory.getLogger(SystemMgrMenuServiceImpl.class.getName());

	@Resource(name = "systemMgrMenuMapper")
	private SystemMgrMenuMapper menuInfoMapper;
	
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
	public void refreshMenu(HashMap<String, Object> param) throws Exception {
		logger.debug("refresh cached menu data");
		menuVo = menuInfoMapper.getMenuInfoByUserAuth(param);
	}
	
	@Override
	public List<SystemMgrMenuVO> getMenuInfoByUserAuth(HashMap<String, Object> map) throws Exception {
		if(menuVo == null) {
			refreshMenu(map);
		}
		return menuVo;
	}

	@Override
	public List<HashMap<String, Object>> selectMenuInfo(HashMap<String, Object> map) throws Exception {
		return menuInfoMapper.selectMenuInfo(map);
	}

	@Override
	public void createMenuInfo(HashMap<String, Object> map) throws Exception {
		menuInfoMapper.createMenuInfo(map);
	}

	@Override
	public void updateMenuInfo(HashMap<String, Object> map) throws Exception {
		menuInfoMapper.updateMenuInfo(map);
	}

	@Override
	public void deleteMenuInfo(HashMap<String, Object> map) throws Exception {
		menuInfoMapper.deleteMenuInfo(map);
	}
}

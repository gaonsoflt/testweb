package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.systemmgr.service.SystemMgrMenuService;
import egovframework.urtown.service.MediConsultService;
import egovframework.urtown.service.MediConsultVO;

@Service("systemMgrMenuService")
public class SystemMgrMenuServiceImpl implements SystemMgrMenuService {
	
	@Resource(name = "systemMgrMenuMapper")
	private SystemMgrMenuMapper menuInfoMapper;

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

	@Override
	public List<HashMap<String, Object>> getMenuInfo(HashMap<String, Object> map) throws Exception {
		return menuInfoMapper.getMenuInfo(map);
	}
}

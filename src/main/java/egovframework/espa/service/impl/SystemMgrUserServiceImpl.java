package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.service.SystemMgrUserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("systemMgrUserService")
public class SystemMgrUserServiceImpl extends EgovAbstractServiceImpl implements SystemMgrUserService { 
	
	@Resource(name = "systemMgrUserMapper")
	private SystemMgrUserMapper systemMgrUserMapper;
	
	public List<HashMap<String, Object>> selectSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		return systemMgrUserMapper.selectSystemMgrUserInfo(map);
	}	
	public int selectSystemMngUserInfoTot(HashMap<String, Object> map) throws Exception{
		return systemMgrUserMapper.selectSystemMgrUserInfoTot(map); 
	}

	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMgrUserMapper.insertSystemMngUserInfo(map);
	}
	
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMgrUserMapper.updateSystemMngUserInfo(map);
	}
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception{
		systemMgrUserMapper.updateMngPassInfo(map);
	}
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMgrUserMapper.deleteSystemMngUserInfo(map);
	}
}
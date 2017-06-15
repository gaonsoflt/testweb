package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.systemmgr.service.SystemMgrLoginHistoryService;


@Service("systemMgrLoginHistoryService")
public class SystemMgrLoginHistoryServiceImpl implements SystemMgrLoginHistoryService { 
	
	@Resource(name = "systemMgrLoginHistoryMapper")
	private SystemMgrLoginHistoryMapper systemMngLoginLogMapper;
	
	public List<HashMap<String, Object>> selectLoginHistory(HashMap<String, Object> map) throws Exception{
		return systemMngLoginLogMapper.selectLoginHistory(map);
	}
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception{
		return systemMngLoginLogMapper.selectSystemMngLoginLogTot(map); 
	}

	public int insertLoginHistory(HashMap<String, Object> map) throws Exception{
		return systemMngLoginLogMapper.insertLoginHistory(map);
	}
	/*
	public void updateSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.updateSystemMngUserInfo(map);
	}
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.updateMngPassInfo(map);
	}
	
	public void deleteSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.deleteSystemMngUserInfo(map);
	}
	*/
}
package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.SystemMngLoginLogService;


@Service("systemMngLoginLogService")
public class SystemMngLoginLogServiceImpl implements SystemMngLoginLogService { 
	
	
	 
	@Resource(name = "systemMngLoginLogMapper")
	private SystemMngLoginLogMapper systemMngLoginLogMapper;
	
	public List<HashMap<String, Object>> selectSystemMngLoginLog(HashMap<String, Object> map) throws Exception{
		return systemMngLoginLogMapper.selectSystemMngLoginLog(map);
	}
	
	public int selectSystemMngLoginLogTot(HashMap<String, Object> map) throws Exception{
		return systemMngLoginLogMapper.selectSystemMngLoginLogTot(map); 
	}
	/*

	public void insertSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		systemMngUserMapper.insertSystemMngUserInfo(map);
	}
	
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
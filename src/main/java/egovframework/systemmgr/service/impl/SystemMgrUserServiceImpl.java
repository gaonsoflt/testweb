package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import egovframework.com.login.service.CmmLoginUser;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;


@Service("systemMgrUserService")
public class SystemMgrUserServiceImpl extends EgovAbstractServiceImpl implements SystemMgrUserService { 
	
	@Resource(name = "systemMgrUserMapper")
	private SystemMgrUserMapper systemMgrUserMapper;
	
	@Resource(name = "systemMgrUserGroupMapper")
	private SystemMgrUserGroupMapper userGroupMapper;
	
	public CmmLoginUser getLoginUserInfo() {
		CmmLoginUser userDetails = (CmmLoginUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return userDetails;
	}
	
	public List<HashMap<String, Object>> selectSystemMngUserInfo(HashMap<String, Object> map) throws Exception{
		List<HashMap<String, Object>> rtn = systemMgrUserMapper.selectSystemMgrUserInfo(map);
//		for (int i = 0; i < rtn.size(); i++) {
//			rtn.get(i).put("groups", userGroupMapper.selectGroupByUser(rtn.get(i)));
//		}
		return rtn;
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
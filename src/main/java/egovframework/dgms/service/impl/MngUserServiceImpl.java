package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngUserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("mngUserService")
public class MngUserServiceImpl extends EgovAbstractServiceImpl implements MngUserService { 
	
	@Resource(name = "mngUserMapper")
	private MngUserMapper mngUserMapper;
	
	public List<HashMap<String, Object>> selectMngUserInfo(HashMap<String, Object> map) throws Exception{
		return mngUserMapper.selectMngUserInfo(map);
	}
	
	public int selectMngUserInfoTot(HashMap<String, Object> map) throws Exception{
		return mngUserMapper.selectMngUserInfoTot(map); 
	}
	

	public void insertMngUserInfo(HashMap<String, Object> map) throws Exception{
		mngUserMapper.insertMngUserInfo(map);
	}
	
	public void updateMngUserInfo(HashMap<String, Object> map) throws Exception{
		mngUserMapper.updateMngUserInfo(map);
	}
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception{
		mngUserMapper.updateMngPassInfo(map);
		
		
		
	}
	
	public void deleteMngUserInfo(HashMap<String, Object> map) throws Exception{
		mngUserMapper.deleteMngUserInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectMngUserMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngUserMapper.selectMngUserMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngUserMapper.selectCdNmCombo(map);
	}
*/

	
}
package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngGrpService;


@Service("mngGrpService")
public class MngGrpServiceImpl implements MngGrpService { 
	
	@Resource(name = "mngGrpMapper")
	private MngGrpMapper mngGrpMapper;
	
	public List<HashMap<String, Object>> selectMngGrpInfo(HashMap<String, Object> map) throws Exception{
		return mngGrpMapper.selectMngGrpInfo(map);
	}
	
	public int selectMngGrpInfoTot(HashMap<String, Object> map) throws Exception{
		return mngGrpMapper.selectMngGrpInfoTot(map); 
	}
	

	public void insertMngGrpInfo(HashMap<String, Object> map) throws Exception{
		mngGrpMapper.insertMngGrpInfo(map);
	}
	
	public void updateMngGrpInfo(HashMap<String, Object> map) throws Exception{
		mngGrpMapper.updateMngGrpInfo(map);
	}
	
	public void deleteMngGrpInfo(HashMap<String, Object> map) throws Exception{
		mngGrpMapper.deleteMngGrpInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectMngGrpMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngGrpMapper.selectMngGrpMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngGrpMapper.selectCdNmCombo(map);
	}
*/

	
}
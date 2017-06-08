package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngFaultService;


@Service("mngFaultService")
public class MngFaultServiceImpl implements MngFaultService { 
	
	@Resource(name = "mngFaultMapper")
	private MngFaultMapper mngFaultMapper;
	
	public List<HashMap<String, Object>> selectMngFaultInfo(HashMap<String, Object> map) throws Exception{
		return mngFaultMapper.selectMngFaultInfo(map);
	}
	
	public int selectMngFaultInfoTot(HashMap<String, Object> map) throws Exception{
		return mngFaultMapper.selectMngFaultInfoTot(map); 
	}
	

	public void insertMngFaultInfo(HashMap<String, Object> map) throws Exception{
		mngFaultMapper.insertMngFaultInfo(map);
	}
	
	public void updateMngFaultInfo(HashMap<String, Object> map) throws Exception{
		mngFaultMapper.updateMngFaultInfo(map);
	}
	
	public void deleteMngFaultInfo(HashMap<String, Object> map) throws Exception{
		mngFaultMapper.deleteMngFaultInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectMngFaultMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngFaultMapper.selectMngFaultMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngFaultMapper.selectCdNmCombo(map);
	}
*/

	
}
package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngCodeService;


@Service("mngCodeService")
public class MngCodeServiceImpl implements MngCodeService {
	
	@Resource(name = "mngCodeMapper")
	private MngCodeMapper mngCodeMapper;
	
	public List<HashMap<String, Object>> selectMngCodeInfo(HashMap<String, Object> map) throws Exception{
		return mngCodeMapper.selectMngCodeInfo(map);
	}
	
	public int selectMngCodeInfoTot(HashMap<String, Object> map) throws Exception{
		return mngCodeMapper.selectMngCodeInfoTot(map); 
	}
	
	public List<HashMap<String, Object>> selectMngCodeInfoCombo(HashMap<String, Object> map) throws Exception{
		return mngCodeMapper.selectMngCodeInfoCombo(map);
	}
	
	public void insertMngCodeInfo(HashMap<String, Object> map) throws Exception{
		mngCodeMapper.insertMngCodeInfo(map);
	}
	
	public void updateMngCodeInfo(HashMap<String, Object> map) throws Exception{
		mngCodeMapper.updateMngCodeInfo(map);
	}
	
	public void deleteMngCodeInfo(HashMap<String, Object> map) throws Exception{
		mngCodeMapper.deleteMngCodeInfo(map);
	}
	
	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngCodeMapper.selectMngCodeMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngCodeMapper.selectCdNmCombo(map);
	}


	
}
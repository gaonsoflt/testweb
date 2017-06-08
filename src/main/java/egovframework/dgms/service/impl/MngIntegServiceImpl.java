package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngIntegService;


@Service("mngIntegService")
public class MngIntegServiceImpl implements MngIntegService { 
	
	@Resource(name = "mngIntegMapper")
	private MngIntegMapper mngIntegMapper;
 

	@Override
	public List<HashMap<String, Object>> selectMngIntegDetailInfoJsonp(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectMngIntegDetailInfoJsonp(map);
	}
	
	public int selectMngIntegInfoTot(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectMngIntegInfoTot(map); 
	}
	
/*
	
	public List<HashMap<String, Object>> selectMngIntegInfo(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectMngIntegInfo(map);
	}
	
	public int selectMngIntegInfoTot(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectMngIntegInfoTot(map); 
	}
	

	public void insertMngIntegInfo(HashMap<String, Object> map) throws Exception{
		mngIntegMapper.insertMngIntegInfo(map);
	}
	
	public void updateMngIntegInfo(HashMap<String, Object> map) throws Exception{
		mngIntegMapper.updateMngIntegInfo(map);
	}
	
	public void deleteMngIntegInfo(HashMap<String, Object> map) throws Exception{
		mngIntegMapper.deleteMngIntegInfo(map);
	}
	
	public List<HashMap<String, Object>> selectMngIntegMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectMngIntegMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngIntegMapper.selectCdNmCombo(map);
	}
*/

	
}
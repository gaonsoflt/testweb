package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MyPrescriptService;

@Service("myPrescriptService")
public class MyPrescriptServiceImpl implements MyPrescriptService {

	@Resource(name = "myPrescriptMapper")
	private MyPrescriptMapper myPrescriptMapper;

	@Override
	public List<HashMap<String, Object>> selectMyPrescriptMasterInfo (HashMap<String, Object> map) throws Exception{
		return myPrescriptMapper.selectMyPrescriptMasterInfo(map);
	}

	@Override
	public List<HashMap<String, Object>> selectMyPrescriptInfo(HashMap<String, Object> map) throws Exception {
		return myPrescriptMapper.selectMyPrescriptInfo(map);
	} 
	
	@Override
	public Object selectMyPrescriptInfoTot(HashMap<String, Object> map) throws Exception {
		return myPrescriptMapper.selectMyPrescriptInfoTot(map);
	}

	@Override
	public void insertMyPrescriptInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.insertMyPrescriptInfo(map);
	}

	@Override
	public void deleteMyPrescriptInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.deleteMyPrescriptInfo(map);
	}

	@Override
	public void updateMyPrescriptInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.updateMyPrescriptInfo(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception {
		return myPrescriptMapper.selectMyPrescriptMedcInfo(map);
	} 
	
	@Override
	public Object selectMyPrescriptMedcInfoTot(HashMap<String, Object> map) throws Exception {
		return myPrescriptMapper.selectMyPrescriptMedcInfoTot(map);
	}

	@Override
	public void insertMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.insertMyPrescriptMedcInfo(map);
	}

	@Override
	public void deleteMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.deleteMyPrescriptMedcInfo(map);
	}

	@Override
	public void updateMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception {
		myPrescriptMapper.updateMyPrescriptMedcInfo(map);
	}
	public List<HashMap<String, Object>> selectdosageData(HashMap<String,Object> paramMap) throws Exception {
		return myPrescriptMapper.selectdosageData(paramMap);
	}
	public List<HashMap<String, Object>> selectdosagealarmData(HashMap<String,Object> paramMap) throws Exception {
		return myPrescriptMapper.selectdosagealarmData(paramMap);
	}
}

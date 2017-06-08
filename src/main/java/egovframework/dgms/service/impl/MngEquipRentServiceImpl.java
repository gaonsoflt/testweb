package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngEquipRentService;


@Service("mngEquipRentService")
public class MngEquipRentServiceImpl implements MngEquipRentService { 
	
	@Resource(name = "mngEquipRentMapper")
	private MngEquipRentMapper mngEquipRentMapper;
	
	public List<HashMap<String, Object>> selectMngEquipRentInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipRentMapper.selectMngEquipRentInfo(map);
	}
	
	public int selectMngEquipRentInfoTot(HashMap<String, Object> map) throws Exception{
		return mngEquipRentMapper.selectMngEquipRentInfoTot(map); 
	}
	

	public void insertMngEquipRentInfo(HashMap<String, Object> map) throws Exception{
		mngEquipRentMapper.insertMngEquipRentInfo(map);
	}
	
	public void updateMngEquipRentInfo(HashMap<String, Object> map) throws Exception{
		mngEquipRentMapper.updateMngEquipRentInfo(map);
	}
	
	public void deleteMngEquipRentInfo(HashMap<String, Object> map) throws Exception{
		mngEquipRentMapper.deleteMngEquipRentInfo(map);
	}
	
	public List<HashMap<String, Object>> getUserListByUserID(HashMap<String, Object> map) throws Exception{
		return mngEquipRentMapper.getUserListByUserID(map);
	}

	@Override
	public List<HashMap<String, Object>> selectMngEquipInfoRent(HashMap<String, Object> paramMap) throws Exception {
		return mngEquipRentMapper.selectMngEquipInfoRent(paramMap);
	}

	@Override
	public int selectMngEquipInfoRentTot(HashMap<String, Object> paramMap) throws Exception {
		return mngEquipRentMapper.selectMngEquipInfoRentTot(paramMap);
	}
	
/*	public List<HashMap<String, Object>> selectMngEquipRentMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipRentMapper.selectMngEquipRentMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngEquipRentMapper.selectCdNmCombo(map);
	}
*/

	
}
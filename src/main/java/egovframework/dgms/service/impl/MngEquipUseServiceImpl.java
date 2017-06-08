package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngEquipUseService;


@Service("mngEquipUseService")
public class MngEquipUseServiceImpl implements MngEquipUseService { 
	
	@Resource(name = "mngEquipUseMapper")
	private MngEquipUseMapper mngEquipUseMapper;
	
	public List<HashMap<String, Object>> selectMngEquipUseInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipUseMapper.selectMngEquipUseInfo(map);
	}
	
	public int selectMngEquipUseInfoTot(HashMap<String, Object> map) throws Exception{
		return mngEquipUseMapper.selectMngEquipUseInfoTot(map); 
	}
	

	public void insertMngEquipUseInfo(HashMap<String, Object> map) throws Exception{
		mngEquipUseMapper.insertMngEquipUseInfo(map);
	}
	
	public void updateMngEquipUseInfo(HashMap<String, Object> map) throws Exception{
		mngEquipUseMapper.updateMngEquipUseInfo(map);
	}
	
	public void deleteMngEquipUseInfo(HashMap<String, Object> map) throws Exception{
		mngEquipUseMapper.deleteMngEquipUseInfo(map);
	}
	
	public List<HashMap<String, Object>> getUserListByUserID(HashMap<String, Object> map) throws Exception{
		return mngEquipUseMapper.getUserListByUserID(map);
	}
	
/*	public List<HashMap<String, Object>> selectMngEquipUseMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipUseMapper.selectMngEquipUseMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngEquipUseMapper.selectCdNmCombo(map);
	}
*/

	
}
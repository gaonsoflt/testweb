package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngEquipService;


@Service("mngEquipService")
public class MngEquipServiceImpl implements MngEquipService { 
	
	@Resource(name = "mngEquipMapper")
	private MngEquipMapper mngEquipMapper;
	
	public List<HashMap<String, Object>> selectMngEquipInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipMapper.selectMngEquipInfo(map);
	}
	
	public int selectMngEquipInfoTot(HashMap<String, Object> map) throws Exception{
		return mngEquipMapper.selectMngEquipInfoTot(map); 
	}
	

	public void insertMngEquipInfo(HashMap<String, Object> map) throws Exception{
		mngEquipMapper.insertMngEquipInfo(map);
	}
	
	public void updateMngEquipInfo(HashMap<String, Object> map) throws Exception{
		mngEquipMapper.updateMngEquipInfo(map);
	}
	
	public void deleteMngEquipInfo(HashMap<String, Object> map) throws Exception{
		mngEquipMapper.deleteMngEquipInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectMngEquipMasterInfo(HashMap<String, Object> map) throws Exception{
		return mngEquipMapper.selectMngEquipMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return mngEquipMapper.selectCdNmCombo(map);
	}
*/

	
}
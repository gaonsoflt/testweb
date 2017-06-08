package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngEquipMapper")
public interface MngEquipMapper {
	
	public List<HashMap<String, Object>> selectMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngEquipInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngEquipInfo(HashMap<String, Object> map) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

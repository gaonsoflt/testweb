package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngEquipUseMapper")
public interface MngEquipUseMapper {
	
	public List<HashMap<String, Object>> selectMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngEquipUseInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngEquipUseInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserListByUserID(HashMap<String, Object> map) throws Exception;
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

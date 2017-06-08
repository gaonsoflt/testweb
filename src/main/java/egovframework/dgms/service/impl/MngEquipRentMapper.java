package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngEquipRentMapper")
public interface MngEquipRentMapper {
	
	public List<HashMap<String, Object>> selectMngEquipRentInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngEquipRentInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngEquipRentInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngEquipRentInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngEquipRentInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserListByUserID(HashMap<String, Object> map) throws Exception;

	public List<HashMap<String, Object>> selectMngEquipInfoRent(HashMap<String, Object> paramMap) throws Exception;

	public int selectMngEquipInfoRentTot(HashMap<String, Object> paramMap) throws Exception;
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

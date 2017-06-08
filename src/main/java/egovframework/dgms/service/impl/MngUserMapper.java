package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngUserMapper")
public interface MngUserMapper {
	
	public List<HashMap<String, Object>> selectMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngUserInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngPassInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngUserInfo(HashMap<String, Object> map) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

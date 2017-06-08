package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngIntegMapper")
public interface MngIntegMapper {
	
	public List<HashMap<String, Object>> selectMngIntegDetailInfoJsonp(HashMap<String, Object> map) throws Exception;
	
	public int selectMngIntegInfoTot(HashMap<String, Object> map) throws Exception;
	 
/*	 
	
	public void insertMngIntegInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngIntegInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngIntegInfo(HashMap<String, Object> map) throws Exception;
 	
 	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

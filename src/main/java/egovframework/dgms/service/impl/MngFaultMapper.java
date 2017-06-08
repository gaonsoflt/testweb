package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("mngFaultMapper")
public interface MngFaultMapper {
	
	public List<HashMap<String, Object>> selectMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngFaultInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngFaultInfo(HashMap<String, Object> map) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

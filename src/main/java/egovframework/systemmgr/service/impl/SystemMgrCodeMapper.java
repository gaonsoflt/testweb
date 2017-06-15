package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMgrCodeMapper")
public interface SystemMgrCodeMapper {
	
	public List<HashMap<String, Object>> selectMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngCodeInfoTot(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMngCodeInfoCombo(HashMap<String, Object> map) throws Exception;
	
	public int insertMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public int updateMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public int deleteMngCodeInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;
	
}

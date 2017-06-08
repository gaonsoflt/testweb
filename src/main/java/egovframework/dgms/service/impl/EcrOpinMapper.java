package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("ecrOpinMapper")
public interface EcrOpinMapper {
	
	public List<HashMap<String, Object>> selectEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectEcrOpinInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteEcrOpinInfo(HashMap<String, Object> map) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

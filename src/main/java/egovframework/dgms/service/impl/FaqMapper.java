package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("faqMapper")
public interface FaqMapper {
	
	public List<HashMap<String, Object>> selectFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectFaqInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateFaqInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteFaqInfo(HashMap<String, Object> map) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

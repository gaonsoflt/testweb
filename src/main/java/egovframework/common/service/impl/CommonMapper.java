package egovframework.common.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("commonMapper")
public interface CommonMapper {
	
	public String getSequence(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getCodeListByCdID(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getAutoComplete(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getAutoCompleteNew(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getUserAutoComplete(HashMap<String, Object> map) throws Exception;

	public int getDuplicateCount(HashMap<String, Object> map) throws Exception;
	
}

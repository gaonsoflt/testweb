package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.espa.dao.ESPAConfigVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("eSPAConfigMapper")
public interface ESPAConfigMapper {
	
	public List<HashMap<String, Object>> selectESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public List<ESPAConfigVO> selectAllESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int selectESPAConfigAllTot(HashMap<String, Object> map) throws Exception;
	
	public int insertESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int updateESPAConfig(HashMap<String, Object> map) throws Exception;
	
	public int deleteESPAConfig(HashMap<String, Object> map) throws Exception; 
}

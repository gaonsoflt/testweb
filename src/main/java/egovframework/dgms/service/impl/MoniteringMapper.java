package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("moniteringMapper")
public interface MoniteringMapper {

	public List<HashMap<String, Object>> selectChartDataMornitering(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMorniteringData1(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMorniteringData2(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMorniteringData3(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMorniteringDataCNT1(HashMap<String, Object> map) throws Exception;
	
	public int selectMorniteringData3Tot(HashMap<String, Object> map) throws Exception;
}
 
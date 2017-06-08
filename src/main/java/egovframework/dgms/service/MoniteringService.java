package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MoniteringService {

	List<HashMap<String, Object>> selectChartDataMornitering(HashMap<String, Object> map) throws Exception;	
	
	List<HashMap<String, Object>> selectMorniteringData1(HashMap<String, Object> map) throws Exception;
	
	List<HashMap<String, Object>> selectMorniteringData2(HashMap<String, Object> map) throws Exception;	
	
	List<HashMap<String, Object>> selectMorniteringData3(HashMap<String, Object> map) throws Exception;	

	List<HashMap<String, Object>> selectMorniteringDataCNT1(HashMap<String, Object> map) throws Exception;
	
	int selectMorniteringData3Tot(HashMap<String, Object> map) throws Exception;		
} 

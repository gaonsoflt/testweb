package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface DataMedcService {
 
	public List<HashMap<String, Object>> selectDataMedcInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectDataMedcInfoTot(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectChartDataMedcDetailInfo(HashMap<String, Object> map) throws Exception;
	/**
	 * 해당일자에 측정된 약상자 데이터 조회
	 * @param paramMap -조회할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledaymedcData(HashMap<String,Object> paramMap) throws Exception;
	
	/*public void insertDataMedcInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateDataMedcInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteDataMedcInfo(HashMap<String, Object> map) throws Exception;*/
	

    
}

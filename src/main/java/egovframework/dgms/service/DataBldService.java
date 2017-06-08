package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface DataBldService {
 
	public List<HashMap<String, Object>> selectDataBldInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectDataBldInfoTot(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectChartDataBldDetailInfo(HashMap<String, Object> map) throws Exception;
	/**
	 * 해당일자에 측정된 혈압기 데이터 조회
	 * @param paramMap -조회할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledaybldData(HashMap<String,Object> paramMap) throws Exception;
/*	public void insertDataBldInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateDataBldInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteDataBldInfo(HashMap<String, Object> map) throws Exception;
	
*/
    
}

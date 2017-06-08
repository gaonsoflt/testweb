package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface DataEcgService {
 
	public List<HashMap<String, Object>> selectDataEcgInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectDataEcgInfoTot(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> selectEcgInfoBySeq(HashMap<String, Object> map) throws Exception;
	/**
	 * 해당일자에 측정된 심전도 데이터 조회
	 * @param paramMap -조회할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledayecgData(HashMap<String,Object> paramMap) throws Exception;
	
	public void insertEcgData(HashMap<String, Object> map) throws Exception;
	
	public void insertActEcgData(HashMap<String, Object> map) throws Exception;

	public List<HashMap<String, Object>> selectDataActEcgInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectDataActEcgInfoTot(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> selectActEcgInfoBySeq(HashMap<String, Object> map) throws Exception;
/*	public void insertDataEcgInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateDataEcgInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteDataEcgInfo(HashMap<String, Object> map) throws Exception;
	
*/
    
}

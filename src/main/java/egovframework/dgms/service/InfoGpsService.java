package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface InfoGpsService {

	/**
	 * GPS의 최신 정보 1건을 들고온다.
	 * @param map
	 * @return List
	 * @throws Exception
	 */
	List<HashMap<String, Object>> selectLastGPSInfo(HashMap<String, Object> map) throws Exception;	
}

package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface MyPageService {

	public List<HashMap<String, Object>> selectMyPageInfo(HashMap<String, Object> paramMap) throws Exception;

	public int selectMyPageInfoTot(HashMap<String, Object> paramMap) throws Exception;

	public void updateMyPageInfo(HashMap<String, Object> paramMap) throws Exception;

}

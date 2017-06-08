package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface CheckupResService {

	public List<HashMap<String, Object>> selectCheckupResByMap(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCheckupResByUserNo(HashMap<String, Object> map) throws Exception;

    public void createCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public void updateCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public void deleteCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public Long getNextCheckupNo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getCheckupResByUserNo(HashMap<String, Object> map) throws Exception;

	public void updateCheckupResDt(HashMap<String, Object> paramMap) throws Exception;
}

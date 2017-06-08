package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface SystemMngCctvService {

	public List<HashMap<String, Object>> selectMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngCctvInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngCctvInfo(HashMap<String, Object> map) throws Exception;

	public void updateMngCctvInfo(HashMap<String, Object> map) throws Exception;

	public void deleteMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
}

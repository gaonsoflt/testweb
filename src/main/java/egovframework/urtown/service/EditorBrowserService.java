package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface EditorBrowserService {
	
	public void saveFiles(HashMap<String, Object>map) throws Exception;

	public void removeFiles(HashMap<String, Object>map) throws Exception;
	
	public List<HashMap<String, Object>> selectFiles(HashMap<String, Object> map) throws Exception; 
}

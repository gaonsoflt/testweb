package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface MediFAQService {
	public List<HashMap<String, Object>> selectMediFAQ(HashMap<String, Object> map) throws Exception;

    public void createMediFAQ(HashMap<String, Object> map) throws Exception;
	
	public void updateMediFAQ(HashMap<String, Object> map) throws Exception;
	
	public void deleteMediFAQ(HashMap<String, Object> map) throws Exception;
}

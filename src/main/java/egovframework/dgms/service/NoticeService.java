package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface NoticeService {

	public List<HashMap<String, Object>> selectNoticeInfo(HashMap<String, Object> map) throws Exception;

	public int selectNoticeInfoTot(HashMap<String, Object> map) throws Exception;

	public void insertNoticeInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteNoticeInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateNoticeInfo(HashMap<String, Object> map) throws Exception;
    
}

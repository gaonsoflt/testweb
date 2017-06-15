package egovframework.bbs.service;

import java.util.HashMap;
import java.util.List;

public interface NoticeService {

	public List<HashMap<String, Object>> getNoticeList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getNotice(HashMap<String, Object> map) throws Exception;

	public int getNoticeAllCount(HashMap<String, Object> map) throws Exception;
	
	public int createNotice(HashMap<String, Object> map) throws Exception;
	
	public int updateNotice(HashMap<String, Object> map) throws Exception;
	
	public int deleteNotice(HashMap<String, Object> map) throws Exception;  
}

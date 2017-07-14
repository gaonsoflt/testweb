package egovframework.bbs.service;

import java.util.Map;
import java.util.List;

public interface BBSBoardService {

	public List<Map<String, Object>> getBoard(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getBoardItem(Map<String, Object> param) throws Exception;
	
	public Map<String, Object> getBoardItem(String boardID) throws Exception;

	public int getBoardCount(Map<String, Object> param) throws Exception;
	
	public int saveBoardItem(Map<String, Object> param) throws Exception;

	public int createBoardItem(Map<String, Object> param) throws Exception;
	
	public int updateBoardItem(Map<String, Object> param) throws Exception;
	
	public int deleteBoardItem(Map<String, Object> param) throws Exception;  
}

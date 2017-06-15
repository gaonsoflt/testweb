package egovframework.bbs.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("noticeMapper")
public interface NoticeMapper {
	
	public List<HashMap<String, Object>> selectNoticeList(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectNotice(HashMap<String, Object> map) throws Exception;

	public int selectNoticeAllCount(HashMap<String, Object> map) throws Exception;
	
	public int insertNotice(HashMap<String, Object> map) throws Exception;
	
	public int updateNotice(HashMap<String, Object> map) throws Exception;
	
	public int deleteNotice(HashMap<String, Object> map) throws Exception;  
}

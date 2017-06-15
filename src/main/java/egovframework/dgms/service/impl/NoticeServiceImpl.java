package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.NoticeService;


@Service("noticeService1")
public class NoticeServiceImpl implements NoticeService { 
	
	@Resource(name = "noticeMapper1")
	private NoticeMapper noticeMapper;
	
	@Override
	public List<HashMap<String, Object>> selectNoticeInfo(HashMap<String, Object> map) throws Exception {
		return noticeMapper.selectNoticeInfo(map);
	}

	@Override
	public int selectNoticeInfoTot(HashMap<String, Object> map) throws Exception {
		return noticeMapper.selectNoticeInfoTot(map); 
	}

	@Override
	public void insertNoticeInfo(HashMap<String, Object> map) throws Exception {
		noticeMapper.insertNoticeInfo(map); 
	}

	@Override
	public void deleteNoticeInfo(HashMap<String, Object> map) throws Exception {
		noticeMapper.deleteNoticeInfo(map); 
	}
	
	@Override
	public void updateNoticeInfo(HashMap<String, Object> map) throws Exception {
		noticeMapper.updateNoticeInfo(map); 
	}
	
}
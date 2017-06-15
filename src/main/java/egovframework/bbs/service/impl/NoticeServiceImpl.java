package egovframework.bbs.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.bbs.service.NoticeService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("noticeService")
public class NoticeServiceImpl extends EgovAbstractServiceImpl implements NoticeService { 
	
	@Resource(name = "noticeMapper")
	private NoticeMapper noticeMapper;
	
	@Override
	public List<HashMap<String, Object>> getNoticeList(HashMap<String, Object> map) throws Exception {
		return noticeMapper.selectNoticeList(map);
	}
	
	@Override
	public List<HashMap<String, Object>> getNotice(HashMap<String, Object> map) throws Exception {
		return noticeMapper.selectNotice(map);
	} 
	
	@Override
	public int getNoticeAllCount(HashMap<String, Object> map) throws Exception {
		return noticeMapper.selectNoticeAllCount(map);
	}
	
	@Override
	public int createNotice(HashMap<String, Object> map) throws Exception {
		return noticeMapper.insertNotice(map);
	}
	
	@Override
	public int updateNotice(HashMap<String, Object> map) throws Exception {
		return noticeMapper.updateNotice(map);
	}
	
	@Override
	public int deleteNotice(HashMap<String, Object> map) throws Exception {
		return noticeMapper.deleteNotice(map);
	}
}
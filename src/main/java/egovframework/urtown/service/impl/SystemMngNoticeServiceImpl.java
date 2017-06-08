package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.SystemMngNoticeService;


@Service("systemMngNoticeService")
public class SystemMngNoticeServiceImpl implements SystemMngNoticeService { 
	
	@Resource(name = "systemMngNoticeMapper")
	private SystemMngNoticeMapper systemMngNoticeMapper;
	
	@Override
	public List<HashMap<String, Object>> selectNoticeInfo(HashMap<String, Object> map) throws Exception {
		return systemMngNoticeMapper.selectNoticeInfo(map);
	}

	@Override
	public int selectNoticeInfoTot(HashMap<String, Object> map) throws Exception {
		return systemMngNoticeMapper.selectNoticeInfoTot(map); 
	}

	@Override
	public void insertNoticeInfo(HashMap<String, Object> map) throws Exception {
		systemMngNoticeMapper.insertNoticeInfo(map); 
	}

	@Override
	public void deleteNoticeInfo(HashMap<String, Object> map) throws Exception {
		systemMngNoticeMapper.deleteNoticeInfo(map); 
	}
	
	@Override
	public void updateNoticeInfo(HashMap<String, Object> map) throws Exception {
		systemMngNoticeMapper.updateNoticeInfo(map); 
	}
	
}
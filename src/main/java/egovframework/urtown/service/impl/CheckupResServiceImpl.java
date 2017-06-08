package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.CheckupResService;
import egovframework.urtown.service.MediConsultService;
import egovframework.urtown.service.MediConsultVO;

@Service("checkupResService")
public class CheckupResServiceImpl implements CheckupResService {
	
	@Resource(name = "checkupResMapper")
	private CheckupResMapper checkupResMapper;
	
	@Override
	public List<HashMap<String, Object>> selectCheckupResByMap(HashMap<String, Object> map) throws Exception {
		return checkupResMapper.selectCheckupResByMap(map);
	}

	@Override
	public void createCheckupRes(HashMap<String, Object> map) throws Exception {
		checkupResMapper.createCheckupRes(map);
	}

	@Override
	public void updateCheckupRes(HashMap<String, Object> map) throws Exception {
		checkupResMapper.updateCheckupRes(map);
	}

	@Override
	public void deleteCheckupRes(HashMap<String, Object> map) throws Exception {
		checkupResMapper.deleteCheckupRes(map);
	}

	@Override
	public Long getNextCheckupNo(HashMap<String, Object> map) throws Exception {
		return checkupResMapper.getNextCheckupNo(map);
	}

	@Override
	public List<HashMap<String, Object>> getCheckupResByUserNo(HashMap<String, Object> map) throws Exception {
		return checkupResMapper.getCheckupResByUserNo(map);
	}

	@Override
	public List<HashMap<String, Object>> selectCheckupResByUserNo(HashMap<String, Object> map) throws Exception {
		return checkupResMapper.selectCheckupResByUserNo(map);
	}

	@Override
	public void updateCheckupResDt(HashMap<String, Object> map) throws Exception {
		checkupResMapper.updateCheckupResDt(map);
		
	}
}

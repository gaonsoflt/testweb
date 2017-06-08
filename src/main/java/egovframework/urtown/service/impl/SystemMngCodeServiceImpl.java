package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.SystemMngCodeService;


@Service("systemMngCodeService")
public class SystemMngCodeServiceImpl implements SystemMngCodeService {
	
	@Resource(name = "systemMngCodeMapper")
	private SystemMngCodeMapper systemMngCodeMapper;
	
	public List<HashMap<String, Object>> selectMngCodeInfo(HashMap<String, Object> map) throws Exception{
		return systemMngCodeMapper.selectMngCodeInfo(map);
	}
	
	public int selectMngCodeInfoTot(HashMap<String, Object> map) throws Exception{
		return systemMngCodeMapper.selectMngCodeInfoTot(map); 
	}
	
	public List<HashMap<String, Object>> selectMngCodeInfoCombo(HashMap<String, Object> map) throws Exception{
		return systemMngCodeMapper.selectMngCodeInfoCombo(map);
	}
	
	public void insertMngCodeInfo(HashMap<String, Object> map) throws Exception{
		systemMngCodeMapper.insertMngCodeInfo(map);
	}
	
	public void updateMngCodeInfo(HashMap<String, Object> map) throws Exception{
		systemMngCodeMapper.updateMngCodeInfo(map);
	}
	
	public void deleteMngCodeInfo(HashMap<String, Object> map) throws Exception{
		systemMngCodeMapper.deleteMngCodeInfo(map);
	}
	
	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception{
		return systemMngCodeMapper.selectMngCodeMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return systemMngCodeMapper.selectCdNmCombo(map);
	}


	
}
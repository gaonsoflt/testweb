package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.systemmgr.service.SystemMgrCodeService;


@Service("systemMgrCodeService")
public class SystemMgrCodeServiceImpl implements SystemMgrCodeService {
	
	@Resource(name = "systemMgrCodeMapper")
	private SystemMgrCodeMapper systemMngCodeMapper;
	
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
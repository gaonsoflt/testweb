package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.SystemMngCctvService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("systemMngCctvService")
public class SystemMngCctvServiceImpl implements SystemMngCctvService { 
	
	@Resource(name = "systemMngCctvMapper")
	private SystemMngCctvMapper systemMngCctvMapper;
	
	public List<HashMap<String, Object>> selectMngCctvInfo(HashMap<String, Object> map) throws Exception{
		return systemMngCctvMapper.selectMngCctvInfo(map);
	}
	
	public int selectMngCctvInfoTot(HashMap<String, Object> map) throws Exception{
		return systemMngCctvMapper.selectMngCctvInfoTot(map); 
	}
	

	public void insertMngCctvInfo(HashMap<String, Object> map) throws Exception{
		systemMngCctvMapper.insertMngCctvInfo(map);
	}
	
	public void updateMngCctvInfo(HashMap<String, Object> map) throws Exception{
		systemMngCctvMapper.updateMngCctvInfo(map);
	}
	
	public void deleteMngCctvInfo(HashMap<String, Object> map) throws Exception{
		systemMngCctvMapper.deleteMngCctvInfo(map);
	}
	
}
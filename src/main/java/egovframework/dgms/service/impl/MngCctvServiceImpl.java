package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MngCctvService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("mngCctvService")
public class MngCctvServiceImpl implements MngCctvService { 
	
	@Resource(name = "mngCctvMapper")
	private MngCctvMapper mngCctvMapper;
	
	public List<HashMap<String, Object>> selectMngCctvInfo(HashMap<String, Object> map) throws Exception{
		return mngCctvMapper.selectMngCctvInfo(map);
	}
	
	public int selectMngCctvInfoTot(HashMap<String, Object> map) throws Exception{
		return mngCctvMapper.selectMngCctvInfoTot(map); 
	}
	

	public void insertMngCctvInfo(HashMap<String, Object> map) throws Exception{
		mngCctvMapper.insertMngCctvInfo(map);
	}
	
	public void updateMngCctvInfo(HashMap<String, Object> map) throws Exception{
		mngCctvMapper.updateMngCctvInfo(map);
	}
	
	public void deleteMngCctvInfo(HashMap<String, Object> map) throws Exception{
		mngCctvMapper.deleteMngCctvInfo(map);
	}
	
}
package egovframework.common.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.service.CommonService;


@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Resource(name = "commonMapper")
	private CommonMapper commonMapper;
	

	public String getSequence(HashMap<String, Object> map) throws Exception{
		return commonMapper.getSequence(map); 
	}
	
	public List<HashMap<String, Object>> getCodeListByCdID(HashMap<String, Object> map) throws Exception{
		return commonMapper.getCodeListByCdID(map); 
	}
	
	public List<HashMap<String, Object>> getAutoComplete(HashMap<String, Object> map) throws Exception{
		return commonMapper.getAutoComplete(map);  
	}
	
	public List<HashMap<String, Object>> getAutoCompleteNew(HashMap<String, Object> map) throws Exception{
		return commonMapper.getAutoCompleteNew(map);  
	}
	
	public List<HashMap<String, Object>> getUserAutoComplete(HashMap<String, Object> map) throws Exception{
		return commonMapper.getUserAutoComplete(map);  
	}
	
	public int getDuplicateCount(HashMap<String, Object> map) throws Exception{
		return commonMapper.getDuplicateCount(map);  
	}
}
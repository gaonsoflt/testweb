package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMngCctvMapper")
public interface SystemMngCctvMapper { 
	
	public List<HashMap<String, Object>> selectMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectMngCctvInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteMngCctvInfo(HashMap<String, Object> map) throws Exception;
	
}

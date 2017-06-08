package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.urtown.service.MediConsultVO;

@Mapper("checkupResMapper")
public interface CheckupResMapper {
	
	public List<HashMap<String, Object>> selectCheckupResByMap(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCheckupResByUserNo(HashMap<String, Object> map) throws Exception;

    public void createCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public void updateCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public void deleteCheckupRes(HashMap<String, Object> map) throws Exception;
	
	public Long getNextCheckupNo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> getCheckupResByUserNo(HashMap<String, Object> map) throws Exception;

	public void updateCheckupResDt(HashMap<String, Object> map) throws Exception;
}

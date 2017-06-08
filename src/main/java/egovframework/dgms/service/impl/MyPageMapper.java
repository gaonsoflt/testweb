package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("myPageMapper")
public interface MyPageMapper {
	
	public List<HashMap<String, Object>> selectMyPageInfo(HashMap<String, Object> paramMap) throws Exception;
	
	public int selectMyPageInfoTot(HashMap<String, Object> paramMap) throws Exception;
	
	public void updateMyPageInfo(HashMap<String, Object> paramMap) throws Exception;
	
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

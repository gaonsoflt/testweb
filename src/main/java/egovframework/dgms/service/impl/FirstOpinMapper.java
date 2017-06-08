package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("firstOpinMapper")
public interface FirstOpinMapper {
	
	public List<HashMap<String, Object>> selectFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectFirstOpinInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteFirstOpinInfo(HashMap<String, Object> map) throws Exception;

	public HashMap<String, Object> selectFirstOpinDetail(HashMap<String, Object> paramMap);
	
	public List<HashMap<String, Object>> selectfirstOpinUserList(HashMap<String, Object> map) throws Exception;

	public int selectfirstOpinUserListTot(HashMap<String, Object> map) throws Exception;
	
/*	public List<HashMap<String, Object>> selectMngCodeMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
}

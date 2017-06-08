package egovframework.dgms.service;

import java.util.HashMap;
import java.util.List;

public interface FirstOpinService {

	public List<HashMap<String, Object>> selectFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public int selectFirstOpinInfoTot(HashMap<String, Object> map) throws Exception;
	
	public void insertFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void updateFirstOpinInfo(HashMap<String, Object> map) throws Exception;
	
	public void deleteFirstOpinInfo(HashMap<String, Object> map) throws Exception;

	public HashMap<String, Object> selectFirstOpinDetail(HashMap<String, Object> paramMap) throws Exception;
	
	public List<HashMap<String, Object>> selectfirstOpinUserList(HashMap<String, Object> paramMap) throws Exception;

	public int selectfirstOpinUserListTot(HashMap<String, Object> paramMap) throws Exception;;
	
	
	/*public List<HashMap<String, Object>> selectFirstOpinMasterInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception;*/
	
    
}

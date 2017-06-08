package egovframework.urtown.service;

import java.util.HashMap;
import java.util.List;

public interface MediConsultService {

	public List<HashMap<String, Object>> selectMediConsultByMap(HashMap<String, Object> map) throws Exception;
	
    public List<MediConsultVO> selectMediConsultByVo(MediConsultVO mediConsultVO) throws Exception;
    
    public HashMap<String, Object> selectMediConsult(HashMap<String, Object> map) throws Exception;
    
    public HashMap<String, Object> selectMediConsultDetailInfo(HashMap<String, Object> map) throws Exception;
    
    public List<HashMap<String, Object>> selectMediConsultWaitingList(HashMap<String, Object> map) throws Exception;
    
    public List<HashMap<String, Object>> selectMediConsultListByUser(HashMap<String, Object> map) throws Exception;
    
    public List<HashMap<String, Object>> selectMediConsultHisPatientList(HashMap<String, Object> map) throws Exception;
    
    public void createMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public void updateMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public void updateMediConsultStatus(HashMap<String, Object> map) throws Exception;
	
	public void deleteMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public Long getNextRequestNo(HashMap<String, Object> map) throws Exception;

	public HashMap<String, Object> getDelSeq(HashMap<String, Object> map) throws Exception;
	
	
	public List<HashMap<String, Object>> selectConsultNote(HashMap<String, Object> map) throws Exception;
	
	public void createConsultNote(HashMap<String, Object> map) throws Exception;
	
	public void updateConsultNote(HashMap<String, Object> map) throws Exception;
	
	public void deleteConsultNote(HashMap<String, Object> map) throws Exception;
}

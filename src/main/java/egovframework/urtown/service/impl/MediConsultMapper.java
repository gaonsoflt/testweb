package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.urtown.service.MediConsultVO;

@Mapper("mediConsultMapper")
public interface MediConsultMapper {
	
	public List<HashMap<String, Object>> selectMediConsultByMap(HashMap<String, Object> map) throws Exception;
	
	public MediConsultVO selectMediConsultByVo(MediConsultVO mediConsultVO) throws Exception;
	
	public HashMap<String, Object> selectMediConsult(HashMap<String, Object> map) throws Exception;

    public List<HashMap<String, Object>> selectMediConsultWaitingList(HashMap<String, Object> map) throws Exception;
    
    public List<HashMap<String, Object>> selectMediConsultHisPatientList(HashMap<String, Object> map) throws Exception;

	public abstract HashMap<String, Object> selectMediConsultDetailInfo(HashMap<String, Object> paramHashMap) throws Exception;
	
	public List<HashMap<String, Object>> selectMediConsultListByUser(HashMap<String, Object> map) throws Exception;
	
	public void createMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public void updateMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public void updateMediConsultStatus(HashMap<String, Object> map) throws Exception;
	
	public void deleteMediConsultReq(HashMap<String, Object> map) throws Exception;
	
	public Long getNextRequestNo(HashMap<String, Object> map) throws Exception;
	
	public HashMap<String, Object> getDelSeq(HashMap<String, Object> map) throws Exception;
}

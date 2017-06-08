package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.urtown.service.MediConsultVO;

@Mapper("mediFAQMapper")
public interface MediFAQMapper {
	
	public List<HashMap<String, Object>> selectMediFAQ(HashMap<String, Object> map) throws Exception;

    public void createMediFAQ(HashMap<String, Object> map) throws Exception;
	
	public void updateMediFAQ(HashMap<String, Object> map) throws Exception;
	
	public void deleteMediFAQ(HashMap<String, Object> map) throws Exception;
}

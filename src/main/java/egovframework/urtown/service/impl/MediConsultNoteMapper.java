package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.urtown.service.MediConsultVO;

@Mapper("mediConsultNoteMapper")
public abstract interface MediConsultNoteMapper {
	public abstract List<HashMap<String, Object>> selectConsultNote(HashMap<String, Object> paramHashMap)
			throws Exception;

	public abstract void createConsultNote(HashMap<String, Object> paramHashMap) throws Exception;

	public abstract void updateConsultNote(HashMap<String, Object> paramHashMap) throws Exception;

	public abstract void deleteConsultNote(HashMap<String, Object> paramHashMap) throws Exception;
}

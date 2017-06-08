package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.MediConsultService;
import egovframework.urtown.service.MediConsultVO;

@Service("mediConsultService")
public class MediConsultServiceImpl implements MediConsultService {
	
	@Resource(name = "mediConsultMapper")
	private MediConsultMapper mediConsultMapper;
	
	@Resource(name = "mediConsultNoteMapper")
	private MediConsultNoteMapper mediConsultNoteMapper;
	
	@Override
	public List<HashMap<String, Object>> selectMediConsultByMap(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsultByMap(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MediConsultVO> selectMediConsultByVo(MediConsultVO mediConsultVO) throws Exception {
		return (List<MediConsultVO>) mediConsultMapper.selectMediConsultByVo(mediConsultVO);
	}

	@Override
	public HashMap<String, Object> selectMediConsult(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsult(map);
	}

	@Override
	public void createMediConsultReq(HashMap<String, Object> map) throws Exception {
		mediConsultMapper.createMediConsultReq(map);
	}

	@Override
	public void updateMediConsultReq(HashMap<String, Object> map) throws Exception {
		mediConsultMapper.updateMediConsultReq(map);
	}
	
	@Override
	public void updateMediConsultStatus(HashMap<String, Object> map) throws Exception {
		mediConsultMapper.updateMediConsultStatus(map);
	}

	@Override
	public void deleteMediConsultReq(HashMap<String, Object> map) throws Exception {
		mediConsultMapper.deleteMediConsultReq(map);
	}

	@Override
	public Long getNextRequestNo(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.getNextRequestNo(map);
	}

	@Override
	public List<HashMap<String, Object>> selectMediConsultWaitingList(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsultWaitingList(map);
	}
	
	@Override
	public HashMap<String, Object> selectMediConsultDetailInfo(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsultDetailInfo(map);
	}

	@Override
	public List<HashMap<String, Object>> selectConsultNote(HashMap<String, Object> map) throws Exception {
		return mediConsultNoteMapper.selectConsultNote(map);
	}

	@Override
	public void createConsultNote(HashMap<String, Object> map) throws Exception {
		mediConsultNoteMapper.createConsultNote(map);
	}

	@Override
	public void updateConsultNote(HashMap<String, Object> map) throws Exception {
		mediConsultNoteMapper.updateConsultNote(map);
	}

	@Override
	public void deleteConsultNote(HashMap<String, Object> map) throws Exception {
		mediConsultNoteMapper.deleteConsultNote(map);
	}

	@Override
	public List<HashMap<String, Object>> selectMediConsultListByUser(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsultListByUser(map);
	}

	@Override
	public HashMap<String, Object> getDelSeq(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.getDelSeq(map);
	}

	@Override
	public List<HashMap<String, Object>> selectMediConsultHisPatientList(HashMap<String, Object> map) throws Exception {
		return mediConsultMapper.selectMediConsultHisPatientList(map);
	}
}

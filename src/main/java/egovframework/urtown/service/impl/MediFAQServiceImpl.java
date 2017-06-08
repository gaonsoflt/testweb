package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.MediConsultService;
import egovframework.urtown.service.MediConsultVO;
import egovframework.urtown.service.MediFAQService;

@Service("mediFAQService")
public class MediFAQServiceImpl implements MediFAQService {
	
	@Resource(name = "mediFAQMapper")
	private MediFAQMapper mediFAQMapper;
	
	@Override
	public List<HashMap<String, Object>> selectMediFAQ(HashMap<String, Object> map) throws Exception {
		return mediFAQMapper.selectMediFAQ(map);
	}

	@Override
	public void createMediFAQ(HashMap<String, Object> map) throws Exception {
		mediFAQMapper.createMediFAQ(map);
	}

	@Override
	public void updateMediFAQ(HashMap<String, Object> map) throws Exception {
		mediFAQMapper.updateMediFAQ(map);
	}

	@Override
	public void deleteMediFAQ(HashMap<String, Object> map) throws Exception {
		mediFAQMapper.deleteMediFAQ(map);
	}
}

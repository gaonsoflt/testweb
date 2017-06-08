package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.EcrOpinService;


@Service("ecrOpinService")
public class EcrOpinServiceImpl implements EcrOpinService { 
	
	@Resource(name = "ecrOpinMapper")
	private EcrOpinMapper ecrOpinMapper;
	
	public List<HashMap<String, Object>> selectEcrOpinInfo(HashMap<String, Object> map) throws Exception{
		return ecrOpinMapper.selectEcrOpinInfo(map);
	}
	
	public int selectEcrOpinInfoTot(HashMap<String, Object> map) throws Exception{
		return ecrOpinMapper.selectEcrOpinInfoTot(map); 
	}
	

	public void insertEcrOpinInfo(HashMap<String, Object> map) throws Exception{
		ecrOpinMapper.insertEcrOpinInfo(map);
	}
	
	public void updateEcrOpinInfo(HashMap<String, Object> map) throws Exception{
		ecrOpinMapper.updateEcrOpinInfo(map);
	}
	
	public void deleteEcrOpinInfo(HashMap<String, Object> map) throws Exception{
		ecrOpinMapper.deleteEcrOpinInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectEcrOpinMasterInfo(HashMap<String, Object> map) throws Exception{
		return ecrOpinMapper.selectEcrOpinMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return ecrOpinMapper.selectCdNmCombo(map);
	}
*/

	
}
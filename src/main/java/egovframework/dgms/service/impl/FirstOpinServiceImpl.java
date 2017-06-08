package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.FirstOpinService;


@Service("firstOpinService")
public class FirstOpinServiceImpl implements FirstOpinService { 
	
	@Resource(name = "firstOpinMapper")
	private FirstOpinMapper firstOpinMapper;
	
	public List<HashMap<String, Object>> selectFirstOpinInfo(HashMap<String, Object> map) throws Exception{
		return firstOpinMapper.selectFirstOpinInfo(map);
	}
	
	public int selectFirstOpinInfoTot(HashMap<String, Object> map) throws Exception{
		return firstOpinMapper.selectFirstOpinInfoTot(map); 
	}
	

	public void insertFirstOpinInfo(HashMap<String, Object> map) throws Exception{
		firstOpinMapper.insertFirstOpinInfo(map);
	}
	
	public void updateFirstOpinInfo(HashMap<String, Object> map) throws Exception{
		firstOpinMapper.updateFirstOpinInfo(map);
	}
	
	public void deleteFirstOpinInfo(HashMap<String, Object> map) throws Exception{
		firstOpinMapper.deleteFirstOpinInfo(map);
	}

	@Override
	public HashMap<String, Object> selectFirstOpinDetail(HashMap<String, Object> paramMap) throws Exception {
		return firstOpinMapper.selectFirstOpinDetail(paramMap);
	}
	
	@Override
	public List<HashMap<String, Object>> selectfirstOpinUserList(HashMap<String, Object> map) throws Exception {
		return firstOpinMapper.selectfirstOpinUserList(map);
	}

	@Override
	public int selectfirstOpinUserListTot(HashMap<String, Object> map) throws Exception{
		return firstOpinMapper.selectfirstOpinUserListTot(map);
	}
	
/*	public List<HashMap<String, Object>> selectFirstOpinMasterInfo(HashMap<String, Object> map) throws Exception{
		return firstOpinMapper.selectFirstOpinMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return firstOpinMapper.selectCdNmCombo(map);
	}
*/

	
}
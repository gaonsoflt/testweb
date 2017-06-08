package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.DataEcgService;


@Service("dataEcgService")
public class DataEcgServiceImpl implements DataEcgService {  
	
	@Resource(name = "dataEcgMapper")
	private DataEcgMapper dataEcgMapper;
	
	public List<HashMap<String, Object>> selectDataEcgInfo(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectDataEcgInfo(map);
	}
	
	public int selectDataEcgInfoTot(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectDataEcgInfoTot(map); 
	}
	
	public HashMap<String, Object> selectEcgInfoBySeq(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectEcgInfoBySeq(map);
	}

	/**
	 * 해당일자에 측정된 심전도 데이터 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledayecgData(HashMap<String,Object> paramMap) throws Exception {
		return dataEcgMapper.selectmobiledayecgData(paramMap);
	}
	
	public void insertEcgData(HashMap<String, Object> map) throws Exception{
		dataEcgMapper.insertEcgData(map);
	}

	public void insertActEcgData(HashMap<String, Object> map) throws Exception{
		dataEcgMapper.insertActEcgData(map);
	}

	public List<HashMap<String, Object>> selectDataActEcgInfo(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectDataActEcgInfo(map);
	}
	
	public int selectDataActEcgInfoTot(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectDataActEcgInfoTot(map); 
	}
	
	public HashMap<String, Object> selectActEcgInfoBySeq(HashMap<String, Object> map) throws Exception{
		return dataEcgMapper.selectActEcgInfoBySeq(map);
	}
/*	public void insertDataEcgInfo(HashMap<String, Object> map) throws Exception{
		dataEcgMapper.insertDataEcgInfo(map);
	}
	
	public void updateDataEcgInfo(HashMap<String, Object> map) throws Exception{
		dataEcgMapper.updateDataEcgInfo(map);
	}
	
	public void deleteDataEcgInfo(HashMap<String, Object> map) throws Exception{
		dataEcgMapper.deleteDataEcgInfo(map);
	}*/

	


	
}
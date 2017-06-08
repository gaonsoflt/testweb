package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.DataBldService;


@Service("dataBldService")
public class DataBldServiceImpl implements DataBldService {  
	
	@Resource(name = "dataBldMapper")
	private DataBldMapper dataBldMapper;
	
	public List<HashMap<String, Object>> selectDataBldInfo(HashMap<String, Object> map) throws Exception{
		return dataBldMapper.selectDataBldInfo(map);
	}
	
	public int selectDataBldInfoTot(HashMap<String, Object> map) throws Exception{
		return dataBldMapper.selectDataBldInfoTot(map); 
	}
	
	public List<HashMap<String, Object>> selectChartDataBldDetailInfo(HashMap<String, Object> map) throws Exception{
		return dataBldMapper.selectChartDataBldDetailInfo(map);
	}
	/**
	 * 해당일자에 측정된 혈압기 데이터 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledaybldData(HashMap<String,Object> paramMap) throws Exception {
		return dataBldMapper.selectmobiledaybldData(paramMap);
	}
/*	public void insertDataBldInfo(HashMap<String, Object> map) throws Exception{
		dataBldMapper.insertDataBldInfo(map);
	}
	
	public void updateDataBldInfo(HashMap<String, Object> map) throws Exception{
		dataBldMapper.updateDataBldInfo(map);
	}
	
	public void deleteDataBldInfo(HashMap<String, Object> map) throws Exception{
		dataBldMapper.deleteDataBldInfo(map);
	}*/

	


	
}
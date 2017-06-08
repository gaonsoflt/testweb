package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.dgms.service.DataMedcService;


@Service("dataMedcService")
public class DataMedcServiceImpl implements DataMedcService {  
	
	@Resource(name = "dataMedcMapper")
	private DataMedcMapper dataMedcMapper;
	
	public List<HashMap<String, Object>> selectDataMedcInfo(HashMap<String, Object> map) throws Exception{
		return dataMedcMapper.selectDataMedcInfo(map);
	}
	
	public int selectDataMedcInfoTot(HashMap<String, Object> map) throws Exception{
		return dataMedcMapper.selectDataMedcInfoTot(map); 
	}
	
	public List<HashMap<String, Object>> selectChartDataMedcDetailInfo(HashMap<String, Object> map) throws Exception{
		return dataMedcMapper.selectChartDataMedcDetailInfo(map);
	}
	/**
	 * 해당일자에 측정된 약상자 데이터 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectmobiledaymedcData(HashMap<String,Object> paramMap) throws Exception {
		return dataMedcMapper.selectmobiledaymedcData(paramMap);
	}
	/*public void insertDataMedcInfo(HashMap<String, Object> map) throws Exception{
		dataMedcMapper.insertDataMedcInfo(map);
	}
	
	public void updateDataMedcInfo(HashMap<String, Object> map) throws Exception{
		dataMedcMapper.updateDataMedcInfo(map);
	}
	
	public void deleteDataMedcInfo(HashMap<String, Object> map) throws Exception{
		dataMedcMapper.deleteDataMedcInfo(map);
	}*/

	


	
}
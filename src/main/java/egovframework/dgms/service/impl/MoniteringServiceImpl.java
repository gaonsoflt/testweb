package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.common.service.CommonService;
import egovframework.dgms.service.MoniteringService;

@Service("moniteringService")
public class MoniteringServiceImpl implements MoniteringService {

	@Resource(name = "moniteringMapper")
	private MoniteringMapper moniteringMapper; 


	@Override
	public List<HashMap<String, Object>> selectChartDataMornitering(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectChartDataMornitering(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectMorniteringData1(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectMorniteringData1(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectMorniteringData2(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectMorniteringData2(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectMorniteringData3(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectMorniteringData3(map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectMorniteringDataCNT1(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectMorniteringDataCNT1(map);
	}

	@Override
	public int selectMorniteringData3Tot(HashMap<String, Object> map) throws Exception {
		return moniteringMapper.selectMorniteringData3Tot(map);
	}

}

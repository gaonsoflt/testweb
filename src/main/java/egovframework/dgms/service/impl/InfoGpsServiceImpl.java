package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.InfoGpsService;


@Service("infoGpsService")
public class InfoGpsServiceImpl implements InfoGpsService {

	@Resource(name = "appInfMapper")
	private AppInfMapper appInfMapper;
	
	/**
	 * GPS의 최신 정보 1건을 들고온다.
	 * @param map
	 * @return List
	 * @throws Exception
	 */	
	@Override
	public List<HashMap<String, Object>> selectLastGPSInfo(HashMap<String, Object> map) throws Exception {
		return appInfMapper.selectLastGPSInfo(map);
	}

}

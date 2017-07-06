package egovframework.espa.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.espa.service.ESPAConfigService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("eSPAConfigService")
public class ESPAConfigServiceImpl extends EgovAbstractServiceImpl implements ESPAConfigService{ 
	Logger logger = LoggerFactory.getLogger(ESPAConfigServiceImpl.class.getName());

	@Resource(name = "eSPAConfigMapper")
	private ESPAConfigMapper configMapper;

	@Override
	public List<HashMap<String, Object>> readESPAConfig(HashMap<String, Object> map) throws Exception {
		return configMapper.selectESPAConfig(map);
	}
	
	@Override
	public int readESPAConfigAllTot(HashMap<String, Object> map) throws Exception {
		return configMapper.selectESPAConfigAllTot(map);
	}
	
	@Override
	public int createESPAConfig(HashMap<String, Object> map) throws Exception {
		return configMapper.insertESPAConfig(map);
	}
	
	@Override
	public int updateESPAConfig(HashMap<String, Object> map) throws Exception {
		return configMapper.updateESPAConfig(map);
	}
	
	@Override
	public int deleteESPAConfig(HashMap<String, Object> map) throws Exception {
		return configMapper.deleteESPAConfig(map);
	}

	@Override
	public HashMap<String, Object> getConfigGroupList(HashMap<String, Object> map) {
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		try {
			logger.debug("params: " + map);
			List<HashMap<String, Object>> rtnList = configMapper.readConfigGroupList(map);
			rtnMap.put("rtnList", rtnList);
			rtnMap.put("total", Integer.valueOf(rtnList.size()));
		} catch (Exception e) {
			e.printStackTrace();
			rtnMap.put("error", e.toString());
		}
		return rtnMap;
	}
}
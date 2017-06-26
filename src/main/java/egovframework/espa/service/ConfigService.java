package egovframework.espa.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.espa.dao.ESPAConfigVO;
import egovframework.espa.service.impl.ESPAConfigMapper;

@Service
public class ConfigService {
	@Resource(name = "eSPAConfigMapper")
	private ESPAConfigMapper configMapper;
	
	private List<ESPAConfigVO> espaConfigVo;
	
	@PostConstruct
	public void init() throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		espaConfigVo = configMapper.selectAllESPAConfig(map);
	}

	public List<ESPAConfigVO> getEspaConfigVo() {
		return espaConfigVo;
	}

	public ESPAConfigVO getEspaConfigVo(String cfgId) {
		int idx = getEspaConfigVo().indexOf(new ESPAConfigVO(cfgId));
		if(idx < 0)
			return null;
		return getEspaConfigVo().get(idx);
	}
	
	public String getEspaConfigVoValue(String cfgId) {
		return getEspaConfigVo(cfgId).getCfg_value();
	}
	
	public String getEspaConfigVoName(String cfgId) {
		return getEspaConfigVo(cfgId).getCfg_name();
	}
}

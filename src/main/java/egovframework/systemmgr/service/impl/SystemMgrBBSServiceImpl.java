package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrBBSService;

@Service("systemMgrBBSService")
public class SystemMgrBBSServiceImpl extends EgovAbstractServiceImpl implements SystemMgrBBSService {
	Logger logger = LoggerFactory.getLogger(this.getClass().getName());

	@Resource(name = "systemMgrBBSMapper")
	private SystemMgrBBSMapper bbsMapper;

	@Override
	public Map<String, Object> getBBSList(Map<String, Object> param) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		logger.debug("param: " + param);
		rtnMap.put("rtnList", bbsMapper.readBBSList(param));
		rtnMap.put("total", bbsMapper.readBBSListCount(param));
		return rtnMap;
	}

	@Override
	public int insertBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			if(bbsMapper.createBBS(param) > 0) { 
				param.put("table_name", param.get("bbs_id").toString());
				execute += bbsMapper.createTable(param);
			}
		}
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public int updateBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			execute += bbsMapper.updateBBS(param);
		}
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public int deleteBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			param = bbsMapper.readBBSDetail(param);
			if(bbsMapper.deleteBBS(param) > 0) {
				param.put("table_name", param.get("bbs_id").toString());
				execute += bbsMapper.dropTable(param);
			}
		}
		logger.debug("execute:" + execute);
		return execute;
	}

	@Override
	public Map<String, Object> getBBSDetail(int seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("bbs_seq", seq);
		return bbsMapper.readBBSDetail(param);
	}
}
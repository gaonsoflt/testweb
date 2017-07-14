package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.bbs.service.impl.BBSBoardMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrBBSService;
import egovframework.systemmgr.service.SystemMgrMenuService;

@Service("systemMgrBBSService")
public class SystemMgrBBSServiceImpl extends EgovAbstractServiceImpl implements SystemMgrBBSService {
	Logger logger = LoggerFactory.getLogger(this.getClass().getName());

	@Resource(name = "systemMgrBBSMapper")
	private SystemMgrBBSMapper bbsMapper;
	
	@Resource(name = "bBSBoardMapper")
	private BBSBoardMapper boardMapper;
	
	@Resource(name = "systemMgrMenuMapper")
	private SystemMgrMenuMapper menuMapper;
	
	@Resource(name = "systemMgrUserAuthMapper")
	private SystemMgrUserAuthMapper authMapper;
	
	@Resource(name = "systemMgrMenuService")
	private SystemMgrMenuService menuService;

	@Override
	public Map<String, Object> getBBSList(Map<String, Object> param) throws Exception {
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		logger.debug("param: " + param);
		rtnMap.put("rtnList", bbsMapper.readBBSList(param));
		rtnMap.put("total", bbsMapper.readBBSListCount(param));
		return rtnMap;
	}

	/*
	 * #{menu_nm} 
	 * #{menu_url} 
	 * #{menu_desc}
	 * #{menu_content}
	 * #{menu_order} 
	 * #{use_yn}
	 * #{parent_sq}
	 */
	@Override
	public int insertBBS(List<Map<String, Object>> params) throws Exception {
		logger.debug("params:" + params);
		int execute = 0;
		for (int i = 0; i < params.size(); i++) {
			Map<String, Object> param = params.get(i);
			
			logger.debug("insert bbs reference");
			bbsMapper.createBBS(param);
			
			param.put("menu_id", param.get("bbs_id").toString());
			param.put("menu_nm", param.get("bbs_name").toString());
			param.put("menu_url", "/bbs/board.do?bid=" + param.get("bbs_seq").toString());
			param.put("menu_desc", param.get("bbs_name").toString());
			param.put("menu_content", "");
			param.put("menu_order", 1);
			param.put("use_yn", true);
			param.put("parent_sq", 3); // 3(bbs) = menu_seq(tb_menu_info)
			logger.debug("insert menu for bbs");
			menuMapper.createMenuInfo(param);
						
//			param.put("table_name", param.get("bbs_id").toString());
//			logger.debug("created bbs table: " + param.get("bbs_id").toString());
//			bbsMapper.createTable(param);
			
			execute++;
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
			logger.debug("delete bbs reference");
			bbsMapper.deleteBBS(param);
			
			String bbsID = param.get("bbs_id").toString();
			param.put("menu_id", bbsID);
			logger.debug("delete user auth by menu_id");
			authMapper.deleteUserAuthByMenuSeq(param);
			
			logger.debug("delete menu for bbs");
			menuMapper.deleteMenuInfoByBBS(param);
			
			// TODO: delete board, file and reply
//			logger.debug("delete board");
//			boardMapper.deleteBoard(param);
			
//			param.put("table_name", bbsID);
//			logger.debug("delete bbs table: " + bbsID);
//			bbsMapper.dropTable(param);
			
			execute++;			
		}
		menuService.refreshCachedMenu();
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
package egovframework.dgms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.dgms.service.AppInfService;

@Controller
public class DashboardController {
Logger logger = LoggerFactory.getLogger(DashboardController.class.getName());
    
	@Resource(name = "appInfService")
	private AppInfService appInfService;

	@RequestMapping(value = "/dgms/dashboard.do")
	public String dgmsDashboard(Model model) throws Exception {
		return "dgms/dashboard";
	}
	
	/********************************************************
	 * 메인 대시보드에 보여질 정보 조회.
	 * @param paramMap post / json type
	 *              {"id":"1234", "pw":"0000"}
	 * @return json
	 * @throws Exception
	 ********************************************************/
	@RequestMapping(value = "/dgms/selectMeasureScheduleInfo.do")
	public @ResponseBody HashMap<String, Object> selectMeasureScheduleInfo(@RequestParam Map<String,Object> paramMap) throws Exception {
		String code = "";
		List<HashMap<String, Object>> rtnList = null;
		rtnList = (List<HashMap<String, Object>>)appInfService.selectMeasureScheduleInfo((HashMap<String, Object>)paramMap);
		code = "000";
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("rtnList", rtnList);

		
		return result;
	}
}

package egovframework.dgms.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RentFaultController {
Logger logger = LoggerFactory.getLogger(RentFaultController.class.getName());
    
	@RequestMapping(value = "/dgms/rentFault.do")
	public String dgmsRentFault(Model model) throws Exception {
		return "dgms/rentFault";
	}
}
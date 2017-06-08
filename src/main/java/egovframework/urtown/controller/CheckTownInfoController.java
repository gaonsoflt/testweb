package egovframework.urtown.controller;
 
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CheckTownInfoController {

	/* 2017.01.03 KSY-Add allTownInfo */
	@RequestMapping(value="/urtown/checkAllTownInfo.do")
	public String checkAllTownInfoController() throws Exception{
		return "/urtown/checkAllTownInfo";
	}
	
	@RequestMapping(value="/urtown/checkTownInfo.do")
	public String checkTownInfoController() throws Exception{
		return "/urtown/checkTownInfo";
	}

	@RequestMapping(value="/urtown/checkTownNature.do")
	public String checkTownNatureController() throws Exception{
		return "/urtown/checkTownNature";
	} 
}

package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.MyPageService;


@Service("myPageService")
public class MyPageServiceImpl implements MyPageService { 
	
	@Resource(name = "myPageMapper")
	private MyPageMapper myPageMapper;

	public List<HashMap<String, Object>> selectMyPageInfo(HashMap<String, Object> paramMap) throws Exception {
		return myPageMapper.selectMyPageInfo(paramMap);
	}

	public int selectMyPageInfoTot(HashMap<String, Object> paramMap) throws Exception {
		return myPageMapper.selectMyPageInfoTot(paramMap);
	}

	public void updateMyPageInfo(HashMap<String, Object> paramMap) throws Exception {
		myPageMapper.updateMyPageInfo(paramMap);
	}
	
	
/*	public List<HashMap<String, Object>> selectMyPageMasterInfo(HashMap<String, Object> map) throws Exception{
		return myPageMapper.selectMyPageMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return myPageMapper.selectCdNmCombo(map);
	}
*/

	
}
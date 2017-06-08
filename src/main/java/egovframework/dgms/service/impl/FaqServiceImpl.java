package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.FaqService;


@Service("faqService")
public class FaqServiceImpl implements FaqService { 
	
	@Resource(name = "faqMapper")
	private FaqMapper faqMapper;
	
	public List<HashMap<String, Object>> selectFaqInfo(HashMap<String, Object> map) throws Exception{
		return faqMapper.selectFaqInfo(map);
	}
	
	public int selectFaqInfoTot(HashMap<String, Object> map) throws Exception{
		return faqMapper.selectFaqInfoTot(map); 
	}
	

	public void insertFaqInfo(HashMap<String, Object> map) throws Exception{
		faqMapper.insertFaqInfo(map);
	}
	
	public void updateFaqInfo(HashMap<String, Object> map) throws Exception{
		faqMapper.updateFaqInfo(map);
	}
	
	public void deleteFaqInfo(HashMap<String, Object> map) throws Exception{
		faqMapper.deleteFaqInfo(map);
	}
	
/*	public List<HashMap<String, Object>> selectFaqMasterInfo(HashMap<String, Object> map) throws Exception{
		return faqMapper.selectFaqMasterInfo(map);
	}
	
	public List<HashMap<String, Object>> selectCdNmCombo(HashMap<String, Object> map) throws Exception{
		return faqMapper.selectCdNmCombo(map);
	}
*/

	
}
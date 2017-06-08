package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.urtown.service.EditorBrowserService;

@Service("editorBrowserService")
public class EditorBrowserServiceImp implements EditorBrowserService {
	
	@Resource(name = "editorBrowserMapper")
	private EditorBrowserMapper editorBrowserMapper;

	@Override
	public void saveFiles(HashMap<String, Object> map) throws Exception {
		editorBrowserMapper.saveFiles(map);
		
	} 

	@Override
	public void removeFiles(HashMap<String, Object> map) throws Exception {
		editorBrowserMapper.removeFiles(map);
		
	} 
	
	@Override
	public List<HashMap<String, Object>> selectFiles(HashMap<String, Object> map) throws Exception {
		return editorBrowserMapper.selectFiles(map);
	} 
}

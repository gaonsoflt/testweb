package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("editorBrowserMapper")
public interface EditorBrowserMapper {

	public void saveFiles(HashMap<String, Object> map) throws Exception;

	public void removeFiles(HashMap<String, Object> map) throws Exception;

	public List<HashMap<String, Object>> selectFiles(HashMap<String, Object> map) throws Exception; 
}

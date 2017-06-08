package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("myPrescriptMapper")
public interface MyPrescriptMapper {
	public List<HashMap<String, Object>> selectMyPrescriptMasterInfo(HashMap<String, Object> map) throws Exception;

	public List<HashMap<String, Object>> selectMyPrescriptInfo(HashMap<String, Object> map) throws Exception;

	public Object selectMyPrescriptInfoTot(HashMap<String, Object> map) throws Exception;

	public void insertMyPrescriptInfo(HashMap<String, Object> map) throws Exception;

	public void deleteMyPrescriptInfo(HashMap<String, Object> map) throws Exception;

	public void updateMyPrescriptInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception;

	public Object selectMyPrescriptMedcInfoTot(HashMap<String, Object> map) throws Exception;

	public void insertMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception;

	public void deleteMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception;

	public void updateMyPrescriptMedcInfo(HashMap<String, Object> map) throws Exception;
	
	public List<HashMap<String, Object>> selectdosageData(HashMap<String,Object> paramMap) throws Exception;
	
	public List<HashMap<String, Object>> selectdosagealarmData(HashMap<String,Object> paramMap) throws Exception;
}

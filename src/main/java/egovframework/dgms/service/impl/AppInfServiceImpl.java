package egovframework.dgms.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.dgms.service.AppInfService;


@Service("appInfService")
public class AppInfServiceImpl implements AppInfService {
	
	@Resource(name = "appInfMapper")
	private AppInfMapper appInfMapper;
	
	/**
	 * 사용자 정보를 검색( 디바이스 정보 포함 )
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectUserInfo(HashMap<String, Object> map) throws Exception {
		return appInfMapper.selectUserInfo(map);
	}
	
	/**
	 * 모바일 장비 정보 등록
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertDeviceInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertDeviceInfo(paramMap);
	}
	
	/**
	 * 모바일 장비 정보 검색
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectDeviceInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.selectDeviceInfo(paramMap);
	}

	/**
	 * 모바일 장비 정보 업데이트(RegistrationID)
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateDeviceInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.updateDeviceInfo(paramMap);
	}
	
	/**
	 * 메인 대시보드 정보 조회(심전도,혈압,약상자)
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectMeasureScheduleInfo(HashMap<String, Object> map) throws Exception {
		return appInfMapper.selectMeasureScheduleInfo(map);
	}
	/**
	 * 모바일 알림(PUS) 정보 등록
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertMobilePushInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertMobilePushInfo(paramMap);
	}
	/**
	 * 모바일 알림(PUS) 정보 업데이트
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateMobilePushInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.updateMobilePushInfo(paramMap);
	}
	/**
	 * 방송하지 않은 Push 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectNotSendMobilePushInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.selectNotSendMobilePushInfo(paramMap);
	}
	/**
	 * GPS 정보 등록
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertGPSInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertGPSInfo(paramMap);
	}
	/**
	 * 마지막 GPS 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectLastGPSInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.selectLastGPSInfo(paramMap);
	}
	
	/**
	 * 그룹 멤버의 정보 조회
	 * @param paramMap - 등록할 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> getGroupMemberInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.getGroupMemberInfo(paramMap);
	}
	
	
	
	/**
	 * 처방 정보 등록
	 * @param paramMap - 처방 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertMyPrescriptInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertMyPrescriptInfo(paramMap);
	}
	
	/**
	 * 처방 정보 등록
	 * @param paramMap - 처방 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public List<HashMap<String, Object>> selectMyPrescriptInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.selectMyPrescriptInfo(paramMap);
	}
	
	/**
	 * 처방 약품 정보 등록
	 * @param paramMap - 처방 정보가 담긴 paramMap
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertMyPrescriptMedcInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertMyPrescriptMedcInfo(paramMap);
	}

	/**
	 * 문진표 메인응답 작성
	 * @param paramMap - 문진표 메인응답 정보
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertMedcInquiryManswer(HashMap<String, Object> map) throws Exception {
		appInfMapper.insertMedcInquiryManswer(map);
		
	}

	/**
	 * 문진표 서브응답 작성
	 * @param map 문진표 서브응답 정보
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertMedcInquirySanswer(HashMap<String, Object> map) throws Exception {
		appInfMapper.insertMedcInquirySanswer(map);
		
	}

	/**
	 * 문진표 정보 조회
	 * @param paramMap - 사용자아이디
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public List<HashMap<String, Object>> selectMedcInquiryAnswer(Map<String, Object> paramMap) throws Exception {
		return appInfMapper.selectMedcInquiryAnswer(paramMap);
	}
	
	/**
	 * 약 정보 등록
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void insertDrugInfo(HashMap<String,Object> paramMap) throws Exception {
		appInfMapper.insertDrugInfo(paramMap);
	}
	
	/**
	 * 약 정보 조회
	 * @param vo - 수정할 정보가 담긴 CodeVO
	 * @exception Exception
	 */
	@Override
	public List<HashMap<String, Object>> selectDrugInfo(HashMap<String,Object> paramMap) throws Exception {
		return appInfMapper.selectDrugInfo(paramMap);
	}
	
	/**
	 * 문진표 메인응답 수정
	 * @param map - 문진표 메인응답 정보
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateMedcInquiryManswer(HashMap<String, Object> map) throws Exception {
		appInfMapper.updateMedcInquiryManswer(map);
		
	}
	
	/**
	 * 문진표 서브응답 수정
	 * @param map - 문진표 서브응답 정보
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateMedcInquirySanswer(HashMap<String, Object> map) throws Exception {
		appInfMapper.updateMedcInquirySanswer(map);		
	}
	
	/**
	 * 문진표 서브응답 삭제
	 * @param map - 문진표 서브응답 삭제
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void deleteMedcInquirySanswer(HashMap<String, Object> map) throws Exception {
		appInfMapper.deleteMedcInquirySanswer(map);		
	}
	
}
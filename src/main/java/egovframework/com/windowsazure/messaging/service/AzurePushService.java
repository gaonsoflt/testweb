package egovframework.com.windowsazure.messaging.service;

import org.apache.commons.collections.map.CaseInsensitiveMap;

import egovframework.com.windowsazure.messaging.Registration;

/**
 * 권한그룹에 관한 서비스 인터페이스 클래스를 정의한다.
 * 
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
public interface AzurePushService {

	public Registration createRegistration(String areaid,String userid, String phone, String offid, String regtid);
	
	public void sendPushAlarm(CaseInsensitiveMap item);
}
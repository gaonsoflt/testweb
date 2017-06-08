package egovframework.com.windowsazure.messaging.service;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;

import egovframework.com.windowsazure.messaging.GcmRegistration;
import egovframework.com.windowsazure.messaging.Notification;
import egovframework.com.windowsazure.messaging.NotificationHub;
import egovframework.com.windowsazure.messaging.Registration;

/**
 * 권한그룹에 관한 서비스 인터페이스 클래스를 정의한다.
 * 
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * 		<pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *      </pre>
 */
@Service
public class AzurePushServiceImpl implements AzurePushService {

	@Autowired
	private Environment env;

	@Override
	public Registration createRegistration(String areaid,String userid, String mobileno, String userseq, String regtid) {
		return createRegistrationInAzure(areaid,userid, mobileno, userseq, regtid);
	}

	private Registration createRegistrationInAzure(String areaid,String userid, String mobileno, String userseq, String regtid) {
		String azureNotificationHubConnectionString = env.getProperty("azure.azureNotificationHubConnectionString");
		azureNotificationHubConnectionString = "Endpoint=sb://dg-dgmc-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=e6Pq0mW0y1VfJPji0dr53qdIjmImypFj7MqQ7HJuAyI=";
		String azureNotificationHubName = env.getProperty("azure.azureNotificationHubName");
		azureNotificationHubName = "dgmc";
		NotificationHub hub = new NotificationHub(azureNotificationHubConnectionString, azureNotificationHubName);

		Registration registration = null;
		// Android
		registration = new GcmRegistration(regtid);

		// 해당 태그에 해당하는 유저에게 푸시를 보낼 수 있음
		registration.getTags().add("areaid_" + areaid);
		registration.getTags().add("userid_" + userid);
		registration.getTags().add("phone_" + mobileno);
		registration.getTags().add("userseq_" + userseq);

		registration = hub.createRegistration(registration);

		// Registration createRegistration =
		// hub.upsertRegistration(registration);
		return registration;
	}

	@Override
	public void sendPushAlarm(CaseInsensitiveMap item) {
		String USERSEQ = item.get("USER_SEQ").toString();
		String MOBILENO = item.get("MOBILE_NO").toString();
		String AREA_ID = item.get("AREA_ID").toString();
		String USERNM = item.get("USER_NM").toString();
		String SYSGUBUN = item.get("SYS_GUBUN").toString();
		String TITLE = item.get("TITLE").toString();
		String CONT = item.get("CONT").toString();
		String LINK = item.get("LINK").toString();
		
		String azureNotificationHubConnectionString = env.getProperty("azure.azureNotificationHubConnectionString");
		azureNotificationHubConnectionString = "Endpoint=sb://dg-dgmc-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=e6Pq0mW0y1VfJPji0dr53qdIjmImypFj7MqQ7HJuAyI=";
		String azureNotificationHubName = env.getProperty("azure.azureNotificationHubName");
		azureNotificationHubName = "dgmc";
		NotificationHub hub = new NotificationHub(azureNotificationHubConnectionString, azureNotificationHubName);
		// hub.sendNotificationAsync(notification, callback);

		JsonObject data = new JsonObject();
		data.addProperty("USERSEQ", USERSEQ);
		data.addProperty("USERNM", USERNM);
		data.addProperty("AREAID", AREA_ID);
		data.addProperty("SYSGUBUN", SYSGUBUN);
		data.addProperty("TITLE", TITLE);
		data.addProperty("CONT", CONT);
		data.addProperty("LINK", LINK);

		JsonObject notification = new JsonObject();

		notification.add("data", data);

		// send to tags
		Set<String> androidTags = new HashSet<String>();
		androidTags.add("phone_" + MOBILENO.replace("-", ""));

		Notification n = Notification.createGcmNotification(notification.toString());

		if (n != null) {
			try {
				hub.sendNotification(n, androidTags);
			} catch (Exception e) {
			}

		}

	}

}
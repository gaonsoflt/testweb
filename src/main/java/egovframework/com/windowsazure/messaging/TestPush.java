package egovframework.com.windowsazure.messaging;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class TestPush {

	public static void main(String[] args) {
		// NamespaceManager namespaceManager = new NamespaceManager(
		// "Endpoint=sb://gaonsoft-scs.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=k6IonnY59um10LWf488IIa+aTp08QiLcuDeVWD7TYqk=");

		NotificationHub hub = new NotificationHub(
				"Endpoint=sb://gaonsoft-scs.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=rCjFn2cQ4WU8BOeGRHMlXYMZhg+xR+ZtmONhqU+8i2E=", "scs");

		String id = hub.createRegistrationId();
//		GcmRegistration reg = new GcmRegistration(id, "APA91bH3x0J8QoLzL076CR4-wypKBMXoUnb74yvz-ZzHBNZePC_rMIOFtS_V-rnON73UpmTVQR8jvGvtX-F3hs_08z78UOtvoI9mG4gvzECZnZTT-DD6j39UBVXwwwH4VGd4-hfTm1T3");
		GcmRegistration reg = new GcmRegistration(id, "APA91bEGVFeDhminXc3QS22AYp2iBul7ySBWShtI7w2S-QPPESfhpQo2E9PKfR0MCHXCI8WVk3D7Rtva_JSX5ZwZqn5Bbc5w7IBVSsJZ5Ho6T2nfcI_lgUjLDTgPQi4WPh_LOkxzO4Zo");
		
		reg.getTags().add("gs002");
		reg.getTags().add("01047981239");
		reg.getTags().add("wonseock@gaonsoft.com");
		Registration registration = hub.upsertRegistration(reg);

		// GcmRegistration gcm = new GcmRegistration(registrationId,
		// gcmRegistrationId)

		CollectionResult result = hub.getRegistrationsByTag("gs002");
		
		List<Registration> registrationList = result.getRegistrations();

//		if (registrationList != null && registrationList.size() > 5) {
//			for (int i = 0; i < registrationList.size() - 5; i++) {
//				hub.deleteRegistrationAsync(registrationList.get(i), new FutureCallback<Object>() {
//					@Override
//					public void failed(Exception arg0) {
//					}
//
//					@Override
//					public void completed(Object arg0) {
//					}
//
//					@Override
//					public void cancelled() {
//					}
//				});
//			}
//
//		}

		// send to tags
		Set<String> tags = new HashSet<String>();
		tags.add("gs002");

		String message = "{\"data\":{\"title\":\"제목입니다\",\"msg\":\"Hello from Java!\"}}";
		Notification n = Notification.createGcmNotification(message);
		hub.sendNotification(n, tags);
	}

}

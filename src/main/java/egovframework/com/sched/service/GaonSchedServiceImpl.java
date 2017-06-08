/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.sched.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.CaseInsensitiveMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
//import egovframework.com.board.service.BoardMapper;
import egovframework.com.windowsazure.messaging.service.AzurePushService;
import egovframework.dgms.service.AppInfService;

/**
 * @Class Name : GaonBoardServiceImpl.java
 * @Description : Board Business Implement Class
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ --------- --------- ------------------------------- @
 *   2009.03.16 최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 * 		Copyright (C) by MOPAS All right reserved.
 */

@Service
public class GaonSchedServiceImpl extends EgovAbstractServiceImpl implements GaonSchedService {

	private static final Logger LOGGER = LoggerFactory.getLogger(GaonSchedServiceImpl.class);

	@Autowired
	private AzurePushService azurePushService;

	@Resource(name = "appInfService")
	private AppInfService appInfService;
	
	//@Autowired
	//private BoardMapper boardDAO;

	@Override
	@Scheduled(fixedDelay = 100 * 1000)
	public void sendPushAlarm() {
		Map paramMap = new HashMap();

		try {
			/*paramMap.put("id", "01049198289");
			paramMap.put("pw", "qwer");
			paramMap.put("deviceid", "42f6ea0a24af8f29");*/
			
			List result = appInfService.selectNotSendMobilePushInfo((HashMap<String, Object>)paramMap);

			ArrayList<String> duplicateArray = new ArrayList<String>();

			if (result != null && result.size() > 0) {
				for (int i = 0; i < result.size(); i++) {
					CaseInsensitiveMap item = (CaseInsensitiveMap) result.get(i);
					String PUSH_ID = item.get("PUSH_ID").toString();
					/*
					String OFFID = item.get("OFFID").toString();*/

					boolean isDuplicate = false;
					/*for (int j = 0; j < duplicateArray.size(); j++) {
						if (duplicateArray.get(j).toString().equals(OFFID)) {
							isDuplicate = true;
							break;
						}
					}*/
					String send_state="N";
					if (!isDuplicate) {
						//duplicateArray.add(OFFID);
						try
						{
							azurePushService.sendPushAlarm(item);
							send_state="Y";
						}
						catch(Exception e)
						{
							send_state="E";
							e.printStackTrace();
						}
					}

					// 보낸 후 업데이트
					HashMap<String, Object> updateMap = new HashMap();
					updateMap.put("push_id", PUSH_ID);
					updateMap.put("send_state", send_state);

					appInfService.updateMobilePushInfo(updateMap);

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}

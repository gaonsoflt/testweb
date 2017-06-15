package egovframework.com.login.security;

import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import egovframework.com.login.service.CmmLoginUser;
import egovframework.systemmgr.service.SystemMgrLoginHistoryService;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);

	@Resource(name = "systemMgrLoginHistoryService")
	private SystemMgrLoginHistoryService systemMgrLoginLogService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		/** ip **/
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		/** device **/
		String browser = request.getHeader("User-Agent");
		Device device = DeviceUtils.getCurrentDevice(request);
		String deviceType = "unknown";
		if (device != null) {
			if (device.isNormal()) {
				deviceType = "nomal";
				if (browser.indexOf("MSIE") > 0 || browser.indexOf("Trident") > 0) {
					browser = "IE";
				} else if (browser.indexOf("Opera") > 0 || browser.indexOf("OPR") > 0) {
					browser = "Opera";
				} else if (browser.indexOf("Firefix") > 0) {
					browser = "Firefox";
				} else if (browser.indexOf("Safari") > 0) {
					if (browser.indexOf("Chrome") > 0) {
						browser = "Chrome";
					} else {
						browser = "Safari";
					}
				}
				deviceType += "(" + browser + ")";
			} else if (device.isMobile()) {
				deviceType = "mobile";
			} else if (device.isTablet()) {
				deviceType = "tablet";
			}
		}

		CmmLoginUser user = (CmmLoginUser) authentication.getPrincipal();
		logger.info("##### Hello " + user.getFullname());
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_seq", user.getUserseq());
		param.put("log_type", "I"); // I: login, O: logout
		param.put("req_ip", ip);
		param.put("req_device", deviceType);
		logger.debug("param: " + param);

		try {
			int execute = systemMgrLoginLogService.insertLoginHistory(param);
			if (execute > 0) {
				logger.debug("created login history");
			} else {
				logger.debug("failed login history");
			}
		} catch (Exception e) {
			logger.debug("failed login history: " + e.getMessage());
		}

		super.onAuthenticationSuccess(request, response, authentication);
	}
}

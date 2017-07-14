package egovframework.systemmgr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import egovframework.common.util.PwdEncryptor;
import egovframework.systemmgr.service.SystemMgrSignupUserService;

@Service("systemMgrSignupUserService")
public class SystemMgrSignupUserServiceImpl implements SystemMgrSignupUserService {
	Logger logger = LoggerFactory.getLogger(SystemMgrSignupUserServiceImpl.class);

	@Resource(name = "systemMgrSignupUserMapper")
	private SystemMgrSignupUserMapper signupMapper;

	@Autowired 
	private JavaMailSender mailSender;
		
	@Override
	public List<Map<String, Object>> getSignupUserList(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return signupMapper.readSignupUserList(param);
	}

	@Override
	public boolean existSignupUser(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		if(signupMapper.existUserID(param) > 0) {
			return true;
		}
		return false;
	}

	@Override
	public int getSignupUserListCount(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return signupMapper.readSignupUserListCount(param);
	}

	@Override
	public int registerSignupUser(Map<String, Object> param) throws Exception {
		param.put("confirm_uuid", UUID.randomUUID().toString());
		logger.debug("param: " + param);
		String plain = param.get("password").toString();
		if(plain != null && plain.isEmpty() && plain.trim().equals("")) {
			param.put("password",PwdEncryptor.getEncrypt(plain.trim()));
		}
		int exeCnt = signupMapper.createSignupUser(param);
		if(exeCnt > 0) {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setTo(param.get("email").toString());
				messageHelper.setFrom("espa@gaonsoft.com");
				messageHelper.setSubject("[ESPA] 회원가입 이메일 확인");
				String content = "<a href=\"http://localhost:8080/ESPA/signup/confirm.do?uid=" + param.get("confirm_uuid").toString() + "\">이메일 확인</a>";
				messageHelper.setText(content, true);
				mailSender.send(message);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return exeCnt;
	}

	@Override
	public int approveSignupUser(String userID, boolean approval) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("user_id", userID);
		param.put("approval", approval);
		logger.debug("param: " + param);
		return signupMapper.approvalSignupUser(param);
	}

	@Override
	public int deleteSignupUser(Map<String, Object> param) throws Exception {
		logger.debug("param: " + param);
		return signupMapper.deleteSignupUser(param);
	}

	@Override
	public boolean confirmEmail(String uuid) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("confirm_uuid", uuid);
		logger.debug("param: " + param);
		if(signupMapper.confirmEmail(param) > 0) {
			return true;
		}
		return false;
	}
}

package egovframework.com.user.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.user.service.UserInfoService;
import egovframework.com.user.service.UserInfoVo;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
	
	@Resource(name = "userMapper")
	private UserMapper userMapper;
	
	@SuppressWarnings("unchecked")
	public List<UserInfoVo> retrieveUser(UserInfoVo userInfoVo) throws Exception {
		return (List<UserInfoVo>) userMapper.retrieveUser(userInfoVo);
	}
	
	public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception{
		return userMapper.retrieveUserInfo(map);
	}

	public void insertUserLoginLog(HashMap<String, Object> map) throws Exception{
		userMapper.insertUserLoginLog(map);
	}
	
}

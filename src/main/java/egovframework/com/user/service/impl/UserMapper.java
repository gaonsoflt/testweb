package egovframework.com.user.service.impl;

import java.util.HashMap;

import egovframework.com.user.service.UserInfoVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("userMapper")
public interface UserMapper {
	
	public UserInfoVo retrieveUser(UserInfoVo userInfoVo) throws Exception;
	
	public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception;
	
	public void insertUserLoginLog(HashMap<String, Object> map) throws Exception;

}

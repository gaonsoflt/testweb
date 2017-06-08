package egovframework.com.user.service;

import java.util.HashMap;
import java.util.List;

public interface UserInfoService {

    public List<UserInfoVo> retrieveUser(UserInfoVo userInfoVo) throws Exception;
    
    public HashMap<String, Object> retrieveUserInfo(HashMap<String, Object> map) throws Exception;

	public void insertUserLoginLog(HashMap<String, Object> map) throws Exception;
}

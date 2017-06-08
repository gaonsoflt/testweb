package egovframework.com.login.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.StandardPasswordEncoder;

import egovframework.com.user.service.UserInfoService;
import egovframework.dgms.util.PwdEncryptor;

public class CmmLoginService implements UserDetailsService {

    @Autowired
    protected UserInfoService userInfoService;
    
	public UserDetails loadUserByUsername(String input) throws UsernameNotFoundException {
		// split combinedInput(username:areaId)
		String username = input;
		
        CmmLoginUser user = new CmmLoginUser();
        user.setUsername(username);

        HashMap<String, Object> searchMap = new HashMap<String, Object>();
        searchMap.put("USER_ID", username);

        //UserInfoVo userInfoVO = null;
        HashMap<String, Object> userInfoMap = null;
        try {
        	userInfoMap = userInfoService.retrieveUserInfo(searchMap);
        	
        } catch (Exception e) {
            throw new UsernameNotFoundException("로그인 정보가 존재하지 않습니다.");
        }
        
        user.setUserseq(userInfoMap.get("user_seq").toString());
        user.setUsername(userInfoMap.get("user_id").toString());
        user.setPassword(userInfoMap.get("password").toString().trim());
        user.setFullname(userInfoMap.get("user_name").toString());
        user.setAuthority("ROLE_USER");
        //user.setAuthority("ROLE_SYSTEM");
        //user.setAuthority("ROLE_ADMIN");
        
/*        if (userInfoVO.getDelAt())
            user.setEnabled(false);
        else if (userInfoVO.getUserStatus().equals("N"))
            user.setAccountNonLocked(false);

        if (!userInfoVO.getUserType().equals("ROLE_USER")) {
            user.setAuthority(userInfoVO.getUserType());
            if (userInfoVO.getUserType().equals("ROLE_SYSTEM"))
                user.setAuthority("ROLE_ADMIN");
        }*/

        return user;
    }
}

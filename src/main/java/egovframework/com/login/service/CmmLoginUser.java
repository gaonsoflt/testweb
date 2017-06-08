package egovframework.com.login.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CmmLoginUser implements UserDetails {

    /**
	 * 
	 */
	private static final long serialVersionUID = 5325239308084906709L;
	
	private String userseq;
	private String username;
    private String password;
    private String fullname;
    private String fileLibCode;
    private String userType;
    private String areaId2;
    private String areaId;
    private String areaNm;
    private String townId;

	private boolean isEnabled = true;
    private boolean isNonExpired = true;
    private boolean isNonLocked = true;
    private boolean isCredentialsNonExpired = true;

    List<GrantedAuthority> authorities;

    
    
	public String getAreaNm() {
		return areaNm;
	}

	public void setAreaNm(String areaNm) {
		this.areaNm = areaNm;
	}

	public String getTownId() {
		return townId;
	}

	public void setTownId(String townId) {
		this.townId = townId;
	}

	public String getUserseq() {
		return userseq;
	}

	public void setUserseq(String userseq) {
		this.userseq = userseq;
	}

	public String getAreaId2() {
		return areaId2;
	}

	public void setAreaId2(String areaId2) {
		this.areaId2 = areaId2;
	}

    public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public CmmLoginUser() {
        authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
    }

    public void setAuthority(String authority) {
        authorities.add(new SimpleGrantedAuthority(authority));
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return isNonExpired;
    }

    public void setAccountNonExpired(boolean accountNonExpired) {
        this.isNonExpired = accountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isNonLocked;
    }

    public void setAccountNonLocked(boolean accountNonLocked) {
        this.isNonLocked = accountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isCredentialsNonExpired;
    }

    public void setCredentialNonExpired(boolean credentialsNonExpired) {
        this.isCredentialsNonExpired = credentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return isEnabled;
    }

    public void setEnabled(boolean enabled) {
        this.isEnabled = enabled;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getFileLibCode() {
        return fileLibCode;
    }

    public void setFileLibCode(String fileLibCode) {
        this.fileLibCode = fileLibCode;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
}
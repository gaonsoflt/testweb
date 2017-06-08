package egovframework.com.login.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;

import egovframework.com.login.service.CmmLoginUser;

public class SessionTimeOutFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(SessionCheckFilter.class.getName());
	
	private FilterConfig config;	
	
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		logger.debug("----------------------------------------------------------> SessionCheckFilter");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		
		
		try{
			logger.debug("----------------------------------------------------------> doFilter");
			CmmLoginUser userDetails = (CmmLoginUser)req.getSession().getAttribute("userLoginInfo");
			logger.debug("----------------------------------------------------------> SessionCheckFilter userDetails.getUsername:"+userDetails.getUsername());
			chain.doFilter(req,res);
		}catch(AccessDeniedException ade){
			logger.debug("----------------------------------------------------------> AccessDeniedException");
			HttpServletResponse servletResponse = (HttpServletResponse)response;
			servletResponse.sendRedirect(req.getContextPath()+"/com/login/login.do");
			chain.doFilter(req,servletResponse);
		}catch(Exception e){
			logger.debug("----------------------------------------------------------> Exception");
			HttpServletResponse servletResponse = (HttpServletResponse)response;
			servletResponse.sendRedirect(req.getContextPath()+"/com/login/login.do");
			chain.doFilter(req,servletResponse);
		}
		
        
	}
	
	@Override
	public void destroy() {
	}
}
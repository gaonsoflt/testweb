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

import egovframework.com.login.service.CmmLoginUser;

public class SessionCheckFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(SessionCheckFilter.class.getName());
	
	private FilterConfig config;	
	
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		logger.debug("----------------------------------------------------------> SessionCheckFilter");
		HttpServletRequest httprequest = (HttpServletRequest)request;
		
		CmmLoginUser userDetails = (CmmLoginUser)httprequest.getSession().getAttribute("userLoginInfo");
		
		
		
		logger.debug("----------------------------------------------------------> httprequest.getRequestURI():"+httprequest.getRequestURI());
		logger.debug("----------------------------------------------------------> httprequest.getContextPath():"+httprequest.getContextPath());
		logger.debug("----------------------------------------------------------> httprequest.getRequestURI().indexOf():"+httprequest.getRequestURI().indexOf("/com/login/login.do"));
		///DGMS/com/login/login.do
		
		if(httprequest.getRequestURI().indexOf("com/login/") < 0 ){
			if( userDetails == null || userDetails.getUsername().isEmpty() == true ){
				logger.debug("------------------------------------------------>userDetails == null");
				
				
				
				logger.debug("1111111111111111111111111111111111111111111111111111111111");
				chain.doFilter(request,response);
				
				HttpServletResponse servletResponse = (HttpServletResponse)response;
				servletResponse.sendRedirect(httprequest.getContextPath()+"/com/login/login.do");
			}else{
				logger.debug("----------------------------------------------------------> SessionCheckFilter userDetails.getUsername:"+userDetails.getUsername());
				logger.debug("222222222222222222222222222222222222222222222222222222222222");
				chain.doFilter(request,response);
			}
		}else{
			logger.debug("33333333333333333333333333333333333333333333");
			chain.doFilter(request,response);
		}
        
	}
	
	@Override
	public void destroy() {
	}
}

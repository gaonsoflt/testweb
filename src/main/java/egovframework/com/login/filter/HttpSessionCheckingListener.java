package egovframework.com.login.filter;

import java.util.Date;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpSessionCheckingListener implements HttpSessionListener {

	Logger logger = LoggerFactory.getLogger(HttpSessionCheckingListener.class.getName());

    public void sessionCreated(HttpSessionEvent event) {
    	logger.debug("------------------------------------------------->Session ID".concat(event.getSession().getId()).concat(" created at ").concat(new Date().toString()));
    }

    public void sessionDestroyed(HttpSessionEvent event) {
    	logger.debug("------------------------------------------------->Session ID".concat(event.getSession().getId()).concat(" destroyed at ").concat(new Date().toString()));
    }
}


package egovframework.espa.core.execute.handler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.espa.util.StringUtil;

public class ESPAExecuteGradingHandlerImpl implements ESPAExecuteGradingHandler {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteGradingHandlerImpl.class.getName());

	@Override
	public double grade(String gradingOutput, String userOutput) {
		double scoreRate = 1.0;
		if (StringUtil.compareStringByTokenizer(gradingOutput, userOutput)) {
			logger.error("equals with grading output between output");
			scoreRate = 1.0;
		} else {
			logger.error("not equals with grading output between output");
			scoreRate = 0.0;
		}
		return scoreRate;
	}
}

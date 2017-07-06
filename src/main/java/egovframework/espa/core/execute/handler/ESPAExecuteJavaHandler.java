package egovframework.espa.core.execute.handler;

import java.io.File;

import org.apache.commons.exec.CommandLine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.common.util.FileUtil;
import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;
import egovframework.espa.util.ExecuteUtil;

public class ESPAExecuteJavaHandler extends ESPAExecuteHandler {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteJavaHandler.class.getName());
	
	String compilePath;
	String runPath;
	String clsName;
	String clsFileName;
	String filePath;
	String absolutFile;
	String inputFileName;
	String inputFilePath;
	String outputFileName;
	String outputFilePath;
	
	public ESPAExecuteJavaHandler(ESPAExecuteVO vo, ConfigService config) {
		this.vo = vo;
		this.config = config;
		if(vo.getGradingHandler() != null) {
			this.gradingHandler = vo.getGradingHandler();
		}
		setConfig();
	}
	
	public void setConfig() {
		compilePath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "javac.exe";
		runPath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "java.exe";
		if (vo.isTest()) {
			clsName = config.getEspaConfigVoValue("JAVA_TEST_CLS_NAME");
		} else {
			clsName = config.getEspaConfigVoValue("JAVA_CLS_NAME");;
		}
		clsFileName = clsName + ".java";
		filePath = config.getEspaConfigVoValue("JAVA_SRC_PATH");
		absolutFile = filePath + File.separator + clsFileName;	
		inputFileName = config.getEspaConfigVoValue("INPUT_FILE_NAME");
		inputFilePath = config.getEspaConfigVoValue("JAVA_INPUT_PATH");
		outputFileName = config.getEspaConfigVoValue("OUTPUT_FILE_NAME");
		outputFilePath = config.getEspaConfigVoValue("JAVA_OUTPUT_PATH");
	}

	@Override
	protected boolean createSourceFile() throws ESPAExecuteException {
		logger.debug("create execute file: " + absolutFile);
		if (!FileUtil.writeFile(clsFileName, filePath, vo.getCode(), false)) {
			logger.error("fail to create execute file");
			throw new ESPAExecuteException("can not create execute file", ESPAExcuteCode.ERR_CRE_FILE);
		}
		return true;
	}

	@Override
	protected boolean compile() throws ESPAExecuteException {
		try {
			CommandLine cmd = new CommandLine(compilePath);
			cmd.addArgument(absolutFile);
			logger.debug("execute compile: " + cmd.toString());
			ExecuteUtil.byCommonsExec(cmd);
			return true;
		} catch (Exception e) {
			logger.error("fail to execute compile");
			throw new ESPAExecuteException("fail to execute compile", ESPAExcuteCode.ERR_EXEC);
		}
	}

	@Override
	protected long run() throws ESPAExecuteException {
		try {
			CommandLine cmd = new CommandLine(runPath);
			cmd.addArgument("-cp");
			cmd.addArgument(filePath);
			cmd.addArgument(clsName);
			logger.debug("execute run: " + cmd.toString());
			ESPAExecuteResultVO _rtn = ExecuteUtil.byCommonsExec(cmd, vo.getTimeout());
			logger.debug("\n" + _rtn.getExecuteOutStream());
			logger.debug("success to excute run");
			return _rtn.getExecuteTime();
		} catch (ESPAExecuteException e) {
			logger.error("fail to execute run");
			throw e;
		}		
	}

	@Override
	protected boolean createInputFile(String content) throws ESPAExecuteException {
		if (!FileUtil.writeFile(inputFileName, inputFilePath, content, false)) {
			logger.error("fail to create input file");
			throw new ESPAExecuteException("can not create grading input file", ESPAExcuteCode.ERR_CRE_FILE);
		}
		return true;
	}

	@Override
	protected String readOutputFile() throws ESPAExecuteException {
		StringBuilder output = FileUtil.readFile(outputFileName, outputFilePath);
		if (output == null) {
			logger.error("fail to read output file");
			throw new ESPAExecuteException("can not read output file", ESPAExcuteCode.ERR_READ_FILE);
		}
		logger.debug("success to read output file");
		logger.debug("output: " + output.toString());
		return output.toString();
	}
}

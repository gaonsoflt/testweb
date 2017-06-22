package egovframework.espa.service;

import java.io.File;
import java.util.HashMap;

import org.apache.commons.exec.CommandLine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.common.util.ExecuteUtil;
import egovframework.common.util.FileUtil;
import egovframework.espa.dao.ESPAExecuteVO;

public class ESPAExecuteAgent {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteAgent.class.getName());
	
	String[] executeParam;
	long executeTime = 0;
	
	public ESPAExecuteAgent(ESPAExecuteVO executeVo, ConfigService config) {
		setExecuteVo(executeVo);
		setConfig(config);
	}
	
	private ESPAExecuteVO executeVo;
	public void setExecuteVo(ESPAExecuteVO executeVo) {
		this.executeVo = executeVo;
	}

	private ConfigService config;
	public ConfigService getConfig() {
		return config;
	}

	public void setConfig(ConfigService config) {
		this.config = config;
	}

	public void execute() throws Exception {
		if(executeVo == null) {
			throw new NullPointerException("ESPAExecuteVO is null");
		}
		
		if(executeVo.getLanguage().equals("JAVA")) {
			executeJava();
		} else if(executeVo.getLanguage().equals("C")) {
			throw new Exception("not support execute C");
		} else if(executeVo.getLanguage().equals("C++")) {
			throw new Exception("not support execute C++");
		} else if(executeVo.getLanguage().equals("Phython")) {
			throw new Exception("not support execute Phython");
		}
	}
	
	private void executeJava() throws Exception {
		String compilePath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "javac.exe";
		String runPath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "java.exe";
		String clsName;
		if(executeVo.isTest()) {
			clsName = config.getEspaConfigVoValue("JAVA_TEST_CLS_NAME");
		} else {
			// TODO: get user testcode 
			clsName = "";
		}
		String clsFileName = clsName + ".java";
		String filePath =  config.getEspaConfigVoValue("JAVA_SRC_PATH");
		String absolutFile = filePath + File.separator + clsFileName;
		
		String[] executeParam;
		
		// 1. create execute file(.java, .c, ccp...)
		if(!FileUtil.writeFile(clsFileName, filePath, executeVo.getCode(), false)) {
			logger.error("fail to create execute file");
			// TODO: add handler for failed create execute file 
			throw new Exception("can not create execute file");
		}
		logger.error("success to create execute file");
		
		// 2. execute compile
		try {
			ExecuteUtil.byCommonsExec(compilePath + " " + absolutFile);
			logger.debug("success to excute compile");
		} catch(Exception e) {
			logger.error("fail to execute compile");
			// TODO: add handler for failed compile 
			throw e;
		}

		String inputFileName = config.getEspaConfigVoValue("INPUT_FILE_NAME");
		String inputFilePath = config.getEspaConfigVoValue("JAVA_INPUT_PATH");
		String outputFileName = config.getEspaConfigVoValue("OUTPUT_FILE_NAME");
		String outputFilePath = config.getEspaConfigVoValue("JAVA_OUTPUT_PATH");
		logger.debug("create input/output file size: " + executeVo.getGrading().size());
		for (int i = 0; i < executeVo.getGrading().size(); i++) {
			HashMap<String, Object> grading = executeVo.getGrading().get(i);
			logger.debug("create input file: " + (i + 1));
			
			// 3. create input file as much as grading size
			if(!FileUtil.writeFile(inputFileName, inputFilePath, grading.get("grading_input").toString(), false)) {
				logger.error("fail to create input file");
				// TODO: add handler for failed create input file
				throw new Exception("can not create input file");
			}
			logger.debug("success to create input file");
			
			// 4. create ouput file as 
			if(!FileUtil.writeFile(outputFileName, outputFilePath, grading.get("grading_output").toString(), false)) {
				logger.error("fail to create output file");
				// TODO: add handler for failed create input file
				throw new Exception("can not create output file");
			}
			logger.debug("success to create output file");
			
			// 5. execute run
			try {
				// not working CommandLine maybe Program Files include space
				CommandLine cmd = new CommandLine(runPath);
				cmd.addArgument(clsName);
				logger.debug("execute run: "+ cmd.toString());
				long start = System.nanoTime();
				String result = ExecuteUtil.byCommonsExec(runPath + " " + clsName);
//				logger.debug(ExecuteUtil.byCommonsExec(cmd));
				executeTime = System.nanoTime() - start;
				logger.debug(result);
				logger.debug("execute time: " + (executeTime / 1000) + "ms");
				// TODO: check running time
				logger.debug("success to excute run");
			} catch(Exception e) {
				logger.error("fail to execute run");
				// TODO: add handler for failed run 
				throw e;
			}
			
			// 6. read output file
			StringBuilder sb = FileUtil.readFile(outputFileName, outputFilePath);
			if(sb == null) {
				logger.error("fail to read output file");
				// TODO: add handler for failed read output file
				throw new Exception("can not read output file");
			}
			logger.debug("success to read output file");
			logger.debug("output: " + sb.toString());
			
			// 7. compare with output between output file
		}
	}
}

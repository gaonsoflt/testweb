package egovframework.espa.core.execute.handler;

import java.io.File;
import java.util.HashMap;

import org.apache.commons.exec.CommandLine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.common.util.FileUtil;
import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.dao.ESPAExecuteResultVO;
import egovframework.espa.dao.ESPAExecuteVO;
import egovframework.espa.service.ConfigService;
import egovframework.espa.util.ExecuteUtil;
import egovframework.espa.util.StringUtil;

public class ESPAExecuteJavaHandler extends ESPAExecuteHandler {
	private Logger logger = LoggerFactory.getLogger(ESPAExecuteJavaHandler.class.getName());
	
	public ESPAExecuteJavaHandler(ESPAExecuteVO vo, ConfigService config) {
		this.vo = vo;
		this.config = config;
		if(vo.getGradingHandler() != null) {
			this.gradingHandler = vo.getGradingHandler();
		}
	}

	@Override
	public void execute() throws ESPAExecuteException {
		long start = System.nanoTime();
		String compilePath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "javac.exe";
		String runPath = config.getEspaConfigVoValue("JAVA_HOME") + File.separator + "bin" + File.separator + "java.exe";
		String clsName;
		if (vo.isTest()) {
			clsName = config.getEspaConfigVoValue("JAVA_TEST_CLS_NAME");
		} else {
			clsName = config.getEspaConfigVoValue("JAVA_CLS_NAME");;
		}
		String clsFileName = clsName + ".java";
		String filePath = config.getEspaConfigVoValue("JAVA_SRC_PATH");
		String absolutFile = filePath + File.separator + clsFileName;

		// 0. check ban_keyword
		logger.debug("check ban_keyword");
		for (String keyword : vo.getBanKeyword()) {
			if (!keyword.isEmpty()) {
				boolean included = StringUtil.existString(vo.getCode(), keyword);

				if (included) {
					logger.error("ban_keyword [" + keyword + "] is included");
					setBanKeyword(true);
					throw new ESPAExecuteException("include ban keyword in code", ESPAExcuteCode.ERR_BAN_KW);
				}
				logger.debug("ban_keyword [" + keyword + "] is not included");
			}
		}
		logger.debug("pass to check ban_keyword");

		// 1. create execute file(.java, .c, ccp...)
		logger.debug("create execute file: " + absolutFile);
		if (!FileUtil.writeFile(clsFileName, filePath, vo.getCode(), false)) {
			logger.error("fail to create execute file");
			throw new ESPAExecuteException("can not create execute file", ESPAExcuteCode.ERR_CRE_FILE);
		}
		logger.debug("success to create execute file");

		// 2. execute compile
		try {
			CommandLine cmd = new CommandLine(compilePath);
			cmd.addArgument(absolutFile);
			logger.debug("execute compile: " + cmd.toString());
			ExecuteUtil.byCommonsExec(cmd);
			logger.debug("success to excute compile");
		} catch (Exception e) {
			logger.error("fail to execute compile");
			throw new ESPAExecuteException("fail to execute compile", ESPAExcuteCode.ERR_EXEC);
		}
		
		// ready(true) = completed compile and not include ban keyword
		String inputFileName = config.getEspaConfigVoValue("INPUT_FILE_NAME");
		String inputFilePath = config.getEspaConfigVoValue("JAVA_INPUT_PATH");
		String outputFileName = config.getEspaConfigVoValue("OUTPUT_FILE_NAME");
		String outputFilePath = config.getEspaConfigVoValue("JAVA_OUTPUT_PATH");
		logger.debug("create input/output file size: " + vo.getGrading().size());
		for (int i = 0; i < vo.getGrading().size(); i++) {
			ESPAExecuteResultVO result = new ESPAExecuteResultVO();
			HashMap<String, Object> grading = vo.getGrading().get(i);
			result.setQuestionSeq(Long.valueOf(vo.getQuestionSeq()));
			result.setGradingSeq(Long.valueOf(grading.get("grading_seq").toString()));
			result.setGradingOrder(Long.valueOf(grading.get("grading_order").toString()));
			result.setUserSeq(vo.getUserSeq());
			result.setDeploySeq(vo.getDeploySeq());
			result.setSubmitDt(vo.getSubmitDt());

			logger.debug("create input file: " + (i + 1));
			// 3. create grading input file as much as grading size
			if (!FileUtil.writeFile(inputFileName, inputFilePath, grading.get("grading_input").toString(), false)) {
				logger.error("fail to create input file");
				result.setException(
						new ESPAExecuteException("can not create grading input file", ESPAExcuteCode.ERR_CRE_FILE));
			}
			logger.debug("success to create input file");

			// 4. execute run
			try {
				CommandLine cmd = new CommandLine(runPath);
				cmd.addArgument("-cp");
				cmd.addArgument(filePath);
				cmd.addArgument(clsName);
				logger.debug("execute run: " + cmd.toString());
				ESPAExecuteResultVO _rtn = ExecuteUtil.byCommonsExec(cmd, vo.getTimeout());
				logger.debug("\n" + _rtn.getExecuteOutStream());
				result.setExecuteTime(_rtn.getExecuteTime());
				logger.debug("success to excute run");
			} catch (ESPAExecuteException e) {
				logger.error("fail to execute run");
				result.setException(e);
			}

			// logger.debug("success to read grading Output file");
			String gradingOutput = grading.get("grading_output").toString();
			logger.debug("gradingOutput: " + gradingOutput);

			// 5. read executed output file
			StringBuilder output = FileUtil.readFile(outputFileName, outputFilePath);
			if (output == null) {
				logger.error("fail to read output file");
				result.setException(
						new ESPAExecuteException("can not read output file", ESPAExcuteCode.ERR_READ_FILE));
			}
			logger.debug("success to read output file");
			logger.debug("output: " + output.toString());

			// 6. compare with output between output file
			double socoreRate = gradingHandler.grade(gradingOutput, output.toString());
			if (socoreRate == 0) {
				result.setException(new ESPAExecuteException("not equals with grading output between output",
						ESPAExcuteCode.ERR_NOT_EQUALS));
			}
			result.setSocoreRate(socoreRate);
			getResult().add(result);
		}
		start = System.nanoTime() - start;
		logger.debug("total execution time: " + (start / 1000000) + "ms");
	}
}

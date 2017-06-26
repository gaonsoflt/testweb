package egovframework.espa.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.apache.commons.exec.ExecuteWatchdog;
import org.apache.commons.exec.PumpStreamHandler;

import egovframework.espa.core.execute.ESPAExecuteException;
import egovframework.espa.core.execute.ESPAExcuteCode;
import egovframework.espa.dao.ESPAExecuteResultVO;

public class ExecuteUtil {

	/**
	 * 
	 * @param String
	 * @return outputStream
	 * @throws ESPAExecuteException 
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static ESPAExecuteResultVO byCommonsExec(String cmd) throws ESPAExecuteException {
		CommandLine commandline = CommandLine.parse(cmd);
		return ExecuteUtil.byCommonsExec(commandline);
	}

	/**
	 * 
	 * @param CommandLine
	 * @return outputStream
	 * @throws ESPAExecuteException 
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static ESPAExecuteResultVO byCommonsExec(CommandLine cmd) throws ESPAExecuteException {
		return ExecuteUtil.byCommonsExec(cmd, -1);
	}

	/**
	 * 
	 * @param CommandLine,
	 *            time
	 * @param timeout
	 * @return
	 * @throws ESPAExecuteException 
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static ESPAExecuteResultVO byCommonsExec(CommandLine cmd, long timeout) throws ESPAExecuteException{
		ESPAExecuteResultVO resultVo = new ESPAExecuteResultVO();
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		DefaultExecutor exec = new DefaultExecutor();
		PumpStreamHandler streamHandler = new PumpStreamHandler(outputStream);
		ExecuteWatchdog watchdog = new ExecuteWatchdog(timeout);
		exec.setWatchdog(watchdog);
		exec.setStreamHandler(streamHandler);
		int exitValue = 0;
		try {
			long start = System.nanoTime();
			exitValue = exec.execute(cmd);
			start = System.nanoTime() - start;
			resultVo.setExecuteOutStream(outputStream.toString());
			resultVo.setExecuteTime(start / 1000000);
			System.out.println("execute time: " + resultVo.getExecuteTime() + "ms");
		} catch (ExecuteException e) {
			e.printStackTrace();
			exitValue = e.getExitValue();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (exec.isFailure(exitValue) && watchdog.killedProcess()) {
			System.out.println("it was killed on purpose by the watchdog");
			throw new ESPAExecuteException("execute timeout", ESPAExcuteCode.ERR_TIMEOUT);
		} else if (exec.isFailure(exitValue)){
			throw new ESPAExecuteException("execute error", ESPAExcuteCode.ERR_EXEC);
		}
		return resultVo;
	}
}

package egovframework.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.apache.commons.exec.ExecuteWatchdog;
import org.apache.commons.exec.PumpStreamHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.espa.service.impl.QuestionExecuteServiceImpl;

public class ExecuteUtil {

	/**
	 * 
	 * @param String
	 * @return outputStream
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static String byCommonsExec(String cmd) throws IOException, InterruptedException {
		CommandLine commandline = CommandLine.parse(cmd);
		return ExecuteUtil.byCommonsExec(commandline);
	}

	/**
	 * 
	 * @param CommandLine
	 * @return outputStream
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static String byCommonsExec(CommandLine cmd) throws IOException, InterruptedException {
		return ExecuteUtil.byCommonsExec(cmd, -1);
	}

	/**
	 * 
	 * @param CommandLine,
	 *            time
	 * @param timeout
	 * @return
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static String byCommonsExec(CommandLine cmd, long timeout) throws IOException, InterruptedException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		DefaultExecutor exec = new DefaultExecutor();
		PumpStreamHandler streamHandler = new PumpStreamHandler(outputStream);
		ExecuteWatchdog watchdog = new ExecuteWatchdog(timeout);
		exec.setWatchdog(watchdog);
		exec.setStreamHandler(streamHandler);
		long start = System.nanoTime();
		int exitValue = 0;
		try {
			exitValue = exec.execute(cmd);
		} catch (ExecuteException e) {
			e.printStackTrace();
			exitValue = e.getExitValue();
		}
		start = System.nanoTime() - start;
		System.out.println("execute time: " + (start / 1000000) + "ms");
		if (exec.isFailure(exitValue) && watchdog.killedProcess()) {
			System.out.println("it was killed on purpose by the watchdog");
			throw new ExecuteException("timeout", exitValue);
		} else if (exec.isFailure(exitValue)){
			throw new ExecuteException("execute error", exitValue);
		}
		return outputStream.toString();
	}
}

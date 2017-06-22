package egovframework.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.PumpStreamHandler;

public class ExecuteUtil {
//	public void byCommonsExec(String[] command) throws IOException, InterruptedException {
//		byCommonsExec(command, null);
//	}
//
//	public void byCommonsExec(String[] command, DefaultExecuteResultHandler handler)
//			throws IOException, InterruptedException {
//		DefaultExecutor executor = new DefaultExecutor();
//		CommandLine cmdLine = CommandLine.parse(command[0]);
//		for (int i = 1; i < command.length; i++) {
//			cmdLine.addArgument(command[i]);
//		}
//		if (handler != null) {
//			executor.execute(cmdLine, handler);
//		} else {
//			executor.execute(cmdLine);
//		}
//	}
	
	/**
	 * 
	 * @param String
	 * @return outputStream
	 * @throws IOException
	 * @throws InterruptedException
	 */
	public static String byCommonsExec(String cmd) throws IOException,InterruptedException {
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
	public static String byCommonsExec(CommandLine cmd) throws IOException,InterruptedException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		DefaultExecutor exec = new DefaultExecutor();
		PumpStreamHandler streamHandler = new PumpStreamHandler(outputStream);
		exec.setStreamHandler(streamHandler);
		exec.execute(cmd);
		return outputStream.toString();
	}
}

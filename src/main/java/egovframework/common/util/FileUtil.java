package egovframework.common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class FileUtil {
	public static boolean writeFile(String fileName, String filePath, String content) {
		return writeFile(fileName, filePath, content, true);
	}
	
	public static boolean writeFile(String fileName, String filePath, String content, boolean append) {
		return writeFile(filePath + File.separator + fileName, content, append);
	}
	
	public static boolean writeFile(String file, String content, boolean append) {
		boolean rtn = false;
		System.out.println("[BBAEK] write file: " + file);
		System.out.println(content);
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new FileWriter(file, append));
			bw.write(content);
			bw.flush();
			rtn = true;
			System.out.println("[BBAEK] write file: successed");
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("[BBAEK] write file: failed");
		} finally {
			try {
				if(bw != null) bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return rtn;
	}
	
	public static StringBuilder readFile(String fileName, String filePath) {
		return readFile(filePath + File.separator + fileName);
	}
	
	public static StringBuilder readFile(String file) {
		StringBuilder rtn = new StringBuilder();
		System.out.println("[BBAEK] read file: " + file);
		BufferedReader br = null;
		try {
			String buff;
			br = new BufferedReader(new FileReader(file));
			while((buff = br.readLine()) != null) {
				rtn.append(buff).append("\n");
				System.out.println(buff);
			}
			System.out.println("[BBAEK] read file: successed");
		} catch (IOException e) {
			e.printStackTrace();
			rtn = null;
			System.out.println("[BBAEK] read file: failed");
		} finally {
			try {
				if(br != null) br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return rtn;
	}
	
	public static boolean deleteFile(String fileName, String filePath) {
		return deleteFile(filePath + File.separator + fileName);
	}
	public static boolean deleteFile(String file) {
		System.out.println("[BBAEK] delete file: " + file);
		File f = new File(file);
		
		boolean rtn = f.delete();
		if(rtn) {
			System.out.println("[BBAEK] delete file: successed");
		} else {
			System.out.println("[BBAEK] delete file: failed");
		}
		return rtn;
	}
}

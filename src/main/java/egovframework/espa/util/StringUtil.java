package egovframework.espa.util;

import java.util.StringTokenizer;

public class StringUtil {
	
	public static String NVL(String value, String sub) {
		if(value == null) {
			return sub;
		} 
		return value;
	}
	
	public static boolean existString(String source, String keyword) {
		if (source.indexOf(keyword) >= 0) {
			return true;
		}
		return false;
	}
	
	public static boolean compareStringByTokenizer(String a, String b) {
		return compareStringByTokenizer(a, b, null);
	}
	
	public static boolean compareStringByTokenizer(String a, String b, String delim) {
		StringTokenizer stA;
		StringTokenizer stB;
		if(delim != null) {
			stA = new StringTokenizer(a, delim);
			stB = new StringTokenizer(b, delim);
		} else {
			stA = new StringTokenizer(a);
			stB = new StringTokenizer(b);
		}			
		
		while(stA.hasMoreTokens() || stB.hasMoreTokens()) {
			try{
				String _a = stA.nextToken();
				String _b = stB.nextToken();
				boolean isEquals = _a.equals(_b);
				System.out.println("compare: " + _a + "=" + _b + ": " + isEquals);
				if(!isEquals) {
					return false;
				}
			} catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}
}

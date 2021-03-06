package egovframework.espa.util;

import java.util.Map;
import java.util.List;

public class QuestionUtil {

	public static float calculateScore(List<Map<String, Object>> grading) {
		int gradingCnt = grading.size();
		float score = 0;
		if (gradingCnt > 0) {
			try {
				float eachScore = 100 / gradingCnt; // base score 100
				for (Map<String, Object> grade : grading) {
					score += eachScore * Float.valueOf(grade.get("score_rate").toString());
				}
			} catch (Exception e) {
				return 0;
			}
		}
		return score;
	}
	
	public static int calculateAvgExectime(List<Map<String, Object>> grading) {
		int gradingCnt = grading.size();
		int exectime = 0;
		if (gradingCnt > 0) {
			try {
				for (Map<String, Object> grade : grading) {
					exectime += Integer.valueOf(grade.get("exec_time").toString());
				}
				exectime = exectime / grading.size();
			} catch (Exception e) {
				return 0;
			}
		}
		return exectime;
	}
}

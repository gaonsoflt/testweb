package egovframework.espa.util;

import java.util.HashMap;
import java.util.List;

public class QuestionUtil {

	public static float calculateScore(List<HashMap<String, Object>> grading) {
		int gradingCnt = grading.size();
		float score = 0;
		if (gradingCnt > 0) {
			try {
				float eachScore = 100 / gradingCnt; // base score 100
				for (HashMap<String, Object> grade : grading) {
					score += eachScore * Float.valueOf(grade.get("score_rate").toString());
				}
			} catch (Exception e) {
				return 0;
			}
		}
		return score;
	}
}

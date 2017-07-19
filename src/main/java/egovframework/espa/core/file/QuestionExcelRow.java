package egovframework.espa.core.file;

public enum QuestionExcelRow {
	IDX_TITLE("제목"),
	IDX_CON_QUESTION("문제설명"),
	IDX_CON_IO("입출력설명"),
	IDX_CON_EXAMPLE("예제(예시)"),
	IDX_CON_HINT("힌트"),
	IDX_LANGUAGE("언어"),
	IDX_MAX_CODESIZE("최대코드사이즈(단위:byte)"),
	IDX_TIMEOUT("실행제한시간(단위:ms)"),
	IDX_BAN_KEYWORD("금지어(,로 구분)"),
	IDX_TEST_CODE("테스트코드");
//	IDX_GRADING("채점데이터");
	
	private String msg;
	
	QuestionExcelRow(String msg) {
		this.msg = msg;
	}
	
	public String getMsg() {
		return msg;
	}
}

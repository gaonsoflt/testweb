package egovframework.espa.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.common.util.ExcelUtil;
import egovframework.espa.core.file.QuestionExcelRow;
import egovframework.espa.service.ConfigService;
import egovframework.espa.service.QuestionMgrService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.systemmgr.service.SystemMgrUserService;

@Service("questionMgrService")
public class QuestionMgrServiceImpl extends EgovAbstractServiceImpl implements QuestionMgrService {
	Logger logger = LoggerFactory.getLogger(QuestionMgrServiceImpl.class.getName());

	@Autowired
	private ConfigService config;

	@Resource(name = "questionMgrMapper")
	private QuestionMgrMapper questionMapper;

	@Resource(name = "questionConditionMapper")
	private QuestionConditionMapper questionConditionMapper;

	@Resource(name = "questionGradingMapper")
	private QuestionGradingMapper questionGradingMapper;

	@Resource(name = "systemMgrUserService")
	private SystemMgrUserService userService;

	@Override
	public List<Map<String, Object>> getQuestionList(Map<String, Object> map) throws Exception {
		return questionMapper.selectQuestionList(map);
	}

	@Override
	public List<Map<String, Object>> getQuestion(Map<String, Object> map) throws Exception {
		List<Map<String, Object>> result = questionMapper.selectQuestion(map);
		// init default value(timeout, ban_keyword) from espa config
		// if(result.size() > 0) {
		// if(result.get(0).get("timeout") == null) {
		// result.get(0).put("timeout",
		// Long.valueOf(config.getEspaConfigVoValue("DEFAULT_TIMEOUT")));
		// result.get(0).put("ban_keyword",
		// config.getEspaConfigVoValue("DEFAULT_BAN_KW"));
		// }
		// }
		return result;
	}

	@Override
	public List<Map<String, Object>> getQuestion(long seq) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("question_seq", seq);
		return getQuestion(param);
	}

	@Override
	public int getQuestionAllCount(Map<String, Object> map) throws Exception {
		return questionMapper.selectQuestionAllCount(map);
	}

	@Override
	public int createQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.insertQuestion(map);
		logger.debug("[BBAEK] get pk:" + map);
		// List<Map<String, Object>> list;
		// if(map.get("condition") != null) {
		// list = (List<Map<String, Object>>) map.get("condition");
		// for (Map<String, Object> param : list) {
		// logger.debug("[BBAEK] create condition param:" + param);
		// param.put("question_seq", map.get("question_seq"));
		// execute += questionConditionService.createCondition(param);
		// }
		// }

		// if(map.get("grading") != null) {
		// list = (List<Map<String, Object>>) map.get("grading");
		// for (Map<String, Object> param : list) {
		// logger.debug("[BBAEK] create grading param:" + param);
		// param.put("question_seq", map.get("question_seq"));
		// execute += questionGradingMapper.insertGrading(param);
		// }
		// }
		return execute;
	}

	@Override
	public int updateQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.updateQuestion(map);
		logger.debug("[BBAEK] delete question condition/answer:" + map.get("question_seq"));
		// List<Map<String, Object>> list;
		// if(map.get("condition") != null) {
		// questionConditionMapper.deleteCondition(map);
		// list = (List<Map<String, Object>>) map.get("condition");
		// for (Map<String, Object> param : list) {
		// logger.debug("[BBAEK] create condition param:" + param);
		// param.put("question_seq", map.get("question_seq"));
		// execute += questionConditionService.createCondition(param);
		// }
		// }

		// if(map.get("grading") != null) {
		// questionGradingMapper.deleteGradingByQuestionSeq(map);
		// list = (List<Map<String, Object>>) map.get("grading");
		// for (Map<String, Object> param : list) {
		// logger.debug("[BBAEK] create grading param:" + param);
		// param.put("question_seq", map.get("question_seq"));
		// execute += questionGradingMapper.insertGrading(param);
		// }
		// }
		return execute;
	}

	@Override
	public int deleteQuestion(Map<String, Object> map) throws Exception {
		int execute = 0;
		execute = questionMapper.deleteQuestion(map);
		execute += questionConditionMapper.deleteCondition(map);
		execute += questionGradingMapper.deleteGradingByQuestionSeq(map);
		return execute;
	}

	@Override
	public List<Map<String, Object>> getSupportLanguage(Map<String, Object> map) throws Exception {
		String value = config.getEspaConfigVoValue("LANGUAGE");
		List<Map<String, Object>> rtn = new ArrayList<>();
		for (String str : value.split(",")) {
			Map<String, Object> lang = new HashMap<>();
			lang.put("text", str);
			lang.put("value", str);
			rtn.add(lang);
		}
		;
		return rtn;
	}

	@Override
	public int saveQuestion(Map<String, Object> map) throws Exception {
		map.put("mod_usr", userService.getLoginUserInfo().getUsername());
		int exeCnt = 0;
		logger.debug("param: " + map);
		exeCnt = updateQuestion(map);
		logger.debug("update: " + exeCnt);
		if (exeCnt <= 0) {
			map.put("reg_usr", userService.getLoginUserInfo().getUsername());
			logger.debug("param: " + map);
			exeCnt = createQuestion(map);
			logger.debug("insert: " + exeCnt);
		}
		return exeCnt;
	}
	
//	static private final int IDX_TITLE = 0;
//	static private final int IDX_CON_QUESTION = 1;
//	static private final int IDX_CON_IO = 2;
//	static private final int IDX_CON_EXAMPLE = 3;
//	static private final int IDX_CON_HINT = 4;
//	static private final int IDX_LANGUAGE = 5;
//	static private final int IDX_MAX_CODESIZE = 6;
//	static private final int IDX_TIMEOUT= 7;
//	static private final int IDX_BAN_KEYWORD= 8;
//	static private final int IDX_TEST_CODE = 9;

	@Override
	public Map<String, Object> importQuestion(MultipartHttpServletRequest req) throws Exception {
		MultipartFile file = req.getFile("file-import");
		if (file.isEmpty()) {
			throw new Exception("file is empty");
		}
		String filename = file.getOriginalFilename();
		String fileExt = filename.substring(filename.lastIndexOf(".") + 1, filename.length());
		int graingOrder = 1;

		Map<String, Object> param = new HashMap<>();
		List<Map<String, Object>> gradingParam = new ArrayList<>();
		if (fileExt.equals("xlsx")) {
			XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
			try {
				XSSFSheet curSheet;
				XSSFRow curRow;
//				HSSFCell curCell;

				// Sheet 탐색 for문
//				for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
					// 현재 sheet 반환
					curSheet = workbook.getSheetAt(0);
					// row 탐색 for문
					for (int rowIndex = 0; rowIndex < QuestionExcelRow.values().length; rowIndex++) {
						curRow = curSheet.getRow(rowIndex);
						Object value = ExcelUtil.getCellValue(curRow.getCell(1));
						QuestionExcelRow excelRow = QuestionExcelRow.values()[rowIndex];
						
						switch (excelRow) {
							case IDX_TITLE:
								if(value == null) {
									throw new Exception("title is empty");
								}
								param.put("title", value);
								break;
							case IDX_CON_QUESTION:
								if(value == null) {
									throw new Exception("description of question is empty");
								}
								param.put("con_question", value);
								break;
							case IDX_CON_IO:
								param.put("con_io", value);
								break;
							case IDX_CON_EXAMPLE:
								param.put("con_example", value);
								break;
							case IDX_CON_HINT:
								param.put("con_hint", value);
								break;
							case IDX_LANGUAGE:
								if(value == null) {
									throw new Exception("language is empty");
								}
								param.put("lang_type", value);
								break;
							case IDX_MAX_CODESIZE:
								if(value == null) {
									throw new Exception("max code size is empty");
								}
								param.put("max_codesize", value);
								break;
							case IDX_TIMEOUT:
								if(value == null) {
									throw new Exception("execution time(timeout) is empty");
								}
								param.put("timeout", value);
								break;
							case IDX_BAN_KEYWORD:
								if(value == null) {
									throw new Exception("ban keyword is empty");
								}
								param.put("ban_keyword", value);
								break;
							case IDX_TEST_CODE:
								param.put("test_code", value);
								break;
						}
					}
					
					for (int rowIndex = QuestionExcelRow.values().length; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
						Map<String, Object> grading = new HashMap<>();
						grading.put("grading_order", graingOrder++);
						curRow = curSheet.getRow(rowIndex);
						grading.put("grading_input", ExcelUtil.getCellValue(curRow.getCell(1)));
						curRow = curSheet.getRow(++rowIndex);
						grading.put("grading_output", ExcelUtil.getCellValue(curRow.getCell(1)));
						gradingParam.add(grading);
					}
//				}
				param.put("reg_usr", userService.getLoginUserInfo().getUsername());
				param.put("mod_usr", userService.getLoginUserInfo().getUsername());
				questionMapper.insertQuestion(param);
				for (Map<String, Object> _param : gradingParam) {
					_param.put("question_seq", param.get("question_seq"));
					questionGradingMapper.insertGrading(_param);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			} finally {
				if(workbook != null) workbook.close();
			}
		} else if (fileExt.equals("xls")) {
			HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
			try {
				HSSFSheet curSheet;
				HSSFRow curRow;
//				HSSFCell curCell;

				// Sheet 탐색 for문
//				for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
					// 현재 sheet 반환
					curSheet = workbook.getSheetAt(0);
					// row 탐색 for문
					for (int rowIndex = 0; rowIndex < QuestionExcelRow.values().length; rowIndex++) {
						curRow = curSheet.getRow(rowIndex);
						Object value = ExcelUtil.getCellValue(curRow.getCell(1));
						QuestionExcelRow excelRow = QuestionExcelRow.values()[rowIndex];
						
						switch (excelRow) {
							case IDX_TITLE:
								if(value == null) {
									throw new Exception("title is empty");
								}
								param.put("title", value);
								break;
							case IDX_CON_QUESTION:
								if(value == null) {
									throw new Exception("description of question is empty");
								}
								param.put("con_question", value);
								break;
							case IDX_CON_IO:
								param.put("con_io", value);
								break;
							case IDX_CON_EXAMPLE:
								param.put("con_example", value);
								break;
							case IDX_CON_HINT:
								param.put("con_hint", value);
								break;
							case IDX_LANGUAGE:
								if(value == null) {
									throw new Exception("language is empty");
								}
								param.put("lang_type", value);
								break;
							case IDX_MAX_CODESIZE:
								if(value == null) {
									throw new Exception("max code size is empty");
								}
								param.put("max_codesize", value);
								break;
							case IDX_TIMEOUT:
								if(value == null) {
									throw new Exception("execution time(timeout) is empty");
								}
								param.put("timeout", value);
								break;
							case IDX_BAN_KEYWORD:
								if(value == null) {
									throw new Exception("ban keyword is empty");
								}
								param.put("ban_keyword", value);
								break;
							case IDX_TEST_CODE:
								param.put("test_code", value);
								break;
						}
					}
					
					for (int rowIndex = QuestionExcelRow.values().length; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
						Map<String, Object> grading = new HashMap<>();
						grading.put("grading_order", graingOrder++);
						curRow = curSheet.getRow(rowIndex);
						grading.put("grading_input", ExcelUtil.getCellValue(curRow.getCell(1)));
						curRow = curSheet.getRow(++rowIndex);
						grading.put("grading_output", ExcelUtil.getCellValue(curRow.getCell(1)));
						gradingParam.add(grading);
					}
//				}
				param.put("reg_usr", userService.getLoginUserInfo().getUsername());
				param.put("mod_usr", userService.getLoginUserInfo().getUsername());
				questionMapper.insertQuestion(param);
				for (Map<String, Object> _param : gradingParam) {
					_param.put("question_seq", param.get("question_seq"));
					questionGradingMapper.insertGrading(_param);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			} finally {
				if(workbook != null) workbook.close();
			}
		} else {
			throw new Exception("not support file type: " + fileExt);
		}

		return param;
	}

	@Override
	public File exportQuestion(long seq) throws Exception {
		FileOutputStream fos = null;
		HSSFWorkbook workbook = null;
		File file = null;
		try {
			Map<String, Object> question = new HashMap<>();
			question.put("question_seq", seq);
			
			if(logger.isDebugEnabled()) {
				logger.debug("param: " + question);
			}
			question = questionMapper.selectQuestion(question).get(0);
			
			if(logger.isDebugEnabled()) {
				logger.debug("get question: " + question);
			}
			file = new File("question.xls");
			fos = new FileOutputStream(file);
			workbook = new HSSFWorkbook();
			HSSFSheet worksheet = workbook.createSheet(question.get("title").toString());
			
			for (int rowIndex = 0; rowIndex < QuestionExcelRow.values().length; rowIndex++) {
				HSSFRow row = worksheet.createRow(rowIndex);
				HSSFCell cell1 = row.createCell(0);
				cell1.setCellValue(QuestionExcelRow.values()[rowIndex].getMsg());
				HSSFCell cell2 = row.createCell(1);
				
				switch (QuestionExcelRow.values()[rowIndex]) {
					case IDX_TITLE:
						cell2.setCellValue(question.get("title").toString());
						break;
					case IDX_CON_QUESTION:
						cell2.setCellValue(question.get("con_question").toString());
						break;
					case IDX_CON_IO:
						cell2.setCellValue(question.get("con_io").toString());
						break;
					case IDX_CON_EXAMPLE:
						cell2.setCellValue(question.get("con_example").toString());
						break;
					case IDX_CON_HINT:
						cell2.setCellValue(question.get("con_hint").toString());
						break;
					case IDX_LANGUAGE:
						cell2.setCellValue(question.get("lang_type").toString());
						break;
					case IDX_MAX_CODESIZE:
						cell2.setCellValue(question.get("max_codesize").toString());
						break;
					case IDX_TIMEOUT:
						cell2.setCellValue(question.get("timeout").toString());
						break;
					case IDX_BAN_KEYWORD:
						cell2.setCellValue(question.get("ban_keyword").toString());
						break;
					case IDX_TEST_CODE:
						cell2.setCellValue(question.get("test_code").toString());
						break;
				}
			}
			List<Map<String, Object>> gradingList = questionGradingMapper.selectGradingList(question);
			for (int i = 0; i < gradingList.size(); i++) {
				worksheet.createRow(QuestionExcelRow.values().length + (i * 2)).createCell(0).setCellValue("채점데이터 입력 " + (i + 1));
				worksheet.getRow(QuestionExcelRow.values().length + (i * 2)).createCell(1).setCellValue(gradingList.get(i).get("grading_input").toString());
				worksheet.createRow(QuestionExcelRow.values().length  + (i * 2) + 1).createCell(0).setCellValue("채점데이터 출력 " + (i + 1));
				worksheet.getRow(QuestionExcelRow.values().length  + (i * 2) + 1).createCell(1).setCellValue(gradingList.get(i).get("grading_output").toString());
			}
			workbook.write(fos);
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(workbook != null) workbook.close();
			if(fos != null) fos.close();
		}
		return file;
	}
}
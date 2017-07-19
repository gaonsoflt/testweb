package egovframework.common.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCell;

public class ExcelUtil {
	public static Object getCellValue(HSSFCell cell) {
		Object value = null;
		if (cell != null) {
			switch (cell.getCellType()) {
				case HSSFCell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case HSSFCell.CELL_TYPE_NUMERIC:
					value = cell.getNumericCellValue();
					break;
				case HSSFCell.CELL_TYPE_STRING:
					value = cell.getStringCellValue();
					break;
				case HSSFCell.CELL_TYPE_BLANK:
					value = cell.getBooleanCellValue();
					break;
				case HSSFCell.CELL_TYPE_ERROR:
					value = cell.getErrorCellValue();
					break;
				default:
					value = new String();
					break;
			} 
		}
		return value;
	}
	
	public static Object getCellValue(XSSFCell cell) {
		Object value = null;
		if (cell != null) {
			switch (cell.getCellType()) {
			case XSSFCell.CELL_TYPE_FORMULA:
				value = cell.getCellFormula();
				break;
			case XSSFCell.CELL_TYPE_NUMERIC:
				value = cell.getNumericCellValue();
				break;
			case XSSFCell.CELL_TYPE_STRING:
				value = cell.getStringCellValue();
				break;
			case XSSFCell.CELL_TYPE_BLANK:
				value = cell.getBooleanCellValue();
				break;
			case XSSFCell.CELL_TYPE_ERROR:
				value = cell.getErrorCellValue();
				break;
			default:
				value = new String();
				break;
			} 
		}
		return value;
	}
}

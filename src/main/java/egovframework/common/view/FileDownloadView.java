package egovframework.common.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {
	Logger logger = LoggerFactory.getLogger(FileDownloadView.class.getName());

	public FileDownloadView() {
		super.setContentType("application/octet-stream");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// Controller에서 넘어온 파일 정보를 추출한다
		// 여기서 Map인 model객체는 Controller에서 ModelAndView객체에 addObject하여 넘어온 정보다.
		File file = (File) model.get("file");
		if(logger.isDebugEnabled()) {
			logger.debug("download file: " + file.getAbsolutePath());
		}
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + file.getName() + "\";");

		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (java.io.IOException ioe) {
			ioe.printStackTrace();
		} finally {
			if (fis != null)
				fis.close();
		}
		out.flush();
	}

}

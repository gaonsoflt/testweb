<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.FileInputStream"%>  
<%@ page import="egovframework.com.cmm.service.Globals" %> 
<!-- %@ page import="egovframework..service.Comm" %-->
<%
     String rName = request.getParameter("RN");
	 String sName = request.getParameter("SN");
     String sFilePath = Globals.Filepath_BaseDir + rName;
     byte b[] = new byte [4096];
     File oFile = new File(sFilePath);
     
     out.clearBuffer();
     response.setContentType("application/octet-stream"); 
     response.setHeader("Content-Disposition", "attachment;filename=" +      
     	      URLEncoder.encode(sName, "utf-8"));
     
     FileInputStream in = new FileInputStream(sFilePath);
     ServletOutputStream out2 = response.getOutputStream();
     int numRead;
     
     while((numRead = in.read(b, 0, b.length)) != -1) {
          out2.write(b, 0, numRead);
     }
     
     out2.flush();
     out2.close();
     in.close();
%> 

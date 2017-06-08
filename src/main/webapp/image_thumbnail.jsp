<%@ page pageEncoding="utf-8" trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.File" %> 
<%@ page import="java.awt.Image" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="egovframework.com.cmm.service.Globals" %> 

<%
	//String path = "/upload/" + request.getParameter("path");
	//String realPath = request.getSession().getServletContext().getRealPath(path);
	//String realPath = "Q:\\Dev\\URTOWN\\URTOWN\\src\\main\\webapp\\upload\\" + path;
	String path = request.getParameter("path");
	String realPath = Globals.Filepath_BaseDir + path; 
	
	BufferedImage img = new BufferedImage(80, 80, BufferedImage.TYPE_INT_RGB);
	
	img.createGraphics().drawImage(ImageIO.read(new File(realPath)).getScaledInstance(80, 80, Image.SCALE_SMOOTH),0,0,null);
	ImageIO.write(img, "jpg", response.getOutputStream());
%>
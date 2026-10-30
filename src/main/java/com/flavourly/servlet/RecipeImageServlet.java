package com.flavourly.servlet;
import com.flavourly.util.UploadConfig;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/recipe-image/*")
public class RecipeImageServlet extends HttpServlet{
private static final long serialVersionUID=1L;
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
String pathInfo=request.getPathInfo();
if(pathInfo==null||pathInfo.equals("/")||pathInfo.trim().isEmpty()){
response.sendError(HttpServletResponse.SC_NOT_FOUND);
return;
}
String fileName=new File(pathInfo).getName();
File imageFile=new File(UploadConfig.RECIPE_IMAGE_DIRECTORY,fileName);
if(!imageFile.exists()||!imageFile.isFile()){
response.sendError(HttpServletResponse.SC_NOT_FOUND);
return;
}
String contentType=Files.probeContentType(imageFile.toPath());
if(contentType==null){
contentType="application/octet-stream";
}
response.setContentType(contentType);
response.setContentLengthLong(imageFile.length());
response.setHeader("Cache-Control","public,max-age=86400");
try(FileInputStream inputStream=new FileInputStream(imageFile);
OutputStream outputStream=response.getOutputStream()){
byte[] buffer=new byte[8192];
int bytesRead;
while((bytesRead=inputStream.read(buffer))!=-1){
outputStream.write(buffer,0,bytesRead);
}
}
}
}
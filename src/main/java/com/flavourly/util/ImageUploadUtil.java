package com.flavourly.util;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;
import javax.servlet.http.Part;
public class ImageUploadUtil{
private static final long MAX_FILE_SIZE=5*1024*1024;
private static final String[] ALLOWED_TYPES={"image/jpeg","image/png","image/webp"};
public static String saveRecipeImage(Part imagePart,String uploadPath)throws IOException{
if(imagePart==null||imagePart.getSize()==0){
return null;
}
if(imagePart.getSize()>MAX_FILE_SIZE){
throw new IOException("Image size must not exceed 5 MB.");
}
String contentType=imagePart.getContentType();
boolean allowed=false;
for(String type:ALLOWED_TYPES){
if(type.equalsIgnoreCase(contentType)){
allowed=true;
break;
}
}
if(!allowed){
throw new IOException("Only JPG, JPEG, PNG and WEBP images are allowed.");
}
File uploadDirectory=new File(uploadPath);
if(!uploadDirectory.exists()&&!uploadDirectory.mkdirs()){
throw new IOException("Could not create recipe image upload directory.");
}
String extension=getExtension(imagePart.getSubmittedFileName());
String uniqueFileName=UUID.randomUUID().toString()+extension;
File destinationFile=new File(uploadDirectory,uniqueFileName);
try(InputStream inputStream=imagePart.getInputStream();FileOutputStream outputStream=new FileOutputStream(destinationFile)){
byte[] buffer=new byte[8192];
int bytesRead;
while((bytesRead=inputStream.read(buffer))!=-1){
outputStream.write(buffer,0,bytesRead);
}
}
return uniqueFileName;
}
public static void deleteRecipeImage(String fileName,String uploadPath){
if(fileName==null||fileName.trim().isEmpty()||"default-recipe.jpg".equals(fileName)){
return;
}
File imageFile=new File(uploadPath,fileName);
if(imageFile.exists()){
imageFile.delete();
}
}
private static String getExtension(String fileName)throws IOException{
if(fileName==null||fileName.trim().isEmpty()){
throw new IOException("Invalid image filename.");
}
int dotIndex=fileName.lastIndexOf('.');
if(dotIndex==-1){
throw new IOException("Image file must have an extension.");
}
String extension=fileName.substring(dotIndex).toLowerCase();
if(!extension.equals(".jpg")&&!extension.equals(".jpeg")&&!extension.equals(".png")&&!extension.equals(".webp")){
throw new IOException("Invalid image extension.");
}
return extension;
}
}
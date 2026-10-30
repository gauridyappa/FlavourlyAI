package com.flavourly.servlet;
import com.flavourly.dao.UserDAO;
import com.flavourly.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private UserDAO userDAO;
@Override
public void init(){
userDAO=new UserDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
User user=userDAO.getUserById(loggedUser.getUserId());
if(user==null){
session.invalidate();
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
request.setAttribute("user",user);
request.getRequestDispatcher("/pages/editProfile.jsp").forward(request,response);
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
request.setCharacterEncoding("UTF-8");
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
try{
String fullName=request.getParameter("fullName");
String phone=request.getParameter("phone");
String bio=request.getParameter("bio");
if(fullName==null||fullName.trim().isEmpty()){
response.sendRedirect(request.getContextPath()+"/edit-profile?error=invalidName");
return;
}
fullName=fullName.trim();
phone=phone!=null?phone.trim():"";
bio=bio!=null?bio.trim():"";
User user=new User();
user.setUserId(loggedUser.getUserId());
user.setFullName(fullName);
user.setPhone(phone);
user.setBio(bio);
boolean updated=userDAO.updateProfile(user);
if(updated){
User updatedUser=userDAO.getUserById(loggedUser.getUserId());
session.setAttribute("loggedUser",updatedUser);
response.sendRedirect(request.getContextPath()+"/profile?success=updated");
}else{
response.sendRedirect(request.getContextPath()+"/edit-profile?error=failed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/edit-profile?error=invalid");
}
}
}
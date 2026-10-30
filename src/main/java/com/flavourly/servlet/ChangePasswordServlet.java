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
@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet{
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
request.getRequestDispatcher("/pages/changePassword.jsp").forward(request,response);
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
String currentPassword=request.getParameter("currentPassword");
String newPassword=request.getParameter("newPassword");
String confirmPassword=request.getParameter("confirmPassword");
if(currentPassword==null||currentPassword.trim().isEmpty()||
newPassword==null||newPassword.trim().isEmpty()||
confirmPassword==null||confirmPassword.trim().isEmpty()){
response.sendRedirect(request.getContextPath()+"/changePassword?error=emptyFields");
return;
}
if(!userDAO.verifyCurrentPassword(loggedUser.getUserId(),currentPassword)){
response.sendRedirect(request.getContextPath()+"/changePassword?error=incorrectPassword");
return;
}
if(newPassword.length()<8){
response.sendRedirect(request.getContextPath()+"/changePassword?error=shortPassword");
return;
}
if(!newPassword.equals(confirmPassword)){
response.sendRedirect(request.getContextPath()+"/changePassword?error=passwordMismatch");
return;
}
if(currentPassword.equals(newPassword)){
response.sendRedirect(request.getContextPath()+"/changePassword?error=samePassword");
return;
}
boolean updated=userDAO.updatePassword(loggedUser.getUserId(),newPassword);
if(updated){
response.sendRedirect(request.getContextPath()+"/changePassword?success=updated");
}else{
response.sendRedirect(request.getContextPath()+"/changePassword?error=failed");
}
}
}
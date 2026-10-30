package com.flavourly.servlet;
import com.flavourly.dao.UserSettingsDAO;
import com.flavourly.model.User;
import com.flavourly.model.UserSettings;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/settings")
public class SettingsServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private UserSettingsDAO userSettingsDAO;
@Override
public void init(){
userSettingsDAO=new UserSettingsDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
UserSettings settings=userSettingsDAO.getSettingsByUser(loggedUser.getUserId());
if(settings==null){
response.sendRedirect(request.getContextPath()+"/dashboard?error=settingsLoadFailed");
return;
}
request.setAttribute("settings",settings);
request.getRequestDispatcher("/pages/settings.jsp").forward(request,response);
}
}
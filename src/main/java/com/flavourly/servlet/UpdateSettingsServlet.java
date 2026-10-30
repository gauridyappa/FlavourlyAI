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
@WebServlet("/updateSettings")
public class UpdateSettingsServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private UserSettingsDAO userSettingsDAO;
@Override
public void init(){
userSettingsDAO=new UserSettingsDAO();
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
request.setCharacterEncoding("UTF-8");
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
try{
User loggedUser=(User)session.getAttribute("loggedUser");
boolean emailNotifications=request.getParameter("emailNotifications")!=null;
boolean recipeUpdates=request.getParameter("recipeUpdates")!=null;
boolean reviewNotifications=request.getParameter("reviewNotifications")!=null;
String profileVisibility=request.getParameter("profileVisibility");
String defaultRecipeView=request.getParameter("defaultRecipeView");
if(!"PUBLIC".equals(profileVisibility)&&!"PRIVATE".equals(profileVisibility)){
response.sendRedirect(request.getContextPath()+"/settings?error=invalidVisibility");
return;
}
if(!"GRID".equals(defaultRecipeView)&&!"LIST".equals(defaultRecipeView)){
response.sendRedirect(request.getContextPath()+"/settings?error=invalidRecipeView");
return;
}
UserSettings settings=new UserSettings();
settings.setUserId(loggedUser.getUserId());
settings.setEmailNotifications(emailNotifications);
settings.setRecipeUpdates(recipeUpdates);
settings.setReviewNotifications(reviewNotifications);
settings.setProfileVisibility(profileVisibility);
settings.setDefaultRecipeView(defaultRecipeView);
boolean updated=userSettingsDAO.updateSettings(settings);
if(updated){
response.sendRedirect(request.getContextPath()+"/settings?success=settingsUpdated");
}else{
response.sendRedirect(request.getContextPath()+"/settings?error=updateFailed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/settings?error=invalidData");
}
}
}
package com.flavourly.servlet;
import com.flavourly.dao.FavoriteDAO;
import com.flavourly.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private FavoriteDAO favoriteDAO;
@Override
public void init(){
favoriteDAO=new FavoriteDAO();
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
try{
int recipeId=Integer.parseInt(request.getParameter("recipeId"));
String action=request.getParameter("action");
String redirect=request.getParameter("redirect");
if("add".equals(action)){
favoriteDAO.addFavorite(loggedUser.getUserId(),recipeId);
}else if("remove".equals(action)){
favoriteDAO.removeFavorite(loggedUser.getUserId(),recipeId);
}
if("details".equals(redirect)){
response.sendRedirect(request.getContextPath()+"/recipe-details?id="+recipeId);
}else if("favorites".equals(redirect)){
response.sendRedirect(request.getContextPath()+"/favorites");
}else{
response.sendRedirect(request.getContextPath()+"/my-recipes");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/my-recipes?error=favorite");
}
}
}
package com.flavourly.servlet;
import com.flavourly.dao.FavoriteDAO;
import com.flavourly.dao.UserDAO;
import com.flavourly.model.User;
import com.flavourly.service.RecipeService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private UserDAO userDAO;
private RecipeService recipeService;
private FavoriteDAO favoriteDAO;
@Override
public void init(){
userDAO=new UserDAO();
recipeService=new RecipeService();
favoriteDAO=new FavoriteDAO();
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
int totalRecipes=recipeService.countRecipesByUser(user.getUserId());
int favoriteCount=favoriteDAO.getFavoriteCountByUserId(user.getUserId());
session.setAttribute("loggedUser",user);
request.setAttribute("user",user);
request.setAttribute("totalRecipes",totalRecipes);
request.setAttribute("favoriteCount",favoriteCount);
request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
}
}
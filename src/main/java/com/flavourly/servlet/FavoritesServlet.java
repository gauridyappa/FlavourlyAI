package com.flavourly.servlet;
import com.flavourly.dao.FavoriteDAO;
import com.flavourly.model.Recipe;
import com.flavourly.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/favorites")
public class FavoritesServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private FavoriteDAO favoriteDAO;
@Override
public void init(){
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
List<Recipe> favoriteRecipes=favoriteDAO.getFavoritesByUserId(loggedUser.getUserId());
request.setAttribute("favoriteRecipes",favoriteRecipes);
request.setAttribute("favoriteCount",favoriteRecipes.size());
request.getRequestDispatcher("/pages/favorites.jsp").forward(request,response);
}
}
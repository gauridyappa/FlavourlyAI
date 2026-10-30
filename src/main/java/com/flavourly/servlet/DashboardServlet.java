package com.flavourly.servlet;
import com.flavourly.dao.CategoryDAO;
import com.flavourly.dao.FavoriteDAO;
import com.flavourly.model.Recipe;
import com.flavourly.model.User;
import com.flavourly.service.RecipeService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
private FavoriteDAO favoriteDAO;
private CategoryDAO categoryDAO;
@Override
public void init(){
recipeService=new RecipeService();
favoriteDAO=new FavoriteDAO();
categoryDAO=new CategoryDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
int userId=loggedUser.getUserId();
int totalRecipes=recipeService.countRecipesByUser(userId);
int favoriteCount=favoriteDAO.getFavoriteCountByUserId(userId);
int categoryCount=categoryDAO.getCategoryCount();
List<Recipe> allRecipes=recipeService.getRecipesByUser(userId);
List<Recipe> recentRecipes=new ArrayList<>();
int recentLimit=Math.min(3,allRecipes.size());
for(int i=0;i<recentLimit;i++){
recentRecipes.add(allRecipes.get(i));
}
request.setAttribute("totalRecipes",totalRecipes);
request.setAttribute("favoriteCount",favoriteCount);
request.setAttribute("categoryCount",categoryCount);
request.setAttribute("recentRecipes",recentRecipes);
request.getRequestDispatcher("/pages/dashboard.jsp").forward(request,response);
}
}
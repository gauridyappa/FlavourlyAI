package com.flavourly.servlet;
import com.flavourly.dao.UserSettingsDAO;
import com.flavourly.model.Recipe;
import com.flavourly.model.User;
import com.flavourly.model.UserSettings;
import com.flavourly.service.RecipeService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/my-recipes")
public class MyRecipesServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
private UserSettingsDAO userSettingsDAO;
@Override
public void init(){
recipeService=new RecipeService();
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
List<Recipe> recipes=recipeService.getRecipesByUser(loggedUser.getUserId());
UserSettings settings=userSettingsDAO.getSettingsByUser(loggedUser.getUserId());
String defaultRecipeView=settings!=null?settings.getDefaultRecipeView():"GRID";
request.setAttribute("recipes",recipes);
request.setAttribute("recipeCount",recipes.size());
request.setAttribute("defaultRecipeView",defaultRecipeView);
request.getRequestDispatcher("/pages/recipes.jsp").forward(request,response);
}
}
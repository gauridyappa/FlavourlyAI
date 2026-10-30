package com.flavourly.servlet;
import com.flavourly.model.Ingredient;
import com.flavourly.model.Recipe;
import com.flavourly.model.RecipeStep;
import com.flavourly.service.RecipeService;
import com.flavourly.dao.FavoriteDAO;
import com.flavourly.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/recipe-details")
public class RecipeDetailsServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
private FavoriteDAO favoriteDAO;
@Override
public void init(){
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
try{
String recipeIdValue=request.getParameter("id");
if(recipeIdValue==null||recipeIdValue.trim().isEmpty()){
response.sendRedirect(request.getContextPath()+"/my-recipes");
return;
}
int recipeId=Integer.parseInt(recipeIdValue);
Recipe recipe=recipeService.getRecipeById(recipeId);
if(recipe==null){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=notFound");
return;
}
List<Ingredient> ingredients=recipeService.getIngredientsByRecipeId(recipeId);
List<RecipeStep> recipeSteps=recipeService.getStepsByRecipeId(recipeId);
boolean isFavorite=favoriteDAO.isFavorite(loggedUser.getUserId(),recipeId);
request.setAttribute("recipe",recipe);
request.setAttribute("ingredients",ingredients);
request.setAttribute("recipeSteps",recipeSteps);
request.setAttribute("isFavorite",isFavorite);
request.getRequestDispatcher("/pages/recipeDetails.jsp").forward(request,response);
}catch(NumberFormatException e){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=invalidId");
}
}
}
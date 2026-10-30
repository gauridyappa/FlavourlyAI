package com.flavourly.servlet;
import com.flavourly.dao.RecipeDAO;
import com.flavourly.model.Recipe;
import com.flavourly.model.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/nutrition")
public class NutritionServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeDAO recipeDAO;
@Override
public void init(){
recipeDAO=new RecipeDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
List<Recipe> recipes=recipeDAO.getRecipesByUser(loggedUser.getUserId());
int totalRecipes=recipes.size();
List<Recipe> nutritionRecipes=new ArrayList<>();
for(Recipe recipe:recipes){
if(recipe.getCalories()>0||recipe.getProtein()>0||recipe.getCarbohydrates()>0||recipe.getFat()>0||recipe.getFiber()>0){
nutritionRecipes.add(recipe);
}
}
int nutritionRecipeCount=nutritionRecipes.size();
int totalCalories=0;
double totalProtein=0;
double totalCarbohydrates=0;
double totalFat=0;
double totalFiber=0;
for(Recipe recipe:nutritionRecipes){
totalCalories+=recipe.getCalories();
totalProtein+=recipe.getProtein();
totalCarbohydrates+=recipe.getCarbohydrates();
totalFat+=recipe.getFat();
totalFiber+=recipe.getFiber();
}
double averageCalories=nutritionRecipeCount>0?(double)totalCalories/nutritionRecipeCount:0;
double averageProtein=nutritionRecipeCount>0?totalProtein/nutritionRecipeCount:0;
double averageCarbohydrates=nutritionRecipeCount>0?totalCarbohydrates/nutritionRecipeCount:0;
double averageFat=nutritionRecipeCount>0?totalFat/nutritionRecipeCount:0;
double averageFiber=nutritionRecipeCount>0?totalFiber/nutritionRecipeCount:0;
List<Recipe> highestProteinRecipes=new ArrayList<>(nutritionRecipes);
highestProteinRecipes.sort(Comparator.comparingDouble(Recipe::getProtein).reversed());
if(highestProteinRecipes.size()>5){
highestProteinRecipes=new ArrayList<>(highestProteinRecipes.subList(0,5));
}
List<Recipe> lowestCalorieRecipes=new ArrayList<>(nutritionRecipes);
lowestCalorieRecipes.sort(Comparator.comparingInt(Recipe::getCalories));
if(lowestCalorieRecipes.size()>5){
lowestCalorieRecipes=new ArrayList<>(lowestCalorieRecipes.subList(0,5));
}
request.setAttribute("recipes",recipes);
request.setAttribute("totalRecipes",totalRecipes);
request.setAttribute("averageCalories",averageCalories);
request.setAttribute("averageProtein",averageProtein);
request.setAttribute("averageCarbohydrates",averageCarbohydrates);
request.setAttribute("averageFat",averageFat);
request.setAttribute("averageFiber",averageFiber);
request.setAttribute("highestProteinRecipes",highestProteinRecipes);
request.setAttribute("lowestCalorieRecipes",lowestCalorieRecipes);
request.getRequestDispatcher("/pages/nutrition.jsp").forward(request,response);
}
}
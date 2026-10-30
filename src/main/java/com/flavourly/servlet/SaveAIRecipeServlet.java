package com.flavourly.servlet;
import com.flavourly.dao.CategoryDAO;
import com.flavourly.model.AIRecipe;
import com.flavourly.model.Ingredient;
import com.flavourly.model.Recipe;
import com.flavourly.model.RecipeStep;
import com.flavourly.model.User;
import com.flavourly.model.AIIngredient;
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
@WebServlet("/saveAIRecipe")
public class SaveAIRecipeServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
private CategoryDAO categoryDAO;
@Override
public void init(){
recipeService=new RecipeService();
categoryDAO=new CategoryDAO();
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
AIRecipe aiRecipe=(AIRecipe)session.getAttribute("generatedAIRecipe");
if(aiRecipe==null){
response.sendRedirect(request.getContextPath()+"/aiGenerator?error=noRecipe");
return;
}
try{
Recipe recipe=new Recipe();
recipe.setRecipeName(aiRecipe.getRecipeName());
int categoryId=categoryDAO.getCategoryIdByName(aiRecipe.getCategory());
if(categoryId<=0){
categoryId=1;
}
recipe.setCategoryId(categoryId);
recipe.setCuisine(aiRecipe.getCuisine());
recipe.setDifficulty(aiRecipe.getDifficulty());
recipe.setCookingTime(aiRecipe.getCookingTime());
recipe.setCalories(aiRecipe.getCalories());
recipe.setCookingTime(aiRecipe.getCookingTime());
recipe.setCalories(aiRecipe.getCalories());
recipe.setProtein(aiRecipe.getProtein());
recipe.setCarbohydrates(aiRecipe.getCarbohydrates());
recipe.setFat(aiRecipe.getFat());
recipe.setFiber(aiRecipe.getFiber());
recipe.setDescription(aiRecipe.getDescription());
recipe.setRecipeImage("default-recipe.jpg");
recipe.setCreatedBy(loggedUser.getUserId());
List<Ingredient> ingredients=new ArrayList<>();
if(aiRecipe.getIngredients()!=null){
for(AIIngredient aiIngredient:aiRecipe.getIngredients()){
if(aiIngredient!=null&&aiIngredient.getIngredientName()!=null&&!aiIngredient.getIngredientName().trim().isEmpty()){
String ingredientName=aiIngredient.getIngredientName().trim();
String quantity=aiIngredient.getQuantity()!=null?aiIngredient.getQuantity().trim():"";
String unit=aiIngredient.getUnit()!=null?aiIngredient.getUnit().trim():"";
ingredients.add(new Ingredient(ingredientName,quantity,unit));
}
}
}
List<RecipeStep> recipeSteps=new ArrayList<>();
if(aiRecipe.getInstructions()!=null){
int stepNumber=1;
for(String instruction:aiRecipe.getInstructions()){
if(instruction!=null&&!instruction.trim().isEmpty()){
recipeSteps.add(new RecipeStep(stepNumber++,instruction.trim()));
}
}
}
if(ingredients.isEmpty()||recipeSteps.isEmpty()){
response.sendRedirect(request.getContextPath()+"/aiGenerator?error=invalidRecipe");
return;
}
int recipeId=recipeService.addRecipeAndReturnId(recipe,ingredients,recipeSteps);
if(recipeId>0){
session.removeAttribute("generatedAIRecipe");
response.sendRedirect(request.getContextPath()+"/recipe-details?id="+recipeId+"&success=aiSaved");
}else{
response.sendRedirect(request.getContextPath()+"/aiGenerator?error=saveFailed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/aiGenerator?error=saveFailed");
}
}
}
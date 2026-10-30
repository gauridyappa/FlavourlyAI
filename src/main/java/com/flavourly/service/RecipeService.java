package com.flavourly.service;
import com.flavourly.dao.IngredientDAO;
import com.flavourly.dao.RecipeDAO;
import com.flavourly.dao.RecipeStepDAO;
import com.flavourly.model.Ingredient;
import com.flavourly.model.Recipe;
import com.flavourly.model.RecipeStep;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.util.List;
public class RecipeService {
private final RecipeDAO recipeDAO;
private final IngredientDAO ingredientDAO;
private final RecipeStepDAO recipeStepDAO;
public RecipeService(){
this.recipeDAO=new RecipeDAO();
this.ingredientDAO=new IngredientDAO();
this.recipeStepDAO=new RecipeStepDAO();
}
public boolean addRecipe(Recipe recipe,List<Ingredient> ingredients,List<RecipeStep> recipeSteps){
Connection connection=null;
try{
connection=DBConnection.getConnection();
connection.setAutoCommit(false);
int recipeId=recipeDAO.addRecipe(recipe,connection);
if(recipeId<=0){
connection.rollback();
return false;
}
ingredientDAO.addIngredients(ingredients,recipeId,connection);
recipeStepDAO.addRecipeSteps(recipeSteps,recipeId,connection);
connection.commit();
return true;
}catch(Exception e){
if(connection!=null){
try{
connection.rollback();
}catch(Exception rollbackException){
rollbackException.printStackTrace();
}
}
e.printStackTrace();
return false;
}finally{
if(connection!=null){
try{
connection.setAutoCommit(true);
connection.close();
}catch(Exception e){
e.printStackTrace();
}
}
}
}
public List<Recipe> getRecipesByUser(int userId){
return recipeDAO.getRecipesByUser(userId);
}
public List<Recipe> getAllRecipes(){
return recipeDAO.getAllRecipes();
}
public Recipe getRecipeById(int recipeId){
return recipeDAO.getRecipeById(recipeId);
}
public List<Ingredient> getIngredientsByRecipeId(int recipeId){
return ingredientDAO.getIngredientsByRecipeId(recipeId);
}
public List<RecipeStep> getStepsByRecipeId(int recipeId){
return recipeStepDAO.getStepsByRecipeId(recipeId);
}
public boolean updateRecipe(Recipe recipe,List<Ingredient> ingredients,List<RecipeStep> recipeSteps){
Connection connection=null;
try{
connection=DBConnection.getConnection();
connection.setAutoCommit(false);
boolean recipeUpdated=recipeDAO.updateRecipe(recipe,connection);
if(!recipeUpdated){
connection.rollback();
return false;
}
ingredientDAO.updateIngredients(ingredients,recipe.getRecipeId(),connection);
recipeStepDAO.updateRecipeSteps(recipeSteps,recipe.getRecipeId(),connection);
connection.commit();
return true;
}catch(Exception e){
if(connection!=null){
try{
connection.rollback();
}catch(Exception rollbackException){
rollbackException.printStackTrace();
}
}
e.printStackTrace();
return false;
}finally{
if(connection!=null){
try{
connection.setAutoCommit(true);
connection.close();
}catch(Exception e){
e.printStackTrace();
}
}
}
}
public boolean deleteRecipe(int recipeId,int userId){
return recipeDAO.deleteRecipe(recipeId,userId);
}
public int countRecipesByUser(int userId){
return recipeDAO.countRecipesByUser(userId);
}
public int addRecipeAndReturnId(Recipe recipe,List<Ingredient> ingredients,List<RecipeStep> recipeSteps){
Connection connection=null;
try{
connection=DBConnection.getConnection();
connection.setAutoCommit(false);
int recipeId=recipeDAO.addRecipe(recipe,connection);
if(recipeId<=0){
connection.rollback();
return 0;
}
ingredientDAO.addIngredients(ingredients,recipeId,connection);
recipeStepDAO.addRecipeSteps(recipeSteps,recipeId,connection);
connection.commit();
return recipeId;
}catch(Exception e){
if(connection!=null){
try{
connection.rollback();
}catch(Exception rollbackException){
rollbackException.printStackTrace();
}
}
e.printStackTrace();
return 0;
}finally{
if(connection!=null){
try{
connection.setAutoCommit(true);
connection.close();
}catch(Exception e){
e.printStackTrace();
}
}
}
}
}
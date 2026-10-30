package com.flavourly.dao;
import com.flavourly.model.Recipe;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
public class RecipeDAO {
public int addRecipe(Recipe recipe,Connection connection)throws Exception{
String sql="INSERT INTO recipes(recipe_name,category_id,cuisine,difficulty,cooking_time,calories,protein,carbohydrates,fat,fiber,description,recipe_image,created_by) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
try(PreparedStatement statement=connection.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
	statement.setString(1,recipe.getRecipeName());
	statement.setInt(2,recipe.getCategoryId());
	statement.setString(3,recipe.getCuisine());
	statement.setString(4,recipe.getDifficulty());
	statement.setInt(5,recipe.getCookingTime());
	statement.setInt(6,recipe.getCalories());
	statement.setDouble(7,recipe.getProtein());
	statement.setDouble(8,recipe.getCarbohydrates());
	statement.setDouble(9,recipe.getFat());
	statement.setDouble(10,recipe.getFiber());
	statement.setString(11,recipe.getDescription());
	statement.setString(12,recipe.getRecipeImage());
	statement.setInt(13,recipe.getCreatedBy());
int rows=statement.executeUpdate();
if(rows>0){
try(ResultSet resultSet=statement.getGeneratedKeys()){
if(resultSet.next()){
return resultSet.getInt(1);
}
}
}
}
return 0;
}
public List<Recipe> getRecipesByUser(int userId){
List<Recipe> recipes=new ArrayList<>();
String sql="SELECT r.*,c.category_name,u.full_name FROM recipes r JOIN categories c ON r.category_id=c.category_id JOIN users u ON r.created_by=u.user_id WHERE r.created_by=? ORDER BY r.created_at DESC";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
recipes.add(mapRecipe(resultSet));
}
}
}catch(Exception e){
e.printStackTrace();
}
return recipes;
}
public List<Recipe> getAllRecipes(){
List<Recipe> recipes=new ArrayList<>();
String sql="SELECT r.*,c.category_name,u.full_name FROM recipes r JOIN categories c ON r.category_id=c.category_id JOIN users u ON r.created_by=u.user_id ORDER BY r.created_at DESC";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql);
ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
recipes.add(mapRecipe(resultSet));
}
}catch(Exception e){
e.printStackTrace();
}
return recipes;
}
public Recipe getRecipeById(int recipeId){
Recipe recipe=null;
String sql="SELECT r.*,c.category_name,u.full_name FROM recipes r JOIN categories c ON r.category_id=c.category_id JOIN users u ON r.created_by=u.user_id WHERE r.recipe_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
recipe=mapRecipe(resultSet);
}
}
}catch(Exception e){
e.printStackTrace();
}
return recipe;
}
public boolean updateRecipe(Recipe recipe,Connection connection)throws Exception{
	String sql="UPDATE recipes SET recipe_name=?,category_id=?,cuisine=?,difficulty=?,cooking_time=?,calories=?,protein=?,carbohydrates=?,fat=?,fiber=?,description=?,recipe_image=? WHERE recipe_id=? AND created_by=?";
	try(PreparedStatement statement=connection.prepareStatement(sql)){
		statement.setString(1,recipe.getRecipeName());
		statement.setInt(2,recipe.getCategoryId());
		statement.setString(3,recipe.getCuisine());
		statement.setString(4,recipe.getDifficulty());
		statement.setInt(5,recipe.getCookingTime());
		statement.setInt(6,recipe.getCalories());
		statement.setDouble(7,recipe.getProtein());
		statement.setDouble(8,recipe.getCarbohydrates());
		statement.setDouble(9,recipe.getFat());
		statement.setDouble(10,recipe.getFiber());
		statement.setString(11,recipe.getDescription());
		statement.setString(12,recipe.getRecipeImage());
		statement.setInt(13,recipe.getRecipeId());
		statement.setInt(14,recipe.getCreatedBy());
return statement.executeUpdate()>0;
}
}
public boolean deleteRecipe(int recipeId,int userId){
String sql="DELETE FROM recipes WHERE recipe_id=? AND created_by=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
statement.setInt(2,userId);
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
public int countRecipesByUser(int userId){
String sql="SELECT COUNT(*) FROM recipes WHERE created_by=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
return resultSet.getInt(1);
}
}
}catch(Exception e){
e.printStackTrace();
}
return 0;
}
private Recipe mapRecipe(ResultSet resultSet)throws Exception{
Recipe recipe=new Recipe();
recipe.setRecipeId(resultSet.getInt("recipe_id"));
recipe.setRecipeName(resultSet.getString("recipe_name"));
recipe.setCategoryId(resultSet.getInt("category_id"));
recipe.setCategoryName(resultSet.getString("category_name"));
recipe.setCuisine(resultSet.getString("cuisine"));
recipe.setDifficulty(resultSet.getString("difficulty"));
recipe.setCookingTime(resultSet.getInt("cooking_time"));
recipe.setCalories(resultSet.getInt("calories"));
recipe.setProtein(resultSet.getDouble("protein"));
recipe.setCarbohydrates(resultSet.getDouble("carbohydrates"));
recipe.setFat(resultSet.getDouble("fat"));
recipe.setFiber(resultSet.getDouble("fiber"));
recipe.setDescription(resultSet.getString("description"));
recipe.setRecipeImage(resultSet.getString("recipe_image"));
recipe.setCreatedBy(resultSet.getInt("created_by"));
recipe.setCreatorName(resultSet.getString("full_name"));
recipe.setCreatedAt(resultSet.getTimestamp("created_at"));
recipe.setUpdatedAt(resultSet.getTimestamp("updated_at"));
return recipe;
}
}
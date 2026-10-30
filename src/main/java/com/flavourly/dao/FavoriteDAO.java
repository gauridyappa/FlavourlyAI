package com.flavourly.dao;
import com.flavourly.model.Recipe;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class FavoriteDAO{
public boolean addFavorite(int userId,int recipeId){
String sql="INSERT IGNORE INTO favorites(user_id,recipe_id) VALUES(?,?)";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
statement.setInt(2,recipeId);
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
}
return false;
}
public boolean removeFavorite(int userId,int recipeId){
String sql="DELETE FROM favorites WHERE user_id=? AND recipe_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
statement.setInt(2,recipeId);
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
}
return false;
}
public boolean isFavorite(int userId,int recipeId){
String sql="SELECT favorite_id FROM favorites WHERE user_id=? AND recipe_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
statement.setInt(2,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
return resultSet.next();
}
}catch(Exception e){
e.printStackTrace();
}
return false;
}
public List<Recipe> getFavoritesByUserId(int userId){
List<Recipe> recipes=new ArrayList<>();
String sql="SELECT r.recipe_id,r.recipe_name,r.category_id,c.category_name,r.cuisine,r.difficulty,r.cooking_time,r.calories,r.description,r.recipe_image,r.created_by,r.created_at AS recipe_created_at,r.updated_at FROM favorites f JOIN recipes r ON f.recipe_id=r.recipe_id LEFT JOIN categories c ON r.category_id=c.category_id WHERE f.user_id=? ORDER BY f.created_at DESC";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
Recipe recipe=new Recipe();
recipe.setRecipeId(resultSet.getInt("recipe_id"));
recipe.setRecipeName(resultSet.getString("recipe_name"));
recipe.setCategoryId(resultSet.getInt("category_id"));
recipe.setCategoryName(resultSet.getString("category_name"));
recipe.setCuisine(resultSet.getString("cuisine"));
recipe.setDifficulty(resultSet.getString("difficulty"));
recipe.setCookingTime(resultSet.getInt("cooking_time"));
recipe.setCalories(resultSet.getInt("calories"));
recipe.setDescription(resultSet.getString("description"));
recipe.setRecipeImage(resultSet.getString("recipe_image"));
recipe.setCreatedBy(resultSet.getInt("created_by"));
recipe.setCreatedAt(resultSet.getTimestamp("recipe_created_at"));
recipe.setUpdatedAt(resultSet.getTimestamp("updated_at"));
recipes.add(recipe);
}
}
}catch(Exception e){
e.printStackTrace();
}
return recipes;
}
public int getFavoriteCountByUserId(int userId){
String sql="SELECT COUNT(*) FROM favorites WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
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
}
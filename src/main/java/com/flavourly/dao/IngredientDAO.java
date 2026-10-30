package com.flavourly.dao;
import com.flavourly.model.Ingredient;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class IngredientDAO {
public boolean addIngredients(List<Ingredient> ingredients,int recipeId,Connection connection)throws Exception{
String sql="INSERT INTO ingredients(recipe_id,ingredient_name,quantity,unit) VALUES(?,?,?,?)";
try(PreparedStatement statement=connection.prepareStatement(sql)){
for(Ingredient ingredient:ingredients){
statement.setInt(1,recipeId);
statement.setString(2,ingredient.getIngredientName());
statement.setString(3,ingredient.getQuantity());
statement.setString(4,ingredient.getUnit());
statement.addBatch();
}
statement.executeBatch();
return true;
}
}
public List<Ingredient> getIngredientsByRecipeId(int recipeId){
List<Ingredient> ingredients=new ArrayList<>();
String sql="SELECT * FROM ingredients WHERE recipe_id=? ORDER BY ingredient_id ASC";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
Ingredient ingredient=new Ingredient();
ingredient.setIngredientId(resultSet.getInt("ingredient_id"));
ingredient.setRecipeId(resultSet.getInt("recipe_id"));
ingredient.setIngredientName(resultSet.getString("ingredient_name"));
ingredient.setQuantity(resultSet.getString("quantity"));
ingredient.setUnit(resultSet.getString("unit"));
ingredients.add(ingredient);
}
}
}catch(Exception e){
e.printStackTrace();
}
return ingredients;
}
public boolean deleteIngredientsByRecipeId(int recipeId,Connection connection)throws Exception{
String sql="DELETE FROM ingredients WHERE recipe_id=?";
try(PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
statement.executeUpdate();
return true;
}
}
public boolean updateIngredients(List<Ingredient> ingredients,int recipeId,Connection connection)throws Exception{
deleteIngredientsByRecipeId(recipeId,connection);
return addIngredients(ingredients,recipeId,connection);
}
}
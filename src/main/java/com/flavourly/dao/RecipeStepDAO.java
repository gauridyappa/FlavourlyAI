package com.flavourly.dao;
import com.flavourly.model.RecipeStep;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class RecipeStepDAO {
public boolean addRecipeSteps(List<RecipeStep> recipeSteps,int recipeId,Connection connection)throws Exception{
String sql="INSERT INTO recipe_steps(recipe_id,step_number,instruction) VALUES(?,?,?)";
try(PreparedStatement statement=connection.prepareStatement(sql)){
for(RecipeStep recipeStep:recipeSteps){
statement.setInt(1,recipeId);
statement.setInt(2,recipeStep.getStepNumber());
statement.setString(3,recipeStep.getInstruction());
statement.addBatch();
}
statement.executeBatch();
return true;
}
}
public List<RecipeStep> getStepsByRecipeId(int recipeId){
List<RecipeStep> recipeSteps=new ArrayList<>();
String sql="SELECT * FROM recipe_steps WHERE recipe_id=? ORDER BY step_number ASC";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
RecipeStep recipeStep=new RecipeStep();
recipeStep.setStepId(resultSet.getInt("step_id"));
recipeStep.setRecipeId(resultSet.getInt("recipe_id"));
recipeStep.setStepNumber(resultSet.getInt("step_number"));
recipeStep.setInstruction(resultSet.getString("instruction"));
recipeSteps.add(recipeStep);
}
}
}catch(Exception e){
e.printStackTrace();
}
return recipeSteps;
}
public boolean deleteStepsByRecipeId(int recipeId,Connection connection)throws Exception{
String sql="DELETE FROM recipe_steps WHERE recipe_id=?";
try(PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
statement.executeUpdate();
return true;
}
}
public boolean updateRecipeSteps(List<RecipeStep> recipeSteps,int recipeId,Connection connection)throws Exception{
deleteStepsByRecipeId(recipeId,connection);
return addRecipeSteps(recipeSteps,recipeId,connection);
}
}
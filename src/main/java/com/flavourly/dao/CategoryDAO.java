package com.flavourly.dao;
import com.flavourly.model.Category;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class CategoryDAO {
public List<Category> getAllCategories(){
List<Category> categories=new ArrayList<>();
String sql="SELECT * FROM categories ORDER BY category_name ASC";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql);
ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
Category category=new Category();
category.setCategoryId(resultSet.getInt("category_id"));
category.setCategoryName(resultSet.getString("category_name"));
category.setDescription(resultSet.getString("description"));
category.setCategoryImage(resultSet.getString("category_image"));
category.setCreatedAt(resultSet.getTimestamp("created_at"));
categories.add(category);
}
}catch(Exception e){
e.printStackTrace();
}
return categories;
}
public Category getCategoryById(int categoryId){
Category category=null;
String sql="SELECT * FROM categories WHERE category_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,categoryId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
category=new Category();
category.setCategoryId(resultSet.getInt("category_id"));
category.setCategoryName(resultSet.getString("category_name"));
category.setDescription(resultSet.getString("description"));
category.setCategoryImage(resultSet.getString("category_image"));
category.setCreatedAt(resultSet.getTimestamp("created_at"));
}
}
}catch(Exception e){
e.printStackTrace();
}
return category;
}
public int getCategoryCount(){
String sql="SELECT COUNT(*) FROM categories";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql);
ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
return resultSet.getInt(1);
}
}catch(Exception e){
e.printStackTrace();
}
return 0;
}
public int getCategoryIdByName(String categoryName){
String sql="SELECT category_id FROM categories WHERE LOWER(category_name)=LOWER(?)";
try(Connection connection=DBConnection.getConnection();
PreparedStatement statement=connection.prepareStatement(sql)){
statement.setString(1,categoryName);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
return resultSet.getInt("category_id");
}
}
}catch(Exception e){
e.printStackTrace();
}
return 0;
}
}
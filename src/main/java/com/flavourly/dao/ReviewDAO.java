package com.flavourly.dao;
import com.flavourly.model.Review;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class ReviewDAO{
public boolean addReview(Review review){
String sql="INSERT INTO reviews(recipe_id,user_id,rating,review) VALUES(?,?,?,?)";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,review.getRecipeId());
statement.setInt(2,review.getUserId());
statement.setInt(3,review.getRating());
statement.setString(4,review.getReview());
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
public List<Review> getReviewsByRecipe(int recipeId){
List<Review> reviews=new ArrayList<>();
String sql="SELECT rv.*,u.full_name,r.recipe_name FROM reviews rv JOIN users u ON rv.user_id=u.user_id JOIN recipes r ON rv.recipe_id=r.recipe_id WHERE rv.recipe_id=? ORDER BY rv.created_at DESC";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
reviews.add(mapReview(resultSet));
}
}
}catch(Exception e){
e.printStackTrace();
}
return reviews;
}
public List<Review> getReviewsByUser(int userId){
List<Review> reviews=new ArrayList<>();
String sql="SELECT rv.*,u.full_name,r.recipe_name FROM reviews rv JOIN users u ON rv.user_id=u.user_id JOIN recipes r ON rv.recipe_id=r.recipe_id WHERE rv.user_id=? ORDER BY rv.created_at DESC";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
reviews.add(mapReview(resultSet));
}
}
}catch(Exception e){
e.printStackTrace();
}
return reviews;
}
public List<Review> getAllReviews(){
List<Review> reviews=new ArrayList<>();
String sql="SELECT rv.*,u.full_name,r.recipe_name FROM reviews rv JOIN users u ON rv.user_id=u.user_id JOIN recipes r ON rv.recipe_id=r.recipe_id ORDER BY rv.created_at DESC";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql);ResultSet resultSet=statement.executeQuery()){
while(resultSet.next()){
reviews.add(mapReview(resultSet));
}
}catch(Exception e){
e.printStackTrace();
}
return reviews;
}
public double getAverageRatingByRecipe(int recipeId){
String sql="SELECT COALESCE(AVG(rating),0) FROM reviews WHERE recipe_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
return resultSet.getDouble(1);
}
}
}catch(Exception e){
e.printStackTrace();
}
return 0;
}
public int countReviewsByRecipe(int recipeId){
String sql="SELECT COUNT(*) FROM reviews WHERE recipe_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,recipeId);
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
public boolean hasUserReviewedRecipe(int userId,int recipeId){
String sql="SELECT COUNT(*) FROM reviews WHERE user_id=? AND recipe_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
statement.setInt(2,recipeId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next()){
return resultSet.getInt(1)>0;
}
}
}catch(Exception e){
e.printStackTrace();
}
return false;
}
public boolean updateReview(Review review){
String sql="UPDATE reviews SET rating=?,review=? WHERE review_id=? AND user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,review.getRating());
statement.setString(2,review.getReview());
statement.setInt(3,review.getReviewId());
statement.setInt(4,review.getUserId());
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
public boolean deleteReview(int reviewId,int userId){
String sql="DELETE FROM reviews WHERE review_id=? AND user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,reviewId);
statement.setInt(2,userId);
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
private Review mapReview(ResultSet resultSet)throws Exception{
Review review=new Review();
review.setReviewId(resultSet.getInt("review_id"));
review.setRecipeId(resultSet.getInt("recipe_id"));
review.setUserId(resultSet.getInt("user_id"));
review.setRating(resultSet.getInt("rating"));
review.setReview(resultSet.getString("review"));
review.setCreatedAt(resultSet.getTimestamp("created_at"));
review.setUserName(resultSet.getString("full_name"));
review.setRecipeName(resultSet.getString("recipe_name"));
return review;
}
}
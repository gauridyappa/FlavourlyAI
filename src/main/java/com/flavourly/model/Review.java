package com.flavourly.model;
import java.sql.Timestamp;
public class Review{
private int reviewId;
private int recipeId;
private int userId;
private int rating;
private String review;
private Timestamp createdAt;
private String userName;
private String recipeName;
public Review(){}
public int getReviewId(){
return reviewId;
}
public void setReviewId(int reviewId){
this.reviewId=reviewId;
}
public int getRecipeId(){
return recipeId;
}
public void setRecipeId(int recipeId){
this.recipeId=recipeId;
}
public int getUserId(){
return userId;
}
public void setUserId(int userId){
this.userId=userId;
}
public int getRating(){
return rating;
}
public void setRating(int rating){
this.rating=rating;
}
public String getReview(){
return review;
}
public void setReview(String review){
this.review=review;
}
public Timestamp getCreatedAt(){
return createdAt;
}
public void setCreatedAt(Timestamp createdAt){
this.createdAt=createdAt;
}
public String getUserName(){
return userName;
}
public void setUserName(String userName){
this.userName=userName;
}
public String getRecipeName(){
return recipeName;
}
public void setRecipeName(String recipeName){
this.recipeName=recipeName;
}
}
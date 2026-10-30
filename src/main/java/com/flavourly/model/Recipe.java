package com.flavourly.model;
import java.sql.Timestamp;
public class Recipe {
private int recipeId;
private String recipeName;
private int categoryId;
private String categoryName;
private String cuisine;
private String difficulty;
private int cookingTime;
private int calories;
private double protein;
private double carbohydrates;
private double fat;
private double fiber;
private String description;
private String recipeImage;
private int createdBy;
private String creatorName;
private Timestamp createdAt;
private Timestamp updatedAt;
public Recipe() {}
public Recipe(String recipeName,int categoryId,String cuisine,String difficulty,int cookingTime,int calories,String description,String recipeImage,int createdBy){
this.recipeName=recipeName;
this.categoryId=categoryId;
this.cuisine=cuisine;
this.difficulty=difficulty;
this.cookingTime=cookingTime;
this.calories=calories;
this.description=description;
this.recipeImage=recipeImage;
this.createdBy=createdBy;
}
public int getRecipeId(){
return recipeId;
}
public void setRecipeId(int recipeId){
this.recipeId=recipeId;
}
public String getRecipeName(){
return recipeName;
}
public void setRecipeName(String recipeName){
this.recipeName=recipeName;
}
public int getCategoryId(){
return categoryId;
}
public void setCategoryId(int categoryId){
this.categoryId=categoryId;
}
public String getCategoryName(){
return categoryName;
}
public void setCategoryName(String categoryName){
this.categoryName=categoryName;
}
public String getCuisine(){
return cuisine;
}
public void setCuisine(String cuisine){
this.cuisine=cuisine;
}
public String getDifficulty(){
return difficulty;
}
public void setDifficulty(String difficulty){
this.difficulty=difficulty;
}
public int getCookingTime(){
return cookingTime;
}
public void setCookingTime(int cookingTime){
this.cookingTime=cookingTime;
}
public int getCalories(){
return calories;
}
public void setCalories(int calories){
this.calories=calories;
}
public double getProtein(){
return protein;
}
public void setProtein(double protein){
this.protein=protein;
}
public double getCarbohydrates(){
return carbohydrates;
}
public void setCarbohydrates(double carbohydrates){
this.carbohydrates=carbohydrates;
}
public double getFat(){
return fat;
}
public void setFat(double fat){
this.fat=fat;
}
public double getFiber(){
return fiber;
}
public void setFiber(double fiber){
this.fiber=fiber;
}
public String getDescription(){
return description;
}
public void setDescription(String description){
this.description=description;
}
public String getRecipeImage(){
return recipeImage;
}
public void setRecipeImage(String recipeImage){
this.recipeImage=recipeImage;
}
public int getCreatedBy(){
return createdBy;
}
public void setCreatedBy(int createdBy){
this.createdBy=createdBy;
}
public String getCreatorName(){
return creatorName;
}
public void setCreatorName(String creatorName){
this.creatorName=creatorName;
}
public Timestamp getCreatedAt(){
return createdAt;
}
public void setCreatedAt(Timestamp createdAt){
this.createdAt=createdAt;
}
public Timestamp getUpdatedAt(){
return updatedAt;
}
public void setUpdatedAt(Timestamp updatedAt){
this.updatedAt=updatedAt;
}
}
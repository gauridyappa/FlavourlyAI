package com.flavourly.model;
import java.util.ArrayList;
import java.util.List;
public class AIRecipe{
private String recipeName;
private String category;
private String description;
private String cuisine;
private String difficulty;
private int cookingTime;
private int calories;
private double protein;
private double carbohydrates;
private double fat;
private double fiber;
private List<AIIngredient> ingredients;
private List<String> instructions;
public AIRecipe(){
ingredients=new ArrayList<>();
instructions=new ArrayList<>();
}
public String getRecipeName(){
return recipeName;
}
public void setRecipeName(String recipeName){
this.recipeName=recipeName;
}
public String getCategory(){
return category;
}
public void setCategory(String category){
this.category=category;
}
public String getDescription(){
return description;
}
public void setDescription(String description){
this.description=description;
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
public List<AIIngredient> getIngredients(){
return ingredients;
}
public void setIngredients(List<AIIngredient> ingredients){
this.ingredients=ingredients;
}
public List<String> getInstructions(){
return instructions;
}
public void setInstructions(List<String> instructions){
this.instructions=instructions;
}
}
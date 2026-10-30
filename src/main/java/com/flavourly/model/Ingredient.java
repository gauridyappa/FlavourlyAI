package com.flavourly.model;
public class Ingredient {
private int ingredientId;
private int recipeId;
private String ingredientName;
private String quantity;
private String unit;
public Ingredient(){}
public Ingredient(String ingredientName,String quantity,String unit){
this.ingredientName=ingredientName;
this.quantity=quantity;
this.unit=unit;
}
public Ingredient(int recipeId,String ingredientName,String quantity,String unit){
this.recipeId=recipeId;
this.ingredientName=ingredientName;
this.quantity=quantity;
this.unit=unit;
}
public int getIngredientId(){
return ingredientId;
}
public void setIngredientId(int ingredientId){
this.ingredientId=ingredientId;
}
public int getRecipeId(){
return recipeId;
}
public void setRecipeId(int recipeId){
this.recipeId=recipeId;
}
public String getIngredientName(){
return ingredientName;
}
public void setIngredientName(String ingredientName){
this.ingredientName=ingredientName;
}
public String getQuantity(){
return quantity;
}
public void setQuantity(String quantity){
this.quantity=quantity;
}
public String getUnit(){
return unit;
}
public void setUnit(String unit){
this.unit=unit;
}
}
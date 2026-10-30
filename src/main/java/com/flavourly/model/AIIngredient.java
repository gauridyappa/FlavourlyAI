package com.flavourly.model;
public class AIIngredient{
private String ingredientName;
private String quantity;
private String unit;
public AIIngredient(){}
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
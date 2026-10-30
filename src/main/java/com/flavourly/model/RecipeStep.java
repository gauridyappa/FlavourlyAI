package com.flavourly.model;
public class RecipeStep {
private int stepId;
private int recipeId;
private int stepNumber;
private String instruction;
public RecipeStep(){}
public RecipeStep(int stepNumber,String instruction){
this.stepNumber=stepNumber;
this.instruction=instruction;
}
public RecipeStep(int recipeId,int stepNumber,String instruction){
this.recipeId=recipeId;
this.stepNumber=stepNumber;
this.instruction=instruction;
}
public int getStepId(){
return stepId;
}
public void setStepId(int stepId){
this.stepId=stepId;
}
public int getRecipeId(){
return recipeId;
}
public void setRecipeId(int recipeId){
this.recipeId=recipeId;
}
public int getStepNumber(){
return stepNumber;
}
public void setStepNumber(int stepNumber){
this.stepNumber=stepNumber;
}
public String getInstruction(){
return instruction;
}
public void setInstruction(String instruction){
this.instruction=instruction;
}
}
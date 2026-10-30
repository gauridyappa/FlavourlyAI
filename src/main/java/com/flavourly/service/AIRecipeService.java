package com.flavourly.service;
import com.flavourly.model.AIRecipe;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
public class AIRecipeService{
private static final String API_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
private final Gson gson;
public AIRecipeService(){
gson=new Gson();
}
public AIRecipe generateRecipe(String ingredients,String cuisine,String difficulty,String dietaryPreference)throws Exception{
String apiKey=System.getenv("GEMINI_API_KEY");
if(apiKey==null||apiKey.trim().isEmpty()){
throw new Exception("Gemini API key is not configured.");
}
String prompt=createPrompt(ingredients,cuisine,difficulty,dietaryPreference);
JsonObject textPart=new JsonObject();
textPart.addProperty("text",prompt);
JsonArray parts=new JsonArray();
parts.add(textPart);
JsonObject content=new JsonObject();
content.add("parts",parts);
JsonArray contents=new JsonArray();
contents.add(content);
JsonObject generationConfig=new JsonObject();
generationConfig.addProperty("responseMimeType","application/json");
JsonObject requestBody=new JsonObject();
requestBody.add("contents",contents);
requestBody.add("generationConfig",generationConfig);
URL url=new URL(API_URL+"?key="+apiKey);
HttpURLConnection connection=(HttpURLConnection)url.openConnection();
connection.setRequestMethod("POST");
connection.setRequestProperty("Content-Type","application/json;charset=UTF-8");
connection.setConnectTimeout(15000);
connection.setReadTimeout(60000);
connection.setDoOutput(true);
byte[] requestBytes=gson.toJson(requestBody).getBytes(StandardCharsets.UTF_8);
try(OutputStream outputStream=connection.getOutputStream()){
outputStream.write(requestBytes);
}
int responseCode=connection.getResponseCode();
BufferedReader reader;
if(responseCode>=200&&responseCode<300){
reader=new BufferedReader(new InputStreamReader(connection.getInputStream(),StandardCharsets.UTF_8));
}else{
reader=new BufferedReader(new InputStreamReader(connection.getErrorStream(),StandardCharsets.UTF_8));
}
StringBuilder responseBody=new StringBuilder();
String line;
while((line=reader.readLine())!=null){
responseBody.append(line);
}
reader.close();
connection.disconnect();
if(responseCode<200||responseCode>=300){
throw new Exception("Gemini API request failed with status "+responseCode+": "+responseBody);
}
JsonObject apiResponse=gson.fromJson(responseBody.toString(),JsonObject.class);
JsonArray candidates=apiResponse.getAsJsonArray("candidates");
if(candidates==null||candidates.size()==0){
throw new Exception("Gemini did not generate a recipe.");
}
JsonObject candidate=candidates.get(0).getAsJsonObject();
JsonObject responseContent=candidate.getAsJsonObject("content");
JsonArray responseParts=responseContent.getAsJsonArray("parts");
if(responseParts==null||responseParts.size()==0){
throw new Exception("Gemini returned an empty recipe response.");
}
String recipeJson=responseParts.get(0).getAsJsonObject().get("text").getAsString();
AIRecipe recipe=gson.fromJson(recipeJson,AIRecipe.class);
if(recipe==null||recipe.getRecipeName()==null||recipe.getRecipeName().trim().isEmpty()){
throw new Exception("Generated recipe data is invalid.");
}
return recipe;
}
private String createPrompt(String ingredients,String cuisine,String difficulty,String dietaryPreference){
return "Create one practical cooking recipe using the user's available ingredients. "+
"Return ONLY valid JSON with no markdown, no code fences and no additional text. "+
"Use exactly this JSON structure: "+
"{\"recipeName\":\"string\",\"category\":\"Breakfast, Lunch, Dinner, Healthy, Desserts, or Snacks\",\"description\":\"string\",\"cuisine\":\"string\","+
"\"difficulty\":\"Easy, Medium, or Hard\",\"cookingTime\":30,\"calories\":400,"+
"\"protein\":25.5,\"carbohydrates\":45.0,\"fat\":12.5,\"fiber\":6.0,"+
"\"ingredients\":[{\"ingredientName\":\"string\",\"quantity\":\"string\",\"unit\":\"string\"}],"+
"\"instructions\":[\"clear cooking step\"]}. "+
"Available ingredients: "+ingredients+". "+
"Preferred cuisine: "+cuisine+". "+
"Difficulty: "+difficulty+". "+
"Dietary preference: "+dietaryPreference+". "+
"For every ingredient, keep ingredientName, quantity and unit as separate values. "+
"Examples: paneer should be {\"ingredientName\":\"Paneer\",\"quantity\":\"200\",\"unit\":\"g\"}, "+
"onion should be {\"ingredientName\":\"Onion\",\"quantity\":\"1\",\"unit\":\"medium\"}. "+
"Use sensible quantities, realistic cooking time and estimated nutritional values. "+
"Return calories as a whole number. "+
"Return protein, carbohydrates, fat and fiber as numeric gram values without units or text. "+
"Estimate all nutritional values for one serving of the generated recipe. "+
"Choose exactly one category from these values only: Breakfast, Lunch, Dinner, Healthy, Desserts, Snacks. "+
"Do not return any other category value. "+
"Choose the category that best matches the generated recipe. "+
"Do not include ingredients that conflict with the dietary preference.";
}
}
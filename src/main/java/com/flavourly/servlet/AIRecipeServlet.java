package com.flavourly.servlet;
import com.flavourly.model.AIRecipe;
import com.flavourly.service.AIRecipeService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/aiGenerator")
public class AIRecipeServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private AIRecipeService aiRecipeService;
@Override
public void init(){
aiRecipeService=new AIRecipeService();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
request.getRequestDispatcher("/pages/aiGenerator.jsp").forward(request,response);
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
request.setCharacterEncoding("UTF-8");
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
String ingredients=request.getParameter("ingredients");
String cuisine=request.getParameter("cuisine");
String difficulty=request.getParameter("difficulty");
String dietaryPreference=request.getParameter("dietaryPreference");
if(ingredients==null||ingredients.trim().isEmpty()){
request.setAttribute("error","Please enter at least one available ingredient.");
request.getRequestDispatcher("/pages/aiGenerator.jsp").forward(request,response);
return;
}
if(cuisine==null||cuisine.trim().isEmpty()){
cuisine="Any";
}
if(difficulty==null||difficulty.trim().isEmpty()){
difficulty="Easy";
}
if(dietaryPreference==null||dietaryPreference.trim().isEmpty()){
dietaryPreference="None";
}
try{
AIRecipe generatedRecipe=aiRecipeService.generateRecipe(
ingredients.trim(),
cuisine.trim(),
difficulty.trim(),
dietaryPreference.trim()
);

session.setAttribute("generatedAIRecipe",generatedRecipe);
request.setAttribute("generatedRecipe",generatedRecipe);
request.setAttribute("enteredIngredients",ingredients);
request.setAttribute("selectedCuisine",cuisine);
request.setAttribute("selectedDifficulty",difficulty);
request.setAttribute("selectedDietaryPreference",dietaryPreference);
request.getRequestDispatcher("/pages/aiGenerator.jsp").forward(request,response);
}catch(Exception e){
e.printStackTrace();
request.setAttribute("error","Recipe generation failed. Please try again.");
request.setAttribute("enteredIngredients",ingredients);
request.setAttribute("selectedCuisine",cuisine);
request.setAttribute("selectedDifficulty",difficulty);
request.setAttribute("selectedDietaryPreference",dietaryPreference);
request.getRequestDispatcher("/pages/aiGenerator.jsp").forward(request,response);
}
}
}
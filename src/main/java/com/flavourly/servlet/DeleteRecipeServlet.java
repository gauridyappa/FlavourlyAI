package com.flavourly.servlet;
import com.flavourly.model.Recipe;
import com.flavourly.model.User;
import com.flavourly.service.RecipeService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/delete-recipe")
public class DeleteRecipeServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
@Override
public void init(){
recipeService=new RecipeService();
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
try{
String recipeIdValue=request.getParameter("id");
if(recipeIdValue==null||recipeIdValue.trim().isEmpty()){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=invalidId");
return;
}
int recipeId=Integer.parseInt(recipeIdValue);
Recipe recipe=recipeService.getRecipeById(recipeId);
if(recipe==null){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=notFound");
return;
}
if(recipe.getCreatedBy()!=loggedUser.getUserId()){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=unauthorized");
return;
}
boolean deleted=recipeService.deleteRecipe(recipeId,loggedUser.getUserId());
if(deleted){
response.sendRedirect(request.getContextPath()+"/my-recipes?success=deleted");
}else{
response.sendRedirect(request.getContextPath()+"/my-recipes?error=deleteFailed");
}
}catch(NumberFormatException e){
response.sendRedirect(request.getContextPath()+"/my-recipes?error=invalidId");
}
}
}
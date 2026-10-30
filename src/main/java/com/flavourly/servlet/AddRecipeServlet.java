package com.flavourly.servlet;
import com.flavourly.dao.CategoryDAO;
import com.flavourly.model.Category;
import com.flavourly.model.Ingredient;
import com.flavourly.model.Recipe;
import com.flavourly.model.RecipeStep;
import com.flavourly.model.User;
import com.flavourly.service.RecipeService;
import com.flavourly.util.ImageUploadUtil;
import com.flavourly.util.UploadConfig;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@WebServlet("/add-recipe")
@MultipartConfig(maxFileSize=5*1024*1024,maxRequestSize=10*1024*1024)
public class AddRecipeServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private RecipeService recipeService;
private CategoryDAO categoryDAO;
@Override
public void init(){
recipeService=new RecipeService();
categoryDAO=new CategoryDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
List<Category> categories=categoryDAO.getAllCategories();
request.setAttribute("categories",categories);
request.getRequestDispatcher("/pages/addRecipe.jsp").forward(request,response);
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
request.setCharacterEncoding("UTF-8");
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
String uploadedImageName=null;
try{
String recipeName=request.getParameter("recipeName");
int categoryId=Integer.parseInt(request.getParameter("categoryId"));
String cuisine=request.getParameter("cuisine");
String difficulty=request.getParameter("difficulty");
int cookingTime=Integer.parseInt(request.getParameter("cookingTime"));
String caloriesValue=request.getParameter("calories");
int calories=(caloriesValue==null||caloriesValue.trim().isEmpty())?0:Integer.parseInt(caloriesValue);
String proteinValue=request.getParameter("protein");
double protein=(proteinValue==null||proteinValue.trim().isEmpty())?0:Double.parseDouble(proteinValue);
String carbohydratesValue=request.getParameter("carbohydrates");
double carbohydrates=(carbohydratesValue==null||carbohydratesValue.trim().isEmpty())?0:Double.parseDouble(carbohydratesValue);
String fatValue=request.getParameter("fat");
double fat=(fatValue==null||fatValue.trim().isEmpty())?0:Double.parseDouble(fatValue);
String fiberValue=request.getParameter("fiber");
double fiber=(fiberValue==null||fiberValue.trim().isEmpty())?0:Double.parseDouble(fiberValue);
String description=request.getParameter("description");
Part imagePart=request.getPart("recipeImage");
String uploadPath=UploadConfig.RECIPE_IMAGE_DIRECTORY;
uploadedImageName=ImageUploadUtil.saveRecipeImage(imagePart,uploadPath);
if(uploadedImageName==null){
uploadedImageName="default-recipe.jpg";
}
Recipe recipe=new Recipe();
recipe.setRecipeName(recipeName);
recipe.setCategoryId(categoryId);
recipe.setCuisine(cuisine);
recipe.setDifficulty(difficulty);
recipe.setCookingTime(cookingTime);
recipe.setCalories(calories);
recipe.setProtein(protein);
recipe.setCarbohydrates(carbohydrates);
recipe.setFat(fat);
recipe.setFiber(fiber);
recipe.setDescription(description);
recipe.setRecipeImage(uploadedImageName);
recipe.setCreatedBy(loggedUser.getUserId());
List<Ingredient> ingredients=new ArrayList<>();
String[] ingredientNames=request.getParameterValues("ingredientName");
String[] quantities=request.getParameterValues("quantity");
String[] units=request.getParameterValues("unit");
if(ingredientNames!=null){
for(int i=0;i<ingredientNames.length;i++){
if(ingredientNames[i]!=null&&!ingredientNames[i].trim().isEmpty()){
String quantity=quantities!=null&&i<quantities.length?quantities[i]:"";
String unit=units!=null&&i<units.length?units[i]:"";
ingredients.add(new Ingredient(ingredientNames[i].trim(),quantity.trim(),unit.trim()));
}
}
}
List<RecipeStep> recipeSteps=new ArrayList<>();
String[] instructions=request.getParameterValues("instruction");
if(instructions!=null){
int stepNumber=1;
for(String instruction:instructions){
if(instruction!=null&&!instruction.trim().isEmpty()){
recipeSteps.add(new RecipeStep(stepNumber++,instruction.trim()));
}
}
}
if(ingredients.isEmpty()||recipeSteps.isEmpty()){
if(!"default-recipe.jpg".equals(uploadedImageName)){
ImageUploadUtil.deleteRecipeImage(uploadedImageName,uploadPath);
}
response.sendRedirect(request.getContextPath()+"/add-recipe?error=missingDetails");
return;
}
boolean added=recipeService.addRecipe(recipe,ingredients,recipeSteps);
if(added){
response.sendRedirect(request.getContextPath()+"/my-recipes?success=added");
}else{
if(!"default-recipe.jpg".equals(uploadedImageName)){
ImageUploadUtil.deleteRecipeImage(uploadedImageName,uploadPath);
}
response.sendRedirect(request.getContextPath()+"/add-recipe?error=failed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/add-recipe?error=imageUpload");
}
}
}
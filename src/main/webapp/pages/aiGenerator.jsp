<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.AIRecipe"%>
<%@page import="com.flavourly.model.User"%>
<%@page import="com.flavourly.model.AIIngredient"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
AIRecipe generatedRecipe=(AIRecipe)request.getAttribute("generatedRecipe");
String error=(String)request.getAttribute("error");
String enteredIngredients=(String)request.getAttribute("enteredIngredients");
String selectedCuisine=(String)request.getAttribute("selectedCuisine");
String selectedDifficulty=(String)request.getAttribute("selectedDifficulty");
String selectedDietaryPreference=(String)request.getAttribute("selectedDietaryPreference");
if(enteredIngredients==null)enteredIngredients="";
if(selectedCuisine==null)selectedCuisine="Any";
if(selectedDifficulty==null)selectedDifficulty="Easy";
if(selectedDietaryPreference==null)selectedDietaryPreference="None";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>AI Recipe Generator | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ai-generator.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive-dashboard.css">
</head>
<body>
<div class="dashboard">
<aside class="sidebar">
<div class="sidebar-logo">
<a href="<%=request.getContextPath()%>/index.jsp" class="logo">
<div class="logo-icon"><i class="fa-solid fa-utensils"></i></div>
<span>Flavourly</span>
</a>
</div>
<ul class="sidebar-menu">
<li>
<a href="<%=request.getContextPath()%>/dashboard">
<i class="fa-solid fa-house"></i>
<span>Dashboard</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/my-recipes">
<i class="fa-solid fa-book-open"></i>
<span>My Recipes</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/add-recipe">
<i class="fa-solid fa-square-plus"></i>
<span>Add Recipe</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/favorites">
<i class="fa-solid fa-heart"></i>
<span>Favorites</span>
</a>
</li>
<li class="active">
<a href="<%=request.getContextPath()%>/aiGenerator">
<i class="fa-solid fa-wand-magic-sparkles"></i>
<span>AI Generator</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/nutrition">
<i class="fa-solid fa-chart-pie"></i>
<span>Nutrition</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/reviews">
<i class="fa-solid fa-star"></i>
<span>Reviews</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/profile">
<i class="fa-solid fa-user"></i>
<span>Profile</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/settings">
<i class="fa-solid fa-gear"></i>
<span>Settings</span>
</a>
</li>
<li>
<a href="<%=request.getContextPath()%>/logout">
<i class="fa-solid fa-right-from-bracket"></i>
<span>Logout</span>
</a>
</li>
</ul>
</aside>

<div class="main-content">
<header class="topbar">
<div class="left-top">
<button type="button" class="menu-btn">
<i class="fa-solid fa-bars"></i>
</button>
<div class="page-title">
<h2>AI Recipe Generator</h2>
<p>Turn your available ingredients into a personalized recipe</p>
</div>
</div>
<div class="right-top">
<button type="button" class="icon-btn">
<i class="fa-regular fa-bell"></i>
</button>
<div class="user-box">
<div class="avatar">
<i class="fa-solid fa-user"></i>
</div>
<div>
<h4><%=loggedUser.getFullName()%></h4>
<p><%=loggedUser.getRole()%></p>
</div>
</div>
</div>
</header>

<main class="dashboard-content">

<section class="ai-hero-card">
<div class="ai-hero-content">
<span class="ai-hero-badge">
<i class="fa-solid fa-wand-magic-sparkles"></i>
Powered by Artificial Intelligence
</span>
<h1>What Can We Cook Today?</h1>
<p>Enter the ingredients you already have, choose your preferences and let Flavourly AI create a personalized recipe for you.</p>
</div>
<div class="ai-hero-visual">
<div class="ai-hero-circle">
<i class="fa-solid fa-wand-magic-sparkles"></i>
</div>
</div>
</section>

<%
if(error!=null&&!error.trim().isEmpty()){
%>
<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
<%=error%>
</div>
<%
}
%>

<section class="ai-generator-layout">

<div class="ai-generator-form-column">

<section class="ai-generator-card">

<div class="ai-card-header">
<div class="ai-card-icon">
<i class="fa-solid fa-sliders"></i>
</div>
<div>
<h2>Create Your Recipe</h2>
<p>Tell Flavourly AI what ingredients and preferences you have.</p>
</div>
</div>
<form action="<%=request.getContextPath()%>/aiGenerator" method="post" class="ai-generator-form" id="aiGeneratorForm">

<div class="ai-form-group full-width">
<label for="ingredients">Available Ingredients</label>
<div class="ai-textarea-box">
<i class="fa-solid fa-basket-shopping"></i>
<textarea id="ingredients" name="ingredients" placeholder="Example: paneer, tomato, onion, rice, cheese..." maxlength="500" required><%=enteredIngredients%></textarea>
</div>
<div class="ai-form-help">
<span><i class="fa-solid fa-circle-info"></i>Separate multiple ingredients using commas.</span>
<span id="ingredientCharacterCount"><%=enteredIngredients.length()%>/500</span>
</div>
</div>

<div class="ai-form-grid">

<div class="ai-form-group">
<label for="cuisine">Preferred Cuisine</label>
<div class="ai-select-box">
<i class="fa-solid fa-earth-americas"></i>
<select id="cuisine" name="cuisine">
<option value="Any" <%="Any".equals(selectedCuisine)?"selected":""%>>Any Cuisine</option>
<option value="Indian" <%="Indian".equals(selectedCuisine)?"selected":""%>>Indian</option>
<option value="Italian" <%="Italian".equals(selectedCuisine)?"selected":""%>>Italian</option>
<option value="Chinese" <%="Chinese".equals(selectedCuisine)?"selected":""%>>Chinese</option>
<option value="Mexican" <%="Mexican".equals(selectedCuisine)?"selected":""%>>Mexican</option>
<option value="Thai" <%="Thai".equals(selectedCuisine)?"selected":""%>>Thai</option>
<option value="Mediterranean" <%="Mediterranean".equals(selectedCuisine)?"selected":""%>>Mediterranean</option>
<option value="Continental" <%="Continental".equals(selectedCuisine)?"selected":""%>>Continental</option>
</select>
<i class="fa-solid fa-chevron-down select-arrow"></i>
</div>
</div>

<div class="ai-form-group">
<label for="difficulty">Difficulty Level</label>
<div class="ai-select-box">
<i class="fa-solid fa-signal"></i>
<select id="difficulty" name="difficulty">
<option value="Easy" <%="Easy".equals(selectedDifficulty)?"selected":""%>>Easy</option>
<option value="Medium" <%="Medium".equals(selectedDifficulty)?"selected":""%>>Medium</option>
<option value="Hard" <%="Hard".equals(selectedDifficulty)?"selected":""%>>Hard</option>
</select>
<i class="fa-solid fa-chevron-down select-arrow"></i>
</div>
</div>

<div class="ai-form-group full-width">
<label for="dietaryPreference">Dietary Preference</label>
<div class="ai-select-box">
<i class="fa-solid fa-leaf"></i>
<select id="dietaryPreference" name="dietaryPreference">
<option value="None" <%="None".equals(selectedDietaryPreference)?"selected":""%>>No Preference</option>
<option value="Vegetarian" <%="Vegetarian".equals(selectedDietaryPreference)?"selected":""%>>Vegetarian</option>
<option value="Vegan" <%="Vegan".equals(selectedDietaryPreference)?"selected":""%>>Vegan</option>
<option value="Gluten-Free" <%="Gluten-Free".equals(selectedDietaryPreference)?"selected":""%>>Gluten-Free</option>
<option value="High-Protein" <%="High-Protein".equals(selectedDietaryPreference)?"selected":""%>>High Protein</option>
<option value="Low-Calorie" <%="Low-Calorie".equals(selectedDietaryPreference)?"selected":""%>>Low Calorie</option>
</select>
<i class="fa-solid fa-chevron-down select-arrow"></i>
</div>
</div>

</div>

<button type="submit" class="ai-generate-btn" id="generateRecipeButton">
<span class="generate-button-content">
<i class="fa-solid fa-wand-magic-sparkles"></i>
Generate My Recipe
</span>
<span class="generate-loading-content">
<i class="fa-solid fa-spinner fa-spin"></i>
Creating Your Recipe...
</span>
</button>

</form>

</section>

<section class="ai-tips-card">
<div class="ai-tips-icon">
<i class="fa-solid fa-lightbulb"></i>
</div>
<div>
<h3>Get Better AI Results</h3>
<p>Be specific about your available ingredients and choose preferences that match the kind of meal you want to prepare.</p>
</div>
</section>

</div>

<div class="ai-generator-result-column">

<%
if(generatedRecipe==null){
%>

<section class="ai-empty-result">

<div class="ai-empty-visual">
<div class="ai-empty-circle">
<i class="fa-solid fa-wand-magic-sparkles"></i>
</div>
</div>

<h2>Your AI Recipe Will Appear Here</h2>

<p>Enter your ingredients and preferences, then click Generate My Recipe to create a personalized cooking idea.</p>

<div class="ai-empty-features">

<div>
<i class="fa-solid fa-utensils"></i>
<span>Personalized Recipe</span>
</div>

<div>
<i class="fa-regular fa-clock"></i>
<span>Cooking Time</span>
</div>

<div>
<i class="fa-solid fa-fire-flame-curved"></i>
<span>Calories</span>
</div>

</div>

</section>

<%
}else{
%>

<section class="ai-result-card">

<div class="ai-result-header">

<div>

<span class="ai-generated-badge">
<i class="fa-solid fa-wand-magic-sparkles"></i>
AI Generated Recipe
</span>

<h1><%=generatedRecipe.getRecipeName()%></h1>

<p><%=generatedRecipe.getDescription()%></p>

</div>

</div>

<div class="ai-result-meta">

<div>
<i class="fa-solid fa-earth-americas"></i>
<span>Cuisine</span>
<strong><%=generatedRecipe.getCuisine()%></strong>
</div>

<div>
<i class="fa-solid fa-signal"></i>
<span>Difficulty</span>
<strong><%=generatedRecipe.getDifficulty()%></strong>
</div>

<div>
<i class="fa-regular fa-clock"></i>
<span>Cooking Time</span>
<strong><%=generatedRecipe.getCookingTime()%> min</strong>
</div>

<div>
<i class="fa-solid fa-fire-flame-curved"></i>
<span>Calories</span>
<strong><%=generatedRecipe.getCalories()%> kcal</strong>
</div>

</div>
<section class="ai-result-section">

<div class="ai-result-section-header">
<div class="ai-result-section-icon">
<i class="fa-solid fa-basket-shopping"></i>
</div>
<div>
<h2>Ingredients</h2>
<p>Everything you need to prepare this recipe</p>
</div>
</div>

<div class="ai-ingredients-list">

<%
List<AIIngredient> aiIngredients=generatedRecipe.getIngredients();
if(aiIngredients!=null&&!aiIngredients.isEmpty()){
int ingredientNumber=1;
for(AIIngredient ingredient:aiIngredients){
%>

<div class="ai-ingredient-item">
<div class="ai-ingredient-number"><%=ingredientNumber++%></div>
<span>
<strong><%=ingredient.getIngredientName()%></strong>
<%
if(ingredient.getQuantity()!=null&&!ingredient.getQuantity().trim().isEmpty()){
%>
<%=ingredient.getQuantity()%>
<%
}
if(ingredient.getUnit()!=null&&!ingredient.getUnit().trim().isEmpty()){
%>
<%=ingredient.getUnit()%>
<%
}
%>
</span>
</div>

<%
}
}else{
%>

<div class="ai-result-empty-message">
No ingredients were generated.
</div>

<%
}
%>

</div>

</section>

<section class="ai-result-section">

<div class="ai-result-section-header">
<div class="ai-result-section-icon">
<i class="fa-solid fa-list-ol"></i>
</div>
<div>
<h2>Cooking Instructions</h2>
<p>Follow these AI-generated steps to prepare your recipe</p>
</div>
</div>

<div class="ai-instructions-list">

<%
List<String> aiInstructions=generatedRecipe.getInstructions();
if(aiInstructions!=null&&!aiInstructions.isEmpty()){
int stepNumber=1;
for(String instruction:aiInstructions){
%>

<div class="ai-instruction-item">

<div class="ai-instruction-number">
<%=stepNumber%>
</div>

<div>
<h3>Step <%=stepNumber++%></h3>
<p><%=instruction%></p>
</div>

</div>

<%
}
}else{
%>

<div class="ai-result-empty-message">
No cooking instructions were generated.
</div>

<%
}
%>

</div>

</section>

<div class="ai-result-actions">

<button type="button" class="ai-regenerate-btn" id="regenerateRecipeButton">
<i class="fa-solid fa-rotate"></i>
Generate Another
</button>

<form action="<%=request.getContextPath()%>/saveAIRecipe" method="post">
<button type="submit" class="ai-save-recipe-btn">
<i class="fa-solid fa-bookmark"></i>
Save to My Recipes
</button>
</form>

</div>

</section>

<%
}
%>

</div>

</section>

</main>

</div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>

<script>
document.addEventListener("DOMContentLoaded",function(){

const form=document.getElementById("aiGeneratorForm");
const generateButton=document.getElementById("generateRecipeButton");
const ingredients=document.getElementById("ingredients");
const ingredientCharacterCount=document.getElementById("ingredientCharacterCount");
const regenerateButton=document.getElementById("regenerateRecipeButton");

if(ingredients&&ingredientCharacterCount){
ingredients.addEventListener("input",function(){
ingredientCharacterCount.textContent=ingredients.value.length+"/500";
});
}

if(form&&generateButton){
form.addEventListener("submit",function(){
generateButton.classList.add("loading");
generateButton.disabled=true;
});
}

if(regenerateButton&&form){
regenerateButton.addEventListener("click",function(){
ingredients.focus();
ingredients.scrollIntoView({
behavior:"smooth",
block:"center"
});
});
}

});
</script>

</body>
</html>
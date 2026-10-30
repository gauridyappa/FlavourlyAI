<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.RecipeStep"%>
<%@page import="com.flavourly.model.Ingredient"%>
<%@page import="com.flavourly.model.Recipe"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect("../login.jsp");
return;
}
Recipe recipe=(Recipe)request.getAttribute("recipe");
List<Ingredient> ingredients=(List<Ingredient>)request.getAttribute("ingredients");
List<RecipeStep> recipeSteps=(List<RecipeStep>)request.getAttribute("recipeSteps");
if(recipe==null){
response.sendRedirect("../my-recipes");
return;
}
String imageName=recipe.getRecipeImage();
boolean hasImage=imageName!=null&&!imageName.trim().isEmpty()&&!"default-recipe.jpg".equals(imageName);
boolean isOwner=recipe.getCreatedBy()==loggedUser.getUserId();
boolean isFavorite=Boolean.TRUE.equals(request.getAttribute("isFavorite"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title><%=recipe.getRecipeName()%> | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/recipe-details.css">
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
<li><a href="<%=request.getContextPath()%>/dashboard"><i class="fa-solid fa-house"></i><span>Dashboard</span></a></li>
<li class="active"><a href="<%=request.getContextPath()%>/my-recipes"><i class="fa-solid fa-book-open"></i><span>My Recipes</span></a></li>
<li><a href="<%=request.getContextPath()%>/add-recipe"><i class="fa-solid fa-square-plus"></i><span>Add Recipe</span></a></li>
<li><a href="<%=request.getContextPath()%>/favorites"><i class="fa-solid fa-heart"></i><span>Favorites</span></a></li>
<li><a href="<%=request.getContextPath()%>/aiGenerator"><i class="fa-solid fa-wand-magic-sparkles"></i><span>AI Generator</span></a></li>
<li><a href="<%=request.getContextPath()%>/nutrition"><i class="fa-solid fa-chart-pie"></i><span>Nutrition</span></a></li>
<li><a href="<%=request.getContextPath()%>/reviews"><i class="fa-solid fa-star"></i><span>Reviews</span></a></li>
<li><a href="<%=request.getContextPath()%>/profile"><i class="fa-solid fa-user"></i><span>Profile</span></a></li>
<li><a href="<%=request.getContextPath()%>/settings"><i class="fa-solid fa-gear"></i><span>Settings</span></a></li>
<li><a href="<%=request.getContextPath()%>/logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
</ul>
</aside>
<div class="main-content">
<header class="topbar">
<div class="left-top">
<button type="button" class="menu-btn"><i class="fa-solid fa-bars"></i></button>
<div class="page-title">
<h2>Recipe Details</h2>
<p>View complete recipe information</p>
</div>
</div>
<div class="right-top">
<button type="button" class="icon-btn"><i class="fa-regular fa-bell"></i></button>
<div class="user-box">
<div class="avatar"><i class="fa-solid fa-user"></i></div>
<div>
<h4><%=loggedUser.getFullName()%></h4>
<p><%=loggedUser.getRole()%></p>
</div>
</div>
</div>
</header>
<main class="dashboard-content">
<%
String success=request.getParameter("success");
if("updated".equals(success)){
%>
<div class="details-alert success"><i class="fa-solid fa-circle-check"></i>Recipe updated successfully.</div>
<%
}
%>
<section class="details-navigation">
<a href="<%=request.getContextPath()%>/my-recipes" class="details-back-btn"><i class="fa-solid fa-arrow-left"></i>Back to My Recipes</a>
<div class="details-actions">
<form action="<%=request.getContextPath()%>/favorite" method="post">
<input type="hidden" name="recipeId" value="<%=recipe.getRecipeId()%>">
<input type="hidden" name="action" value="<%=isFavorite?"remove":"add"%>">
<input type="hidden" name="redirect" value="details">
<button type="submit" class="details-favorite-btn <%=isFavorite?"active":""%>">
<i class="<%=isFavorite?"fa-solid":"fa-regular"%> fa-heart"></i>
<%=isFavorite?"Remove from Favorites":"Add to Favorites"%>
</button>
</form>
<%
if(isOwner){
%>
<div class="details-actions">
<a href="<%=request.getContextPath()%>/edit-recipe?id=<%=recipe.getRecipeId()%>" class="details-edit-btn"><i class="fa-solid fa-pen"></i>Edit Recipe</a>
<form action="<%=request.getContextPath()%>/delete-recipe" method="post" class="delete-recipe-form"><input type="hidden" name="id" value="<%=recipe.getRecipeId()%>">
<button type="submit" class="details-delete-btn"><i class="fa-solid fa-trash"></i>Delete</button>
</form>
<%
}
%>
</div>
</section>
<section class="recipe-hero-card">
<div class="recipe-hero-image">
<%
if(hasImage){
%>
<img src="<%=request.getContextPath()%>/recipe-image/<%=imageName%>" alt="<%=recipe.getRecipeName()%>">
<%
}else{
%>
<div class="details-image-placeholder"><i class="fa-solid fa-utensils"></i></div>
<%
}
%>
</div>
<div class="recipe-hero-content">
<div class="recipe-hero-badges">
<span class="category-badge"><i class="fa-solid fa-layer-group"></i><%=recipe.getCategoryName()%></span>
<span class="difficulty-badge <%=recipe.getDifficulty().toLowerCase()%>"><%=recipe.getDifficulty()%></span>
</div>
<h1><%=recipe.getRecipeName()%></h1>
<p class="recipe-hero-description"><%=recipe.getDescription()%></p>
<div class="recipe-hero-author">
<div class="author-avatar"><i class="fa-solid fa-user"></i></div>
<div>
<span>Created By</span>
<h4><%=recipe.getCreatorName()%></h4>
</div>
</div>
<div class="recipe-info-grid">
<div class="recipe-info-box">
<i class="fa-solid fa-earth-americas"></i>
<div><span>Cuisine</span><strong><%=recipe.getCuisine()%></strong></div>
</div>
<div class="recipe-info-box">
<i class="fa-regular fa-clock"></i>
<div><span>Cooking Time</span><strong><%=recipe.getCookingTime()%> Minutes</strong></div>
</div>
<div class="recipe-info-box">
<i class="fa-solid fa-fire-flame-curved"></i>
<div><span>Calories</span><strong><%=recipe.getCalories()%> kcal</strong></div>
</div>
</div>
</div>
</section>
<!-- CONTINUE PART 2 -->
<section class="recipe-details-grid">
<div class="details-main-column">
<section class="details-card">
<div class="details-card-header">
<div class="details-card-icon"><i class="fa-solid fa-basket-shopping"></i></div>
<div>
<h2>Ingredients</h2>
<p>Everything you need to prepare this recipe.</p>
</div>
</div>
<div class="ingredients-list">
<%
if(ingredients!=null&&!ingredients.isEmpty()){
int ingredientNumber=1;
for(Ingredient ingredient:ingredients){
%>
<div class="ingredient-item">
<div class="ingredient-number"><%=ingredientNumber++%></div>
<div class="ingredient-name"><%=ingredient.getIngredientName()%></div>
<div class="ingredient-quantity">
<span><%=ingredient.getQuantity()!=null?ingredient.getQuantity():""%></span>
<span><%=ingredient.getUnit()!=null?ingredient.getUnit():""%></span>
</div>
</div>
<%
}
}else{
%>
<div class="details-empty-message">No ingredients available for this recipe.</div>
<%
}
%>
</div>
</section>
<section class="details-card">
<div class="details-card-header">
<div class="details-card-icon"><i class="fa-solid fa-list-ol"></i></div>
<div>
<h2>Cooking Instructions</h2>
<p>Follow these steps to prepare the recipe.</p>
</div>
</div>
<div class="instructions-list">
<%
if(recipeSteps!=null&&!recipeSteps.isEmpty()){
for(RecipeStep recipeStep:recipeSteps){
%>
<div class="instruction-item">
<div class="instruction-number"><%=recipeStep.getStepNumber()%></div>
<div class="instruction-content">
<h3>Step <%=recipeStep.getStepNumber()%></h3>
<p><%=recipeStep.getInstruction()%></p>
</div>
</div>
<%
}
}else{
%>
<div class="details-empty-message">No cooking instructions available for this recipe.</div>
<%
}
%>
</div>
</section>
</div>
<div class="details-sidebar-column">
<section class="details-card recipe-summary-card">
<div class="summary-main-icon"><i class="fa-solid fa-utensils"></i></div>
<h2>Recipe Summary</h2>
<div class="summary-details-list">
<div>
<span><i class="fa-solid fa-layer-group"></i>Category</span>
<strong><%=recipe.getCategoryName()%></strong>
</div>
<div>
<span><i class="fa-solid fa-earth-americas"></i>Cuisine</span>
<strong><%=recipe.getCuisine()%></strong>
</div>
<div>
<span><i class="fa-solid fa-signal"></i>Difficulty</span>
<strong><%=recipe.getDifficulty()%></strong>
</div>
<div>
<span><i class="fa-regular fa-clock"></i>Cooking Time</span>
<strong><%=recipe.getCookingTime()%> min</strong>
</div>
<div>
<span><i class="fa-solid fa-fire-flame-curved"></i>Calories</span>
<strong><%=recipe.getCalories()%> kcal</strong>
</div>
</div>
</section>
<section class="details-card created-info-card">
<div class="created-info-icon"><i class="fa-regular fa-calendar"></i></div>
<div>
<h3>Recipe Created</h3>
<p><%=recipe.getCreatedAt()%></p>
</div>
</section>
<section class="details-card details-tip-card">
<div class="details-tip-icon"><i class="fa-solid fa-lightbulb"></i></div>
<div>
<h3>Cooking Tip</h3>
<p>Prepare and measure all ingredients before you begin cooking for a smoother experience.</p>
</div>
</section>
</div>
</section>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/recipes.js"></script>
</body>
</html>
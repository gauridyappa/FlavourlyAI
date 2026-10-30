<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.Recipe"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect("../login.jsp");
return;
}
List<Recipe> recipes=(List<Recipe>)request.getAttribute("recipes");
Integer recipeCount=(Integer)request.getAttribute("recipeCount");
String defaultRecipeView=(String)request.getAttribute("defaultRecipeView");
if(defaultRecipeView==null)defaultRecipeView="GRID";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>My Recipes | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/recipes.css">
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
<a href="<%=request.getContextPath()%>/dashboard"><i class="fa-solid fa-house"></i><span>Dashboard</span></a>
</li>
<li class="active">
<a href="<%=request.getContextPath()%>/my-recipes"><i class="fa-solid fa-book-open"></i><span>My Recipes</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/add-recipe"><i class="fa-solid fa-square-plus"></i><span>Add Recipe</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/favorites"><i class="fa-solid fa-heart"></i><span>Favorites</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/aiGenerator"><i class="fa-solid fa-wand-magic-sparkles"></i><span>AI Generator</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/nutrition"><i class="fa-solid fa-chart-pie"></i><span>Nutrition</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/reviews"><i class="fa-solid fa-star"></i><span>Reviews</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/profile"><i class="fa-solid fa-user"></i><span>Profile</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/settings"><i class="fa-solid fa-gear"></i><span>Settings</span></a>
</li>
<li>
<a href="<%=request.getContextPath()%>/logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a>
</li>
</ul>
</aside>
<div class="main-content">
<header class="topbar">
<div class="left-top">
<button type="button" class="menu-btn"><i class="fa-solid fa-bars"></i></button>
<div class="page-title">
<h2>My Recipes</h2>
<p>Manage your personal recipe collection</p>
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
<section class="recipes-page-header">
<div>
<span class="recipes-header-badge"><i class="fa-solid fa-book-open"></i>My Cookbook</span>
<h1>Your Recipe Collection</h1>
<p>Create, manage and organize all your delicious recipes in one place.</p>
</div>
<a href="<%=request.getContextPath()%>/add-recipe" class="add-recipe-btn"><i class="fa-solid fa-plus"></i>Add New Recipe</a>
</section>
<%
String success=request.getParameter("success");
String error=request.getParameter("error");
if("added".equals(success)){
%>
<div class="recipes-alert success"><i class="fa-solid fa-circle-check"></i>Recipe published successfully.</div>
<%
}else if("deleted".equals(success)){
%>
<div class="recipes-alert success"><i class="fa-solid fa-circle-check"></i>Recipe deleted successfully.</div>
<%
}
if("unauthorized".equals(error)){
%>
<div class="recipes-alert error"><i class="fa-solid fa-circle-exclamation"></i>You are not authorized to manage that recipe.</div>
<%
}else if(error!=null){
%>
<div class="recipes-alert error"><i class="fa-solid fa-circle-exclamation"></i>Something went wrong. Please try again.</div>
<%
}
%>
<section class="recipes-toolbar">
<div class="recipes-summary">
<div class="summary-icon"><i class="fa-solid fa-book-open"></i></div>
<div>
<h3><%=recipeCount!=null?recipeCount:0%></h3>
<p>Total Recipes</p>
</div>
</div>
<div class="recipes-controls">
<div class="recipes-search">
<i class="fa-solid fa-magnifying-glass"></i>
<input type="text" id="recipeSearch" placeholder="Search your recipes...">
</div>
<select id="difficultyFilter" class="recipes-filter">
<option value="all">All Difficulties</option>
<option value="easy">Easy</option>
<option value="medium">Medium</option>
<option value="hard">Hard</option>
</select>
</div>
</section>
<!-- CONTINUE PART 2 -->
<%
if(recipes==null||recipes.isEmpty()){
%>
<section class="recipes-empty-state" id="recipesEmptyState">
<div class="empty-state-icon"><i class="fa-solid fa-bowl-food"></i></div>
<h2>No Recipes Yet</h2>
<p>Your personal cookbook is waiting for its first delicious recipe.</p>
<a href="<%=request.getContextPath()%>/add-recipe" class="add-recipe-btn"><i class="fa-solid fa-plus"></i>Create Your First Recipe</a>
</section>
<%
}else{
%>
<section class="recipes-grid <%="LIST".equals(defaultRecipeView)?"list-view":""%>" id="recipesGrid">
<%
for(Recipe recipe:recipes){
String imageName=recipe.getRecipeImage();
boolean hasImage=imageName!=null&&!imageName.trim().isEmpty()&&!"default-recipe.jpg".equals(imageName);
%>
<article class="recipe-card" data-name="<%=recipe.getRecipeName().toLowerCase()%>" data-difficulty="<%=recipe.getDifficulty().toLowerCase()%>">
<div class="recipe-card-image">
<%
if(hasImage){
%>
<%
String recipeImage=recipe.getRecipeImage();
boolean hasRecipeImage=recipeImage!=null&&!recipeImage.trim().isEmpty()&&!"default-recipe.jpg".equals(recipeImage);
if(hasRecipeImage){
%>
<img src="<%=request.getContextPath()%>/recipe-image/<%=recipeImage%>" alt="<%=recipe.getRecipeName()%>">
<%
}else{
%>
<div class="recipe-image-placeholder">
<i class="fa-solid fa-utensils"></i>
</div>
<%
}
%>
<%
}else{
%>
<div class="recipe-image-placeholder"><i class="fa-solid fa-utensils"></i></div>
<%
}
%>
<div class="recipe-category-badge"><%=recipe.getCategoryName()%></div>
<div class="recipe-card-actions">
<a href="<%=request.getContextPath()%>/edit-recipe?id=<%=recipe.getRecipeId()%>" class="recipe-action-btn edit" title="Edit recipe"><i class="fa-solid fa-pen"></i></a>
<form action="<%=request.getContextPath()%>/delete-recipe" method="post" class="delete-recipe-form"><input type="hidden" name="id" value="<%=recipe.getRecipeId()%>">
<button type="submit" class="recipe-action-btn delete" title="Delete recipe"><i class="fa-solid fa-trash"></i></button>
</form>
</div>
</div>
<div class="recipe-card-content">
<div class="recipe-card-meta">
<span><i class="fa-solid fa-earth-americas"></i><%=recipe.getCuisine()%></span>
<span class="difficulty <%=recipe.getDifficulty().toLowerCase()%>"><%=recipe.getDifficulty()%></span>
</div>
<h2><%=recipe.getRecipeName()%></h2>
<p class="recipe-description"><%=recipe.getDescription()%></p>
<div class="recipe-card-stats">
<div><i class="fa-regular fa-clock"></i><span><%=recipe.getCookingTime()%> min</span></div>
<div><i class="fa-solid fa-fire-flame-curved"></i><span><%=recipe.getCalories()%> kcal</span></div>
</div>
<div class="recipe-card-footer">
<span class="recipe-date"><i class="fa-regular fa-calendar"></i><%=recipe.getCreatedAt()%></span>
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="view-recipe-btn">View Recipe<i class="fa-solid fa-arrow-right"></i></a></div>
</div>
</article>
<%
}
%>
</section>
<section class="recipes-no-results" id="recipesNoResults">
<div><i class="fa-solid fa-magnifying-glass"></i></div>
<h2>No Matching Recipes</h2>
<p>Try another search term or difficulty filter.</p>
</section>
<%
}
%>
<!-- CONTINUE PART 3 -->
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/recipes.js"></script>
</body>
</html>
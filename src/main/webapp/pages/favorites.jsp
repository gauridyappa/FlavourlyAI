<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.Recipe"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
List<Recipe> favoriteRecipes=(List<Recipe>)request.getAttribute("favoriteRecipes");
Integer favoriteCount=(Integer)request.getAttribute("favoriteCount");
if(favoriteCount==null){
favoriteCount=0;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Favorites | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/favorites.css">
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
<li><a href="<%=request.getContextPath()%>/my-recipes"><i class="fa-solid fa-book-open"></i><span>My Recipes</span></a></li>
<li><a href="<%=request.getContextPath()%>/add-recipe"><i class="fa-solid fa-square-plus"></i><span>Add Recipe</span></a></li>
<li class="active"><a href="<%=request.getContextPath()%>/favorites"><i class="fa-solid fa-heart"></i><span>Favorites</span></a></li>
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
<h2>Favorites</h2>
<p>Your personally saved recipe collection</p>
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
<section class="favorites-hero">
<div class="favorites-hero-content">
<div class="favorites-hero-icon"><i class="fa-solid fa-heart"></i></div>
<div>
<span class="favorites-badge">Personal Cookbook</span>
<h1>Your Favorite Recipes</h1>
<p>Keep all the recipes you love in one beautiful collection and access them whenever inspiration strikes.</p>
</div>
</div>
<div class="favorites-count-card">
<span>Saved Recipes</span>
<strong><%=favoriteCount%></strong>
<p><i class="fa-solid fa-heart"></i>Your Collection</p>
</div>
</section>
<section class="favorites-toolbar">
<div class="favorites-search">
<i class="fa-solid fa-magnifying-glass"></i>
<input type="text" id="favoriteSearch" placeholder="Search your favorite recipes...">
</div>
<div class="favorites-total">
<i class="fa-solid fa-bookmark"></i>
<span><%=favoriteCount%> Saved Recipe<%=favoriteCount==1?"":"s"%></span>
</div>
</section>
<%
if(favoriteRecipes!=null&&!favoriteRecipes.isEmpty()){
%>
<section class="favorites-grid" id="favoritesGrid">
<%
for(Recipe recipe:favoriteRecipes){
String imageName=recipe.getRecipeImage();
boolean hasImage=imageName!=null&&!imageName.trim().isEmpty()&&!"default-recipe.jpg".equals(imageName);
%>
<article class="favorite-card" data-name="<%=recipe.getRecipeName().toLowerCase()%>" data-category="<%=recipe.getCategoryName()!=null?recipe.getCategoryName().toLowerCase():""%>">
<div class="favorite-image">
<%
if(hasImage){
%>
<img src="<%=request.getContextPath()%>/recipe-image/<%=imageName%>" alt="<%=recipe.getRecipeName()%>">
<%
}else{
%>
<div class="favorite-image-placeholder"><i class="fa-solid fa-utensils"></i></div>
<%
}
%>
<form action="<%=request.getContextPath()%>/favorite" method="post" class="favorite-remove-form">
<input type="hidden" name="recipeId" value="<%=recipe.getRecipeId()%>">
<input type="hidden" name="action" value="remove">
<input type="hidden" name="redirect" value="favorites">
<button type="submit" class="favorite-heart-btn" title="Remove from favorites"><i class="fa-solid fa-heart"></i></button>
</form>
<span class="favorite-difficulty <%=recipe.getDifficulty().toLowerCase()%>"><%=recipe.getDifficulty()%></span>
</div>
<div class="favorite-card-content">
<div class="favorite-category"><i class="fa-solid fa-layer-group"></i><%=recipe.getCategoryName()%></div>
<h2><%=recipe.getRecipeName()%></h2>
<p class="favorite-description"><%=recipe.getDescription()!=null?recipe.getDescription():"No description available."%></p>
<div class="favorite-meta">
<span><i class="fa-solid fa-earth-americas"></i><%=recipe.getCuisine()%></span>
<span><i class="fa-regular fa-clock"></i><%=recipe.getCookingTime()%> min</span>
<span><i class="fa-solid fa-fire-flame-curved"></i><%=recipe.getCalories()%> kcal</span>
</div>
<div class="favorite-card-footer">
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="favorite-view-btn">View Recipe<i class="fa-solid fa-arrow-right"></i></a>
<span class="favorite-saved-label"><i class="fa-solid fa-heart"></i>Saved</span>
</div>
</div>
</article>
<%
}
%>
</section>
<div class="favorites-no-results" id="favoritesNoResults">
<div class="no-results-icon"><i class="fa-solid fa-magnifying-glass"></i></div>
<h2>No Matching Recipes</h2>
<p>Try searching with a different recipe name or category.</p>
</div>
<%
}else{
%>
<section class="favorites-empty">
<div class="favorites-empty-visual">
<div class="empty-heart-circle"><i class="fa-regular fa-heart"></i></div>
<div class="empty-decoration decoration-one"><i class="fa-solid fa-utensils"></i></div>
<div class="empty-decoration decoration-two"><i class="fa-solid fa-star"></i></div>
</div>
<h1>Your Favorites Collection is Empty</h1>
<p>Explore your recipes and save the ones you love. They will appear here for quick and easy access.</p>
<a href="<%=request.getContextPath()%>/my-recipes" class="explore-recipes-btn"><i class="fa-solid fa-book-open"></i>Explore My Recipes</a>
</section>
<%
}
%>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/favorites.js"></script>
</body>
</html>
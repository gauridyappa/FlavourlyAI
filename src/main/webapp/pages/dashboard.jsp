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
Integer totalRecipes=(Integer)request.getAttribute("totalRecipes");
Integer favoriteCount=(Integer)request.getAttribute("favoriteCount");
Integer categoryCount=(Integer)request.getAttribute("categoryCount");
List<Recipe> recentRecipes=(List<Recipe>)request.getAttribute("recentRecipes");
if(totalRecipes==null)totalRecipes=0;
if(favoriteCount==null)favoriteCount=0;
if(categoryCount==null)categoryCount=0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Dashboard | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive-dashboard.css">
</head>
<body>
<div class="dashboard">
<aside class="sidebar">
<div class="sidebar-logo">
<a href="<%=request.getContextPath()%>/index.jsp" class="logo">
<div class="logo-icon">
<i class="fa-solid fa-utensils"></i>
</div>
<span>Flavourly</span>
</a>
</div>
<ul class="sidebar-menu">
<li class="active">
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
<li>
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
<div class="search-box">
<i class="fa-solid fa-magnifying-glass"></i>
<input type="text" placeholder="Search recipes...">
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
<section class="hero-banner">
<div class="hero-left">
<span class="badge">
<i class="fa-solid fa-fire"></i>
Welcome Back
</span>
<h1>Hello, <%=loggedUser.getFullName()%> 👋</h1>
<p>Manage recipes, generate meals with AI, analyse nutrition and organize your digital cookbook from one beautiful dashboard.</p>
<div class="hero-buttons">
<a href="<%=request.getContextPath()%>/add-recipe" class="btn btn-primary">
<i class="fa-solid fa-plus"></i>
Add Recipe
</a>
<a href="<%=request.getContextPath()%>/pages/aiGenerator.jsp" class="btn btn-outline">
<i class="fa-solid fa-wand-magic-sparkles"></i>
AI Generator
</a>
</div>
</div>
<div class="hero-right">
<div class="hero-circle">
<i class="fa-solid fa-utensils"></i>
</div>
</div>
</section>
<section class="stats-grid">
<div class="stat-card">
<div class="stat-top">
<div class="stat-icon yellow"><i class="fa-solid fa-book-open"></i></div>
<div class="stat-menu"><i class="fa-solid fa-ellipsis"></i></div>
</div>
<h2><%=totalRecipes%></h2>
<p>Total Recipes</p>
<span class="growth positive"><i class="fa-solid fa-database"></i>Your Recipe Collection</span>
</div>

<div class="stat-card">
<div class="stat-top">
<div class="stat-icon red"><i class="fa-solid fa-heart"></i></div>
<div class="stat-menu"><i class="fa-solid fa-ellipsis"></i></div>
</div>
<h2><%=favoriteCount%></h2>
<p>Favorites</p>
<span class="growth positive"><i class="fa-solid fa-heart"></i>Saved Recipes</span>
</div>

<div class="stat-card">
<div class="stat-top">
<div class="stat-icon blue"><i class="fa-solid fa-layer-group"></i></div>
<div class="stat-menu"><i class="fa-solid fa-ellipsis"></i></div>
</div>
<h2><%=categoryCount%></h2>
<p>Categories</p>
<span class="growth positive"><i class="fa-solid fa-list"></i>Available Categories</span>
</div>

<div class="stat-card">
<div class="stat-top">
<div class="stat-icon green"><i class="fa-solid fa-star"></i></div>
<div class="stat-menu"><i class="fa-solid fa-ellipsis"></i></div>
</div>
<h2>--</h2>
<p>Average Rating</p>
<span class="growth positive"><i class="fa-solid fa-clock"></i>Coming Soon</span>
</div>
</section>

<section class="dashboard-grid">

<div class="recent-card">

<div class="card-header">
<h2>Recent Recipes</h2>
<a href="<%=request.getContextPath()%>/my-recipes">View All</a>
</div>

<%
if(recentRecipes!=null&&!recentRecipes.isEmpty()){
for(Recipe recipe:recentRecipes){
%>

<a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="recipe-item">

<div class="recipe-icon">
<%
String imageName=recipe.getRecipeImage();
boolean hasImage=imageName!=null&&!imageName.trim().isEmpty()&&!"default-recipe.jpg".equals(imageName);
if(hasImage){
%>
<img src="<%=request.getContextPath()%>/recipe-image/<%=imageName%>" alt="<%=recipe.getRecipeName()%>">
<%
}else{
%>
<i class="fa-solid fa-utensils"></i>
<%
}
%>
</div>

<div class="recipe-info">
<h3><%=recipe.getRecipeName()%></h3>
<p><%=recipe.getCuisine()%> • <%=recipe.getCookingTime()%> Minutes</p>
</div>

<div class="recipe-score">
<i class="fa-solid fa-arrow-right"></i>
</div>

</a>

<%
}
}else{
%>

<div class="dashboard-empty-recipes">
<div class="dashboard-empty-icon">
<i class="fa-solid fa-utensils"></i>
</div>
<h3>No Recipes Yet</h3>
<p>Add your first recipe to start building your digital cookbook.</p>
<a href="<%=request.getContextPath()%>/add-recipe" class="btn btn-primary">
<i class="fa-solid fa-plus"></i>
Add Recipe
</a>
</div>

<%
}
%>

</div>

<div class="assistant-card">

<div class="assistant-top">

<div>
<h2>AI Recipe Assistant</h2>
<p>Create recipes using ingredients you already have.</p>
</div>

<div class="assistant-icon">
<i class="fa-solid fa-wand-magic-sparkles"></i>
</div>

</div>

<div class="ingredient-tags">
<span>Chicken</span>
<span>Rice</span>
<span>Tomato</span>
<span>Paneer</span>
<span>Cheese</span>
<span>Onion</span>
</div>

<a href="<%=request.getContextPath()%>/pages/aiGenerator.jsp" class="btn btn-primary">
Generate Recipe
</a>

</div>

</section>
<section class="dashboard-grid">

<div class="quick-card">

<div class="card-header">
<h2>Quick Actions</h2>
</div>

<div class="quick-grid">

<a href="<%=request.getContextPath()%>/add-recipe" class="action-box">
<i class="fa-solid fa-plus"></i>
<span>Add Recipe</span>
</a>

<a href="<%=request.getContextPath()%>/my-recipes" class="action-box">
<i class="fa-solid fa-book-open"></i>
<span>My Recipes</span>
</a>

<a href="<%=request.getContextPath()%>/favorites" class="action-box">
<i class="fa-solid fa-heart"></i>
<span>Favorites</span>
</a>

<a href="<%=request.getContextPath()%>/pages/nutrition.jsp" class="action-box">
<i class="fa-solid fa-chart-pie"></i>
<span>Nutrition</span>
</a>

<a href="<%=request.getContextPath()%>/pages/profile.jsp" class="action-box">
<i class="fa-solid fa-user"></i>
<span>Profile</span>
</a>

<a href="<%=request.getContextPath()%>/pages/reviews.jsp" class="action-box">
<i class="fa-solid fa-star"></i>
<span>Reviews</span>
</a>

</div>

</div>

<div class="activity-card">

<div class="card-header">
<h2>Recent Activity</h2>
</div>

<div class="timeline">

<%
if(recentRecipes!=null&&!recentRecipes.isEmpty()){
for(Recipe recipe:recentRecipes){
%>

<div class="timeline-item">

<div class="timeline-dot"></div>

<div>
<h4>Recipe Added</h4>
<p><%=recipe.getRecipeName()%> was added to your collection.</p>
<small><%=recipe.getCreatedAt()%></small>
</div>

</div>

<%
}
}else{
%>

<div class="dashboard-empty-activity">
<i class="fa-regular fa-clock"></i>
<h4>No Recent Activity</h4>
<p>Your recipe activity will appear here.</p>
</div>

<%
}
%>

</div>

</div>

</section>

<section class="tips-banner">

<div class="tips-icon">
<i class="fa-solid fa-lightbulb"></i>
</div>

<div class="tips-text">
<h2>Today's Cooking Tip</h2>
<p>Season food gradually while cooking instead of adding everything at the end. It creates a much richer and balanced flavour.</p>
</div>

</section>

</main>

</div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>

</body>
</html>
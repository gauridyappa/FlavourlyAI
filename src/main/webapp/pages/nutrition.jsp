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
List<Recipe> recipes=(List<Recipe>)request.getAttribute("recipes");
List<Recipe> highestProteinRecipes=(List<Recipe>)request.getAttribute("highestProteinRecipes");
List<Recipe> lowestCalorieRecipes=(List<Recipe>)request.getAttribute("lowestCalorieRecipes");
Integer totalRecipes=(Integer)request.getAttribute("totalRecipes");
Double averageCalories=(Double)request.getAttribute("averageCalories");
Double averageProtein=(Double)request.getAttribute("averageProtein");
Double averageCarbohydrates=(Double)request.getAttribute("averageCarbohydrates");
Double averageFat=(Double)request.getAttribute("averageFat");
Double averageFiber=(Double)request.getAttribute("averageFiber");
if(recipes==null)recipes=new java.util.ArrayList<>();
if(highestProteinRecipes==null)highestProteinRecipes=new java.util.ArrayList<>();
if(lowestCalorieRecipes==null)lowestCalorieRecipes=new java.util.ArrayList<>();
if(totalRecipes==null)totalRecipes=0;
if(averageCalories==null)averageCalories=0.0;
if(averageProtein==null)averageProtein=0.0;
if(averageCarbohydrates==null)averageCarbohydrates=0.0;
if(averageFat==null)averageFat=0.0;
if(averageFiber==null)averageFiber=0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Nutrition | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/nutrition.css">
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

<li>
<a href="<%=request.getContextPath()%>/aiGenerator">
<i class="fa-solid fa-wand-magic-sparkles"></i>
<span>AI Generator</span>
</a>
</li>

<li class="active">
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
<h2>Nutrition Analytics</h2>
<p>Understand the nutritional profile of your recipe collection</p>
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

<section class="nutrition-hero">

<div class="nutrition-hero-content">

<span class="nutrition-hero-badge">
<i class="fa-solid fa-chart-line"></i>
Personal Nutrition Insights
</span>

<h1>Know What’s Inside Your Recipes</h1>

<p>Explore calories, macronutrients and nutritional trends calculated from your saved Flavourly recipes.</p>

</div>

<div class="nutrition-hero-visual">

<div class="nutrition-hero-circle">
<i class="fa-solid fa-chart-pie"></i>
</div>

</div>

</section>

<section class="nutrition-summary-grid">

<div class="nutrition-summary-card">

<div class="nutrition-summary-top">

<div class="nutrition-summary-icon calories">
<i class="fa-solid fa-fire-flame-curved"></i>
</div>

<span>Average</span>

</div>

<h2><%=String.format("%.0f",averageCalories)%></h2>

<p>Calories per Recipe</p>

</div>

<div class="nutrition-summary-card">

<div class="nutrition-summary-top">

<div class="nutrition-summary-icon protein">
<i class="fa-solid fa-dumbbell"></i>
</div>

<span>Average</span>

</div>

<h2><%=String.format("%.1f",averageProtein)%> g</h2>

<p>Protein per Recipe</p>

</div>

<div class="nutrition-summary-card">

<div class="nutrition-summary-top">

<div class="nutrition-summary-icon carbs">
<i class="fa-solid fa-wheat-awn"></i>
</div>

<span>Average</span>

</div>

<h2><%=String.format("%.1f",averageCarbohydrates)%> g</h2>

<p>Carbohydrates per Recipe</p>

</div>

<div class="nutrition-summary-card">

<div class="nutrition-summary-top">

<div class="nutrition-summary-icon fat">
<i class="fa-solid fa-droplet"></i>
</div>

<span>Average</span>

</div>

<h2><%=String.format("%.1f",averageFat)%> g</h2>

<p>Fat per Recipe</p>

</div>

<div class="nutrition-summary-card">

<div class="nutrition-summary-top">

<div class="nutrition-summary-icon fiber">
<i class="fa-solid fa-seedling"></i>
</div>

<span>Average</span>

</div>

<h2><%=String.format("%.1f",averageFiber)%> g</h2>

<p>Fiber per Recipe</p>

</div>

</section>
<section class="nutrition-content-grid">
<div class="nutrition-overview-card">
<div class="nutrition-card-header">
<div>
<h2>Nutrition Overview</h2>
<p>Average nutritional values across <%=totalRecipes%> saved recipes</p>
</div>
<div class="nutrition-header-icon"><i class="fa-solid fa-chart-simple"></i></div>
</div>
<div class="macro-list">
<div class="macro-item">
<div class="macro-info"><span>Protein</span><strong><%=String.format("%.1f",averageProtein)%> g</strong></div>
<div class="macro-progress"><div class="macro-progress-fill protein-bar" style="width:<%=Math.min(averageProtein,100)%>%"></div></div>
</div>
<div class="macro-item">
<div class="macro-info"><span>Carbohydrates</span><strong><%=String.format("%.1f",averageCarbohydrates)%> g</strong></div>
<div class="macro-progress"><div class="macro-progress-fill carbs-bar" style="width:<%=Math.min(averageCarbohydrates,100)%>%"></div></div>
</div>
<div class="macro-item">
<div class="macro-info"><span>Fat</span><strong><%=String.format("%.1f",averageFat)%> g</strong></div>
<div class="macro-progress"><div class="macro-progress-fill fat-bar" style="width:<%=Math.min(averageFat,100)%>%"></div></div>
</div>
<div class="macro-item">
<div class="macro-info"><span>Fiber</span><strong><%=String.format("%.1f",averageFiber)%> g</strong></div>
<div class="macro-progress"><div class="macro-progress-fill fiber-bar" style="width:<%=Math.min(averageFiber,100)%>%"></div></div>
</div>
</div>
</div>
<div class="nutrition-collection-card">
<div class="nutrition-card-header">
<div>
<h2>Recipe Collection</h2>
<p>Your saved recipe nutrition database</p>
</div>
<div class="nutrition-header-icon"><i class="fa-solid fa-book-open"></i></div>
</div>
<div class="collection-stat">
<div class="collection-circle"><span><%=totalRecipes%></span><small>Recipes</small></div>
<div class="collection-info">
<h3>Your Nutrition Library</h3>
<p>Nutrition analytics are calculated dynamically from all recipes currently saved in your account.</p>
<a href="<%=request.getContextPath()%>/my-recipes">Explore Recipes <i class="fa-solid fa-arrow-right"></i></a>
</div>
</div>
</div>
</section>
<section class="nutrition-ranking-grid">
<div class="nutrition-ranking-card">
<div class="nutrition-card-header">
<div>
<h2>Highest Protein Recipes</h2>
<p>Your top protein-rich meals</p>
</div>
<div class="nutrition-header-icon"><i class="fa-solid fa-dumbbell"></i></div>
</div>
<div class="nutrition-recipe-list">
<%
if(highestProteinRecipes.isEmpty()){
%>
<div class="nutrition-empty-state"><i class="fa-solid fa-bowl-food"></i><p>No recipe nutrition data available yet.</p></div>
<%
}else{
int rank=1;
for(Recipe recipe:highestProteinRecipes){
%>
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="nutrition-recipe-item">
<div class="nutrition-rank"><%=rank++%></div>
<div class="nutrition-recipe-info">
<h3><%=recipe.getRecipeName()%></h3>
<p><%=recipe.getCategoryName()%> • <%=recipe.getCalories()%> kcal</p>
</div>
<div class="nutrition-recipe-value"><strong><%=String.format("%.1f",recipe.getProtein())%> g</strong><span>Protein</span></div>
</a>
<%
}
}
%>
</div>
</div>
<div class="nutrition-ranking-card">
<div class="nutrition-card-header">
<div>
<h2>Lowest Calorie Recipes</h2>
<p>Your lighter recipe choices</p>
</div>
<div class="nutrition-header-icon"><i class="fa-solid fa-fire-flame-curved"></i></div>
</div>
<div class="nutrition-recipe-list">
<%
if(lowestCalorieRecipes.isEmpty()){
%>
<div class="nutrition-empty-state"><i class="fa-solid fa-bowl-food"></i><p>No recipe nutrition data available yet.</p></div>
<%
}else{
int rank=1;
for(Recipe recipe:lowestCalorieRecipes){
%>
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="nutrition-recipe-item">
<div class="nutrition-rank"><%=rank++%></div>
<div class="nutrition-recipe-info">
<h3><%=recipe.getRecipeName()%></h3>
<p><%=recipe.getCategoryName()%> • <%=String.format("%.1f",recipe.getProtein())%> g Protein</p>
</div>
<div class="nutrition-recipe-value"><strong><%=recipe.getCalories()%></strong><span>Calories</span></div>
</a>
<%
}
}
%>
</div>
</div>
</section>
<section class="nutrition-table-card">
<div class="nutrition-card-header">
<div><h2>Complete Nutrition Breakdown</h2><p>Compare nutritional values across all your saved recipes</p></div>
<div class="nutrition-header-icon"><i class="fa-solid fa-table-list"></i></div>
</div>
<%
if(recipes.isEmpty()){
%>
<div class="nutrition-empty-state"><i class="fa-solid fa-chart-pie"></i><p>Add recipes to start viewing your nutrition analytics.</p><a href="<%=request.getContextPath()%>/add-recipe">Add Recipe</a></div>
<%
}else{
%>
<div class="nutrition-table-wrapper">
<table class="nutrition-table">
<thead>
<tr>
<th>Recipe</th>
<th>Category</th>
<th>Calories</th>
<th>Protein</th>
<th>Carbs</th>
<th>Fat</th>
<th>Fiber</th>
<th></th>
</tr>
</thead>
<tbody>
<%
for(Recipe recipe:recipes){
%>
<tr>
<td>
<div class="nutrition-table-recipe">
<div class="nutrition-table-icon"><i class="fa-solid fa-utensils"></i></div>
<div><strong><%=recipe.getRecipeName()%></strong><span><%=recipe.getCuisine()%></span></div>
</div>
</td>
<td><span class="nutrition-category-badge"><%=recipe.getCategoryName()%></span></td>
<td><strong><%=recipe.getCalories()%></strong> kcal</td>
<td><%=String.format("%.1f",recipe.getProtein())%> g</td>
<td><%=String.format("%.1f",recipe.getCarbohydrates())%> g</td>
<td><%=String.format("%.1f",recipe.getFat())%> g</td>
<td><%=String.format("%.1f",recipe.getFiber())%> g</td>
<td><a href="<%=request.getContextPath()%>/recipe-details?id=<%=recipe.getRecipeId()%>" class="nutrition-view-btn"><i class="fa-solid fa-arrow-right"></i></a></td>
</tr>
<%
}
%>
</tbody>
</table>
</div>
<%
}
%>
</section>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
</body>
</html>
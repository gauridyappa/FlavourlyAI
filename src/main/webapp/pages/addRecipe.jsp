<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.Category"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect("../login.jsp");
return;
}
List<Category> categories=(List<Category>)request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Add Recipe | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/recipe-form.css">
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
<li class="active"><a href="<%=request.getContextPath()%>/add-recipe"><i class="fa-solid fa-square-plus"></i><span>Add Recipe</span></a></li>
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
<h2>Add Recipe</h2>
<p>Create and publish a new recipe</p>
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
<section class="recipe-page-header">
<div>
<span class="recipe-header-badge"><i class="fa-solid fa-utensils"></i>Recipe Studio</span>
<h1>Create a New Recipe</h1>
<p>Add the recipe details, ingredients and cooking instructions below.</p>
</div>
<a href="<%=request.getContextPath()%>/my-recipes" class="recipe-back-btn"><i class="fa-solid fa-arrow-left"></i>My Recipes</a>
</section>
<%
String error=request.getParameter("error");
if("missingDetails".equals(error)){
%>
<div class="recipe-alert error"><i class="fa-solid fa-circle-exclamation"></i>Please add at least one ingredient and one cooking step.</div>
<%
}else if("failed".equals(error)||"invalid".equals(error)||"imageUpload".equals(error)){
%>
<div class="recipe-alert error"><i class="fa-solid fa-circle-exclamation"></i>Recipe could not be created. Please try again.</div>
<%
}
%>
<form action="<%=request.getContextPath()%>/add-recipe" method="post" enctype="multipart/form-data" class="recipe-form" id="recipeForm">
<div class="recipe-form-grid">
<div class="recipe-form-main">
<section class="form-card">
<div class="form-card-header">
<div class="form-card-icon"><i class="fa-solid fa-circle-info"></i></div>
<div>
<h2>Basic Information</h2>
<p>Enter the main details about your recipe.</p>
</div>
</div>
<div class="form-fields-grid">
<div class="recipe-input-group full-width">
<label for="recipeName">Recipe Name</label>
<div class="recipe-input-box">
<i class="fa-solid fa-utensils"></i>
<input type="text" id="recipeName" name="recipeName" placeholder="Example: Creamy Paneer Pasta" maxlength="150" required>
</div>
</div>
<div class="recipe-input-group">
<label for="categoryId">Category</label>
<div class="recipe-input-box">
<i class="fa-solid fa-layer-group"></i>
<select id="categoryId" name="categoryId" required>
<option value="">Select category</option>
<%
if(categories!=null){
for(Category category:categories){
%>
<option value="<%=category.getCategoryId()%>"><%=category.getCategoryName()%></option>
<%
}
}
%>
</select>
</div>
</div>
<div class="recipe-input-group">
<label for="cuisine">Cuisine</label>
<div class="recipe-input-box">
<i class="fa-solid fa-earth-americas"></i>
<input type="text" id="cuisine" name="cuisine" placeholder="Example: Indian" maxlength="100" required>
</div>
</div>
<div class="recipe-input-group">
<label for="difficulty">Difficulty</label>
<div class="recipe-input-box">
<i class="fa-solid fa-signal"></i>
<select id="difficulty" name="difficulty" required>
<option value="Easy">Easy</option>
<option value="Medium">Medium</option>
<option value="Hard">Hard</option>
</select>
</div>
</div>
<div class="recipe-input-group">
<label for="cookingTime">Cooking Time</label>
<div class="recipe-input-box">
<i class="fa-regular fa-clock"></i>
<input type="number" id="cookingTime" name="cookingTime" placeholder="Minutes" min="1" required>
</div>
</div>

<div class="recipe-input-group">
<label for="calories">Calories</label>
<div class="recipe-input-box">
<i class="fa-solid fa-fire-flame-curved"></i>
<input type="number" id="calories" name="calories" placeholder="Optional" min="0">
</div>
</div>

<div class="recipe-input-group">
<label for="protein">Protein (g)</label>
<div class="recipe-input-box">
<i class="fa-solid fa-dumbbell"></i>
<input type="number" id="protein" name="protein" placeholder="Optional" min="0" step="0.01">
</div>
</div>

<div class="recipe-input-group">
<label for="carbohydrates">Carbohydrates (g)</label>
<div class="recipe-input-box">
<i class="fa-solid fa-wheat-awn"></i>
<input type="number" id="carbohydrates" name="carbohydrates" placeholder="Optional" min="0" step="0.01">
</div>
</div>

<div class="recipe-input-group">
<label for="fat">Fat (g)</label>
<div class="recipe-input-box">
<i class="fa-solid fa-droplet"></i>
<input type="number" id="fat" name="fat" placeholder="Optional" min="0" step="0.01">
</div>
</div>

<div class="recipe-input-group">
<label for="fiber">Fiber (g)</label>
<div class="recipe-input-box">
<i class="fa-solid fa-seedling"></i>
<input type="number" id="fiber" name="fiber" placeholder="Optional" min="0" step="0.01">
</div>
</div>
<div class="recipe-input-group full-width">
<label for="recipeImage">Recipe Image</label>
<div class="recipe-image-upload" id="recipeImageUpload">
<input type="file" id="recipeImage" name="recipeImage" accept=".jpg,.jpeg,.png,.webp,image/jpeg,image/png,image/webp">
<div class="recipe-image-upload-content" id="recipeImageUploadContent">
<div class="recipe-upload-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
<h3>Upload Recipe Image</h3>
<p>Drag and drop your image here or click to browse</p>
<span>JPG, JPEG, PNG or WEBP • Maximum 5 MB</span>
</div>
<div class="recipe-image-preview" id="recipeImagePreview">
<img id="recipePreviewImage" src="" alt="Recipe preview">
<div class="recipe-preview-overlay">
<button type="button" class="change-image-btn" id="changeImageBtn"><i class="fa-solid fa-camera"></i>Change Image</button>
<button type="button" class="remove-image-btn" id="removeImageBtn"><i class="fa-solid fa-trash"></i>Remove</button>
</div>
</div>
</div>
<div class="recipe-image-error" id="recipeImageError"></div>
</div>
<div class="recipe-input-group full-width">
<label for="description">Description</label>
<textarea id="description" name="description" placeholder="Tell people what makes this recipe special..." maxlength="2000" required></textarea>
</div>
</div>
</section>
<section class="form-card">
<div class="form-card-header form-card-header-action">
<div class="form-card-title">
<div class="form-card-icon"><i class="fa-solid fa-basket-shopping"></i></div>
<div>
<h2>Ingredients</h2>
<p>Add everything needed to prepare this recipe.</p>
</div>
</div>
<button type="button" class="add-field-btn" id="addIngredientBtn"><i class="fa-solid fa-plus"></i>Add Ingredient</button>
</div>
<div class="dynamic-list" id="ingredientsContainer">
<div class="ingredient-row dynamic-row">
<div class="row-number">1</div>
<div class="dynamic-fields ingredient-fields">
<div class="recipe-input-group">
<label>Ingredient</label>
<div class="recipe-input-box">
<i class="fa-solid fa-carrot"></i>
<input type="text" name="ingredientName" placeholder="Example: Paneer" maxlength="150" required>
</div>
</div>
<div class="recipe-input-group">
<label>Quantity</label>
<div class="recipe-input-box">
<i class="fa-solid fa-scale-balanced"></i>
<input type="text" name="quantity" placeholder="Example: 200" maxlength="50">
</div>
</div>
<div class="recipe-input-group">
<label>Unit</label>
<div class="recipe-input-box">
<i class="fa-solid fa-ruler"></i>
<input type="text" name="unit" placeholder="Example: grams" maxlength="30">
</div>
</div>
</div>
<button type="button" class="remove-field-btn remove-ingredient" title="Remove ingredient"><i class="fa-solid fa-trash"></i></button>
</div>
</div>
</section>
<section class="form-card">
<div class="form-card-header form-card-header-action">
<div class="form-card-title">
<div class="form-card-icon"><i class="fa-solid fa-list-ol"></i></div>
<div>
<h2>Cooking Instructions</h2>
<p>Add clear step-by-step instructions for preparing the recipe.</p>
</div>
</div>
<button type="button" class="add-field-btn" id="addStepBtn"><i class="fa-solid fa-plus"></i>Add Step</button>
</div>
<div class="dynamic-list" id="stepsContainer">
<div class="step-row dynamic-row">
<div class="step-number">Step 1</div>
<div class="step-field">
<textarea name="instruction" placeholder="Describe the first cooking step..." maxlength="2000" required></textarea>
</div>
<button type="button" class="remove-field-btn remove-step" title="Remove step"><i class="fa-solid fa-trash"></i></button>
</div>
</div>
</section>
</div>
<div class="recipe-form-sidebar">
<section class="form-card publish-card">
<div class="publish-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
<h2>Ready to Publish?</h2>
<p>Review your recipe details, ingredients and cooking steps before publishing.</p>
<div class="publish-checklist">
<div><i class="fa-solid fa-circle-check"></i><span>Complete recipe information</span></div>
<div><i class="fa-solid fa-circle-check"></i><span>Add all required ingredients</span></div>
<div><i class="fa-solid fa-circle-check"></i><span>Write clear cooking steps</span></div>
</div>
<button type="submit" class="publish-btn"><i class="fa-solid fa-paper-plane"></i>Publish Recipe</button>
<a href="<%=request.getContextPath()%>/my-recipes" class="cancel-btn"><i class="fa-solid fa-xmark"></i>Cancel</a>
</section>
<section class="form-card recipe-tip-card">
<div class="recipe-tip-icon"><i class="fa-solid fa-lightbulb"></i></div>
<div>
<h3>Recipe Tip</h3>
<p>Use clear ingredient quantities and simple instructions to make your recipe easier to follow.</p>
</div>
</section>
</div>
</div>
</form>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/recipe-form.js"></script>
</body>
</html>
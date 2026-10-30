<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
User user=(User)request.getAttribute("user");
Integer totalRecipes=(Integer)request.getAttribute("totalRecipes");
Integer favoriteCount=(Integer)request.getAttribute("favoriteCount");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
if(user==null){
response.sendRedirect(request.getContextPath()+"/profile");
return;
}
if(totalRecipes==null)totalRecipes=0;
if(favoriteCount==null)favoriteCount=0;
String phone=user.getPhone();
String bio=user.getBio();
if(phone==null||phone.trim().isEmpty())phone="Not added yet";
if(bio==null||bio.trim().isEmpty())bio="Tell others a little about yourself and your cooking interests.";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Profile | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/profile.css">
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
<li class="active">
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
<h2>My Profile</h2>
<p>Manage your personal information and account details</p>
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
<section class="profile-hero-card">
<div class="profile-identity">
<div class="profile-avatar-large">
<i class="fa-solid fa-user"></i>
</div>
<div class="profile-identity-info">
<span class="profile-role-badge"><i class="fa-solid fa-circle-check"></i><%=user.getRole()%></span>
<h1><%=user.getFullName()%></h1>
<p><%=user.getEmail()%></p>
</div>
</div>
<a href="<%=request.getContextPath()%>/editProfile" class="profile-edit-btn">
<i class="fa-solid fa-pen"></i>
Edit Profile
</a>
</section>

<section class="profile-stats-grid">
<div class="profile-stat-card">
<div class="profile-stat-icon yellow">
<i class="fa-solid fa-book-open"></i>
</div>
<div>
<h2><%=totalRecipes%></h2>
<p>Total Recipes</p>
</div>
</div>

<div class="profile-stat-card">
<div class="profile-stat-icon red">
<i class="fa-solid fa-heart"></i>
</div>
<div>
<h2><%=favoriteCount%></h2>
<p>Favorite Recipes</p>
</div>
</div>

<div class="profile-stat-card">
<div class="profile-stat-icon blue">
<i class="fa-solid fa-user-check"></i>
</div>
<div>
<h2><%=user.getAccountStatus()%></h2>
<p>Account Status</p>
</div>
</div>
</section>

<section class="profile-content-grid">

<div class="profile-main-column">

<section class="profile-card">
<div class="profile-card-header">
<div class="profile-card-title">
<div class="profile-card-icon">
<i class="fa-solid fa-address-card"></i>
</div>
<div>
<h2>Personal Information</h2>
<p>Your personal details and contact information</p>
</div>
</div>
<a href="<%=request.getContextPath()%>/edit-profile" class="profile-small-edit-btn">
<i class="fa-solid fa-pen"></i>
Edit
</a>
</div>

<div class="profile-information-grid">

<div class="profile-info-item">
<div class="profile-info-icon">
<i class="fa-solid fa-user"></i>
</div>
<div>
<span>Full Name</span>
<h3><%=user.getFullName()%></h3>
</div>
</div>

<div class="profile-info-item">
<div class="profile-info-icon">
<i class="fa-solid fa-envelope"></i>
</div>
<div>
<span>Email Address</span>
<h3><%=user.getEmail()%></h3>
</div>
</div>

<div class="profile-info-item">
<div class="profile-info-icon">
<i class="fa-solid fa-phone"></i>
</div>
<div>
<span>Phone Number</span>
<h3><%=phone%></h3>
</div>
</div>

<div class="profile-info-item">
<div class="profile-info-icon">
<i class="fa-solid fa-user-tag"></i>
</div>
<div>
<span>Account Role</span>
<h3><%=user.getRole()%></h3>
</div>
</div>

</div>
</section>

<section class="profile-card">
<div class="profile-card-header">
<div class="profile-card-title">
<div class="profile-card-icon">
<i class="fa-solid fa-quote-left"></i>
</div>
<div>
<h2>About Me</h2>
<p>A little more about your profile</p>
</div>
</div>
</div>

<div class="profile-bio">
<p><%=bio%></p>
</div>
</section>

</div>

<div class="profile-sidebar-column">

<section class="profile-card account-details-card">
<div class="profile-card-header">
<div class="profile-card-title">
<div class="profile-card-icon">
<i class="fa-solid fa-shield-halved"></i>
</div>
<div>
<h2>Account Details</h2>
<p>Your Flavourly account information</p>
</div>
</div>
</div>

<div class="account-details-list">

<div class="account-detail-item">
<span>
<i class="fa-solid fa-circle-check"></i>
Account Status
</span>
<strong><%=user.getAccountStatus()%></strong>
</div>

<div class="account-detail-item">
<span>
<i class="fa-solid fa-user-shield"></i>
Role
</span>
<strong><%=user.getRole()%></strong>
</div>

<div class="account-detail-item">
<span>
<i class="fa-regular fa-calendar"></i>
Member Since
</span>
<strong><%=user.getCreatedAt()%></strong>
</div>

<div class="account-detail-item">
<span>
<i class="fa-solid fa-clock-rotate-left"></i>
Last Login
</span>
<strong><%=user.getLastLogin()!=null?user.getLastLogin():"Not available"%></strong>
</div>

</div>
</section>

<section class="profile-card profile-security-card">
<div class="profile-security-icon">
<i class="fa-solid fa-lock"></i>
</div>
<div>
<h3>Account Security</h3>
<p>Keep your account secure by regularly updating your password.</p>
<a href="<%=request.getContextPath()%>/changePassword">
Change Password
<i class="fa-solid fa-arrow-right"></i>
</a>
</div>
</section>

</div>

</section>
<section class="profile-tip-banner">

<div class="profile-tip-icon">
<i class="fa-solid fa-lightbulb"></i>
</div>

<div>
<h2>Build Your Digital Cookbook</h2>
<p>Keep adding recipes, save your favorites and explore Flavourly's features to create your personalized cooking experience.</p>
</div>

<a href="<%=request.getContextPath()%>/add-recipe" class="btn btn-primary">
<i class="fa-solid fa-plus"></i>
Add Recipe
</a>

</section>

</main>

</div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>

</body>
</html>
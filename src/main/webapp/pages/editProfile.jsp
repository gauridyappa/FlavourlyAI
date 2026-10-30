<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
User user=(User)request.getAttribute("user");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
if(user==null){
response.sendRedirect(request.getContextPath()+"/editProfile");
return;
}
String phone=user.getPhone()!=null?user.getPhone():"";
String bio=user.getBio()!=null?user.getBio():"";
String error=request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Edit Profile | Flavourly – AI Inspired Digital Recipe Management System</title>
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
<h2>Edit Profile</h2>
<p>Update your personal information and profile details</p>
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

<section class="details-navigation">

<a href="<%=request.getContextPath()%>/profile" class="details-back-btn">
<i class="fa-solid fa-arrow-left"></i>
Back to Profile
</a>

</section>

<%
if("invalidName".equals(error)){
%>
<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
Please enter your full name.
</div>
<%
}else if("failed".equals(error)||"invalid".equals(error)){
%>
<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
Profile could not be updated. Please try again.
</div>
<%
}
%>
<section class="profile-card edit-profile-card">

<div class="profile-card-header">

<div class="profile-card-title">

<div class="profile-card-icon">
<i class="fa-solid fa-user-pen"></i>
</div>

<div>
<h2>Personal Information</h2>
<p>Update your name, phone number and bio</p>
</div>

</div>

</div>

<form action="<%=request.getContextPath()%>/editProfile" method="post" class="edit-profile-form">

<div class="edit-profile-grid">

<div class="edit-profile-group">

<label for="fullName">Full Name</label>

<div class="edit-profile-input">
<i class="fa-solid fa-user"></i>
<input type="text" id="fullName" name="fullName" value="<%=user.getFullName()%>" placeholder="Enter your full name" maxlength="100" required>
</div>

</div>

<div class="edit-profile-group">

<label for="email">Email Address</label>

<div class="edit-profile-input readonly-input">
<i class="fa-solid fa-envelope"></i>
<input type="email" id="email" value="<%=user.getEmail()%>" readonly>
</div>

<p class="edit-profile-help">
<i class="fa-solid fa-lock"></i>
Email address cannot be changed.
</p>

</div>

<div class="edit-profile-group">

<label for="phone">Phone Number</label>

<div class="edit-profile-input">
<i class="fa-solid fa-phone"></i>
<input type="tel" id="phone" name="phone" value="<%=phone%>" placeholder="Enter your phone number" maxlength="20">
</div>

</div>

<div class="edit-profile-group">

<label>Account Role</label>

<div class="edit-profile-input readonly-input">
<i class="fa-solid fa-user-shield"></i>
<input type="text" value="<%=user.getRole()%>" readonly>
</div>

<p class="edit-profile-help">
<i class="fa-solid fa-circle-info"></i>
Your account role is managed by Flavourly.
</p>

</div>

<div class="edit-profile-group full-width">

<label for="bio">About Me</label>

<div class="edit-profile-textarea">
<textarea id="bio" name="bio" placeholder="Tell us about yourself and your cooking interests..." maxlength="500"><%=bio%></textarea>
</div>

<div class="edit-profile-textarea-footer">
<span>Share a little about your cooking interests and experience.</span>
<span id="bioCharacterCount"><%=bio.length()%>/500</span>
</div>

</div>

</div>

<div class="edit-profile-actions">

<a href="<%=request.getContextPath()%>/profile" class="edit-profile-cancel-btn">
<i class="fa-solid fa-xmark"></i>
Cancel
</a>

<button type="submit" class="edit-profile-save-btn">
<i class="fa-solid fa-floppy-disk"></i>
Save Changes
</button>

</div>

</form>

</section>

<section class="profile-tip-banner">

<div class="profile-tip-icon">
<i class="fa-solid fa-circle-info"></i>
</div>

<div>
<h2>Keep Your Profile Updated</h2>
<p>Your profile information helps personalize your Flavourly experience. Your email address, account role and account status remain protected.</p>
</div>

</section>

</main>

</div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>

<script>
document.addEventListener("DOMContentLoaded",function(){
const bio=document.getElementById("bio");
const bioCharacterCount=document.getElementById("bioCharacterCount");
if(bio&&bioCharacterCount){
bio.addEventListener("input",function(){
bioCharacterCount.textContent=bio.value.length+"/500";
});
}
});
</script>

</body>
</html>
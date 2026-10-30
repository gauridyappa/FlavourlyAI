<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
String error=request.getParameter("error");
String success=request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Change Password | Flavourly – AI Inspired Digital Recipe Management System</title>
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
<h2>Change Password</h2>
<p>Update your password to keep your Flavourly account secure</p>
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
if("updated".equals(success)){
%>

<div class="details-alert success">
<i class="fa-solid fa-circle-check"></i>
Password changed successfully.
</div>

<%
}else if("emptyFields".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
Please complete all password fields.
</div>

<%
}else if("incorrectPassword".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
Your current password is incorrect.
</div>

<%
}else if("shortPassword".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
New password must contain at least 8 characters.
</div>

<%
}else if("passwordMismatch".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
New password and confirmation password do not match.
</div>

<%
}else if("samePassword".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
New password must be different from your current password.
</div>

<%
}else if("failed".equals(error)){
%>

<div class="details-alert error">
<i class="fa-solid fa-circle-exclamation"></i>
Password could not be changed. Please try again.
</div>

<%
}
%>
<section class="profile-card edit-profile-card">

<div class="profile-card-header">
<div class="profile-card-title">
<div class="profile-card-icon">
<i class="fa-solid fa-lock"></i>
</div>
<div>
<h2>Update Password</h2>
<p>Enter your current password and choose a new secure password</p>
</div>
</div>
</div>

<form action="<%=request.getContextPath()%>/changePassword" method="post" class="edit-profile-form">

<div class="edit-profile-grid">

<div class="edit-profile-group full-width">
<label for="currentPassword">Current Password</label>
<div class="edit-profile-input">
<i class="fa-solid fa-lock"></i>
<input type="password" id="currentPassword" name="currentPassword" placeholder="Enter your current password" required>
<button type="button" class="password-toggle" data-target="currentPassword">
<i class="fa-solid fa-eye"></i>
</button>
</div>
</div>

<div class="edit-profile-group">
<label for="newPassword">New Password</label>
<div class="edit-profile-input">
<i class="fa-solid fa-key"></i>
<input type="password" id="newPassword" name="newPassword" placeholder="Enter your new password" minlength="8" required>
<button type="button" class="password-toggle" data-target="newPassword">
<i class="fa-solid fa-eye"></i>
</button>
</div>
<p class="edit-profile-help">
<i class="fa-solid fa-circle-info"></i>
Password must contain at least 8 characters.
</p>
</div>

<div class="edit-profile-group">
<label for="confirmPassword">Confirm New Password</label>
<div class="edit-profile-input">
<i class="fa-solid fa-shield-halved"></i>
<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your new password" minlength="8" required>
<button type="button" class="password-toggle" data-target="confirmPassword">
<i class="fa-solid fa-eye"></i>
</button>
</div>
<p class="edit-profile-help">
<i class="fa-solid fa-circle-check"></i>
Enter the same new password again.
</p>
</div>

</div>

<div class="password-security-box">
<div class="password-security-icon">
<i class="fa-solid fa-shield-halved"></i>
</div>
<div>
<h3>Password Security</h3>
<p>Choose a password that is different from your current password and contains at least 8 characters.</p>
</div>
</div>

<div class="edit-profile-actions">

<a href="<%=request.getContextPath()%>/profile" class="edit-profile-cancel-btn">
<i class="fa-solid fa-xmark"></i>
Cancel
</a>

<button type="submit" class="edit-profile-save-btn">
<i class="fa-solid fa-lock"></i>
Change Password
</button>

</div>

</form>

</section>

</main>

</div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>

<script>
document.addEventListener("DOMContentLoaded",function(){
const toggleButtons=document.querySelectorAll(".password-toggle");
toggleButtons.forEach(function(button){
button.addEventListener("click",function(){
const targetId=button.getAttribute("data-target");
const input=document.getElementById(targetId);
const icon=button.querySelector("i");
if(input.type==="password"){
input.type="text";
icon.classList.remove("fa-eye");
icon.classList.add("fa-eye-slash");
}else{
input.type="password";
icon.classList.remove("fa-eye-slash");
icon.classList.add("fa-eye");
}
});
});
});
</script>

</body>
</html>
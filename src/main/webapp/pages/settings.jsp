<%@page import="com.flavourly.model.UserSettings"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
UserSettings settings=(UserSettings)request.getAttribute("settings");
if(settings==null){
response.sendRedirect(request.getContextPath()+"/settings");
return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Settings | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/settings.css">
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
<li><a href="<%=request.getContextPath()%>/favorites"><i class="fa-solid fa-heart"></i><span>Favorites</span></a></li>
<li><a href="<%=request.getContextPath()%>/aiGenerator"><i class="fa-solid fa-wand-magic-sparkles"></i><span>AI Generator</span></a></li>
<li><a href="<%=request.getContextPath()%>/nutrition"><i class="fa-solid fa-chart-pie"></i><span>Nutrition</span></a></li>
<li><a href="<%=request.getContextPath()%>/reviews"><i class="fa-solid fa-star"></i><span>Reviews</span></a></li>
<li><a href="<%=request.getContextPath()%>/profile"><i class="fa-solid fa-user"></i><span>Profile</span></a></li>
<li class="active"><a href="<%=request.getContextPath()%>/settings"><i class="fa-solid fa-gear"></i><span>Settings</span></a></li>
<li><a href="<%=request.getContextPath()%>/logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
</ul>
</aside>
<div class="main-content">
<header class="topbar">
<div class="left-top">
<button type="button" class="menu-btn"><i class="fa-solid fa-bars"></i></button>
<div class="page-title"><h2>Settings</h2><p>Manage your Flavourly preferences</p></div>
</div>
<div class="right-top">
<button type="button" class="icon-btn"><i class="fa-regular fa-bell"></i></button>
<div class="user-box">
<div class="avatar"><i class="fa-solid fa-user"></i></div>
<div><h4><%=loggedUser.getFullName()%></h4><p><%=loggedUser.getRole()%></p></div>
</div>
</div>
</header>
<main class="dashboard-content">
<section class="settings-hero">
<div class="settings-hero-content">
<span class="settings-hero-badge"><i class="fa-solid fa-sliders"></i>Personal Preferences</span>
<h1>Make Flavourly Work Your Way</h1>
<p>Customize notifications, privacy and recipe display preferences for a more personalized cooking experience.</p>
</div>
<div class="settings-hero-visual"><div class="settings-hero-circle"><i class="fa-solid fa-gears"></i></div></div>
</section>
<%
String success=request.getParameter("success");
String error=request.getParameter("error");
if("settingsUpdated".equals(success)){
%>
<div class="settings-message success"><i class="fa-solid fa-circle-check"></i><span>Your settings were updated successfully.</span></div>
<%
}else if(error!=null){
%>
<div class="settings-message error"><i class="fa-solid fa-circle-exclamation"></i><span>Settings could not be updated. Please try again.</span></div>
<%
}
%>
<form action="<%=request.getContextPath()%>/updateSettings" method="post" class="settings-form">
<div class="settings-grid">
<section class="settings-card">
<div class="settings-card-header">
<div class="settings-card-icon"><i class="fa-solid fa-bell"></i></div>
<div><h2>Notification Preferences</h2><p>Choose which updates you want to receive</p></div>
</div>
<div class="settings-options">
<div class="settings-option">
<div class="settings-option-info">
<div class="settings-option-icon"><i class="fa-solid fa-envelope"></i></div>
<div><h3>Email Notifications</h3><p>Receive important account and activity updates by email.</p></div>
</div>
<label class="settings-switch">
<input type="checkbox" name="emailNotifications" <%=settings.isEmailNotifications()?"checked":""%>>
<span class="settings-slider"></span>
</label>
</div>
<div class="settings-option">
<div class="settings-option-info">
<div class="settings-option-icon"><i class="fa-solid fa-bowl-food"></i></div>
<div><h3>Recipe Updates</h3><p>Receive notifications about new recipes and cooking inspiration.</p></div>
</div>
<label class="settings-switch">
<input type="checkbox" name="recipeUpdates" <%=settings.isRecipeUpdates()?"checked":""%>>
<span class="settings-slider"></span>
</label>
</div>
<div class="settings-option">
<div class="settings-option-info">
<div class="settings-option-icon"><i class="fa-solid fa-star"></i></div>
<div><h3>Review Notifications</h3><p>Stay informed about review and community activity.</p></div>
</div>
<label class="settings-switch">
<input type="checkbox" name="reviewNotifications" <%=settings.isReviewNotifications()?"checked":""%>>
<span class="settings-slider"></span>
</label>
</div>
</div>
</section>
<section class="settings-card">
<div class="settings-card-header">
<div class="settings-card-icon"><i class="fa-solid fa-shield-halved"></i></div>
<div><h2>Privacy Preferences</h2><p>Control the visibility of your Flavourly profile</p></div>
</div>
<div class="settings-choice-group">
<label class="settings-choice">
<input type="radio" name="profileVisibility" value="PUBLIC" <%="PUBLIC".equals(settings.getProfileVisibility())?"checked":""%> required>
<div class="settings-choice-content">
<div class="settings-choice-icon"><i class="fa-solid fa-earth-americas"></i></div>
<div><h3>Public Profile</h3><p>Allow your profile and recipe activity to be visible to the Flavourly community.</p></div>
<div class="settings-choice-check"><i class="fa-solid fa-check"></i></div>
</div>
</label>
<label class="settings-choice">
<input type="radio" name="profileVisibility" value="PRIVATE" <%="PRIVATE".equals(settings.getProfileVisibility())?"checked":""%> required>
<div class="settings-choice-content">
<div class="settings-choice-icon"><i class="fa-solid fa-lock"></i></div>
<div><h3>Private Profile</h3><p>Keep your profile and activity private while continuing to use Flavourly features.</p></div>
<div class="settings-choice-check"><i class="fa-solid fa-check"></i></div>
</div>
</label>
</div>
</section>
<section class="settings-card">
<div class="settings-card-header">
<div class="settings-card-icon"><i class="fa-solid fa-table-cells-large"></i></div>
<div><h2>Recipe Display</h2><p>Choose how your recipes should be displayed</p></div>
</div>
<div class="settings-choice-group">
<label class="settings-choice">
<input type="radio" name="defaultRecipeView" value="GRID" <%="GRID".equals(settings.getDefaultRecipeView())?"checked":""%> required>
<div class="settings-choice-content">
<div class="settings-choice-icon"><i class="fa-solid fa-table-cells-large"></i></div>
<div><h3>Grid View</h3><p>Display recipes as visual cards in a responsive grid layout.</p></div>
<div class="settings-choice-check"><i class="fa-solid fa-check"></i></div>
</div>
</label>
<label class="settings-choice">
<input type="radio" name="defaultRecipeView" value="LIST" <%="LIST".equals(settings.getDefaultRecipeView())?"checked":""%> required>
<div class="settings-choice-content">
<div class="settings-choice-icon"><i class="fa-solid fa-list"></i></div>
<div><h3>List View</h3><p>Display recipes in a compact list for quick browsing and management.</p></div>
<div class="settings-choice-check"><i class="fa-solid fa-check"></i></div>
</div>
</label>
</div>
</section>
<section class="settings-card settings-account-card">
<div class="settings-card-header">
<div class="settings-card-icon"><i class="fa-solid fa-user-shield"></i></div>
<div><h2>Account Information</h2><p>Your current Flavourly account details</p></div>
</div>
<div class="settings-account-list">
<div class="settings-account-item">
<div class="settings-account-icon"><i class="fa-solid fa-user"></i></div>
<div><span>Full Name</span><strong><%=loggedUser.getFullName()%></strong></div>
</div>
<div class="settings-account-item">
<div class="settings-account-icon"><i class="fa-solid fa-envelope"></i></div>
<div><span>Email Address</span><strong><%=loggedUser.getEmail()%></strong></div>
</div>
<div class="settings-account-item">
<div class="settings-account-icon"><i class="fa-solid fa-user-tag"></i></div>
<div><span>Account Role</span><strong><%=loggedUser.getRole()%></strong></div>
</div>
</div>
<div class="settings-profile-link">
<div><h3>Need to update your account?</h3><p>Personal information and account details can be managed from your Profile page.</p></div>
<a href="<%=request.getContextPath()%>/profile"><i class="fa-solid fa-arrow-up-right-from-square"></i>Open Profile</a>
</div>
</section>
</div>
<div class="settings-save-area">
<div class="settings-save-info">
<div class="settings-save-icon"><i class="fa-solid fa-floppy-disk"></i></div>
<div><h3>Save Your Preferences</h3><p>Your changes will be stored securely and applied to your Flavourly account.</p></div>
</div>
<button type="submit" class="settings-save-btn"><i class="fa-solid fa-check"></i>Save Settings</button>
</div>
</form>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
</body>
</html>
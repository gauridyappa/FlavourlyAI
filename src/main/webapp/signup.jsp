<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Create Account | Flavourly</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<link rel="stylesheet" href="assets/css/variables.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/auth.css">

</head>

<body>

<section class="auth-section">

<div class="auth-container">

<div class="auth-left">

<div class="auth-overlay">

<a href="index.jsp" class="auth-logo">

<div class="logo-icon">
<i class="fa-solid fa-utensils"></i>
</div>

<span>Flavourly</span>

</a>

<h1>Start Your Cooking Journey</h1>

<p>
Create your free Flavourly account to organize recipes, save favourites,
discover AI-generated meals and build your own digital cookbook.
</p>

<div class="auth-features">

<div class="feature-item">
<i class="fa-solid fa-book-open"></i>
<span>Create Your Recipe Collection</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-heart"></i>
<span>Save Unlimited Favorites</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-wand-magic-sparkles"></i>
<span>Generate AI Recipes</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-chart-pie"></i>
<span>Nutrition Analysis</span>
</div>

</div>

</div>

</div>

<div class="auth-right">

<div class="auth-card">

<h2>Create Account</h2>

<p class="auth-subtitle">
Join thousands of food lovers using Flavourly every day.
</p>

<%
String error=request.getParameter("error");

if("emailExists".equals(error)){
%>

<div class="alert error">

<i class="fa-solid fa-circle-xmark"></i>

Email already exists.

</div>

<%
}
%>

<form action="signup" method="post" autocomplete="off">

<div class="input-group">

<label>Full Name</label>

<div class="input-box">

<i class="fa-solid fa-user"></i>

<input
type="text"
name="fullName"
placeholder="Enter your full name"
required>

</div>

</div>

<div class="input-group">

<label>Email Address</label>

<div class="input-box">

<i class="fa-solid fa-envelope"></i>

<input
type="email"
name="email"
placeholder="Enter your email"
required>

</div>

</div>

<div class="input-group">

<label>Phone Number</label>

<div class="input-box">

<i class="fa-solid fa-phone"></i>

<input
type="text"
name="phone"
placeholder="Enter your phone number"
required>

</div>

</div>

<div class="input-group">

<label>Password</label>

<div class="input-box">

<i class="fa-solid fa-lock"></i>

<input
type="password"
id="password"
name="password"
placeholder="Create a password"
required>

<button
type="button"
class="toggle-password"
onclick="togglePassword()">

<i id="eyeIcon" class="fa-solid fa-eye"></i>

</button>

</div>

</div>

<div class="form-options">

<label class="remember-me">

<input type="checkbox" required>

<span>I agree to the Terms & Conditions</span>

</label>

</div>

<button type="submit" class="auth-btn">

<i class="fa-solid fa-user-plus"></i>

Create Account

</button>

</form>

<div class="divider">

<span>OR</span>

</div>

<div class="social-login">

<button type="button" class="social-btn">

<i class="fa-brands fa-google"></i>

Continue with Google

</button>

<button type="button" class="social-btn">

<i class="fa-brands fa-github"></i>

Continue with GitHub

</button>

</div>

<div class="auth-footer">

Already have an account?

<a href="login.jsp">

Login

</a>

</div>

</div>

</div>

</div>

</section>

<script src="assets/js/auth.js"></script>

</body>

</html>
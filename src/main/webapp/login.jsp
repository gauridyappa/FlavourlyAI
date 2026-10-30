<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | Flavourly</title>

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

<h1>Welcome Back!</h1>

<p>
Sign in to continue exploring delicious recipes, manage your favourites,
discover AI-powered cooking suggestions and enjoy your personal cooking dashboard.
</p>

<div class="auth-features">

<div class="feature-item">
<i class="fa-solid fa-bowl-food"></i>
<span>500+ Premium Recipes</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-robot"></i>
<span>AI Recipe Generator</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-heart"></i>
<span>Save Favourite Recipes</span>
</div>

<div class="feature-item">
<i class="fa-solid fa-chart-line"></i>
<span>Nutrition Analysis</span>
</div>

</div>

</div>

</div>

<div class="auth-right">

<div class="auth-card">

<h2>Login</h2>

<p class="auth-subtitle">
Enter your credentials to access your account.
</p>

<%
String success=request.getParameter("success");
String error=request.getParameter("error");

if("registered".equals(success)){
%>

<div class="alert success">

<i class="fa-solid fa-circle-check"></i>

Registration Successful. Please login.

</div>

<%
}

if("invalid".equals(error)){
%>

<div class="alert error">

<i class="fa-solid fa-circle-xmark"></i>

Invalid Email or Password.

</div>

<%
}
%>

<form action="login" method="post" autocomplete="off">

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

<label>Password</label>

<div class="input-box">

<i class="fa-solid fa-lock"></i>

<input
type="password"
id="password"
name="password"
placeholder="Enter your password"
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

        <input type="checkbox" name="remember">

        <span>Remember Me</span>

    </label>

    <a href="#" class="forgot-password">

        Forgot Password?

    </a>

</div>

<button type="submit" class="auth-btn">

    <i class="fa-solid fa-right-to-bracket"></i>

    Login

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

    Don't have an account?

    <a href="signup.jsp">

        Create Account

    </a>

</div>

</div>

</div>

</div>

</section>

<script src="assets/js/auth.js"></script>

</body>

</html>
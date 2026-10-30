<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Flavourly – AI Inspired Digital Recipe Management System</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<link rel="stylesheet" href="assets/css/variables.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/navbar.css">
<link rel="stylesheet" href="assets/css/hero.css">
<link rel="stylesheet" href="assets/css/homepage.css">
<link rel="stylesheet" href="assets/css/footer.css">
<link rel="stylesheet" href="assets/css/responsive.css">

</head>

<body>

<%@ include file="includes/publicNavbar.jsp" %>

<!-- ===========================
     HERO SECTION
============================ -->

<section class="hero">

    <div class="container">

        <div class="hero-wrapper">

            <div class="hero-content">

                <span class="hero-badge">

                    <i class="fa-solid fa-wand-magic-sparkles"></i>

                    AI Powered Recipe Platform

                </span>

                <h1>

                    Cook Smarter With

                    <span>Flavourly</span>

                </h1>

                <p>

                    Discover delicious recipes, organize your favorites,
                    generate recipes with AI, analyze nutrition,
                    and manage your cooking journey—all in one place.

                </p>

                <div class="hero-buttons">

                    <a href="signup.jsp" class="btn btn-primary">

                        Get Started

                    </a>

                    <a href="#" class="btn btn-outline">

                        Explore Recipes

                    </a>

                </div>

                <div class="hero-search">

                    <input
                        type="text"
                        placeholder="Search recipes, ingredients, cuisines...">

                    <button>

                        <i class="fa-solid fa-magnifying-glass"></i>

                    </button>

                </div>

                <div class="hero-stats">

                    <div>

                        <h3>500+</h3>

                        <p>Recipes</p>

                    </div>

                    <div>

                        <h3>50+</h3>

                        <p>Categories</p>

                    </div>

                    <div>

                        <h3>10K+</h3>

                        <p>Food Lovers</p>

                    </div>

                </div>

            </div>

            <div class="hero-image">

                <img
                src="assets/images/homepage/hero-food.png"
                alt="Hero Image">

            </div>

        </div>

    </div>

</section>

<!-- ===========================
     CATEGORIES
============================ -->

<section class="categories">

    <div class="container">

        <div class="section-heading">

            <h2>

                Browse Categories

            </h2>

            <p>

                Explore recipes from your favourite cuisines and meal types.

            </p>

        </div>

        <div class="category-grid">

            <div class="category-card">

                <img src="assets/images/homepage/breakfast.jpg">

                <h3>Breakfast</h3>

            </div>

            <div class="category-card">

                <img src="assets/images/homepage/lunch.jpg">

                <h3>Lunch</h3>

            </div>

            <div class="category-card">

                <img src="assets/images/homepage/dessert.jpg">

                <h3>Desserts</h3>

            </div>

            <div class="category-card">

                <img src="assets/images/homepage/healthy.jpg">

                <h3>Healthy</h3>

            </div>

        </div>

    </div>

</section>

<!-- CONTINUE IN PART 2 -->
<!-- ===========================
     FEATURED RECIPES
=========================== -->

<section class="featured">
    <div class="container">

        <div class="section-heading">
            <h2>Featured Recipes</h2>
            <p>Hand-picked recipes loved by thousands of food enthusiasts.</p>
        </div>

        <div class="recipe-grid">

            <div class="recipe-card">
                <div class="recipe-image">
                    <img src="assets/images/homepage/pizza.jpg" alt="Pizza">
                </div>

                <div class="recipe-content">
                    <span class="recipe-category">Italian</span>
                    <h3>Cheese Burst Pizza</h3>

                    <div class="recipe-info">
                        <span><i class="fa-regular fa-clock"></i> 35 Min</span>
                        <span><i class="fa-solid fa-fire"></i> 420 Cal</span>
                    </div>

                    <div class="recipe-footer">
                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            4.9
                        </div>

                        <a href="#" class="btn btn-primary">
                            View Recipe
                        </a>
                    </div>
                </div>
            </div>

            <div class="recipe-card">
                <div class="recipe-image">
                    <img src="assets/images/homepage/pasta.jpg" alt="Pasta">
                </div>

                <div class="recipe-content">
                    <span class="recipe-category">Italian</span>
                    <h3>Creamy White Sauce Pasta</h3>

                    <div class="recipe-info">
                        <span><i class="fa-regular fa-clock"></i> 25 Min</span>
                        <span><i class="fa-solid fa-fire"></i> 340 Cal</span>
                    </div>

                    <div class="recipe-footer">
                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            4.8
                        </div>

                        <a href="#" class="btn btn-primary">
                            View Recipe
                        </a>
                    </div>
                </div>
            </div>

            <div class="recipe-card">
                <div class="recipe-image">
                    <img src="assets/images/homepage/salad.jpg" alt="Salad">
                </div>

                <div class="recipe-content">
                    <span class="recipe-category">Healthy</span>
                    <h3>Fresh Garden Salad</h3>

                    <div class="recipe-info">
                        <span><i class="fa-regular fa-clock"></i> 15 Min</span>
                        <span><i class="fa-solid fa-fire"></i> 180 Cal</span>
                    </div>

                    <div class="recipe-footer">
                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            4.9
                        </div>

                        <a href="#" class="btn btn-primary">
                            View Recipe
                        </a>
                    </div>
                </div>
            </div>

        </div>

    </div>
</section>

<!-- ===========================
     WHY CHOOSE US
=========================== -->

<section class="why-us">

    <div class="container">

        <div class="section-heading">
            <h2>Why Choose Flavourly?</h2>
            <p>Your complete digital recipe companion powered by modern technology.</p>
        </div>

        <div class="why-grid">

            <div class="feature-card">
                <i class="fa-solid fa-robot"></i>
                <h3>AI Recipe Generator</h3>
                <p>Create recipes instantly using AI based on your ingredients and preferences.</p>
            </div>

            <div class="feature-card">
                <i class="fa-solid fa-heart"></i>
                <h3>Save Favorites</h3>
                <p>Bookmark recipes and access them anytime from your personal dashboard.</p>
            </div>

            <div class="feature-card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>Nutrition Insights</h3>
                <p>Understand calories, nutrition and healthy alternatives before cooking.</p>
            </div>

            <div class="feature-card">
                <i class="fa-solid fa-mobile-screen-button"></i>
                <h3>Responsive Design</h3>
                <p>Enjoy the same premium experience across desktop, tablet and mobile.</p>
            </div>

        </div>

    </div>

</section>

<!-- ===========================
     HOW IT WORKS
=========================== -->

<section class="how-it-works">

    <div class="container">

        <div class="section-heading">
            <h2>How It Works</h2>
            <p>Start cooking in just a few simple steps.</p>
        </div>

        <div class="steps">

            <div class="step-card">
                <div class="step-number">1</div>
                <h3>Create Account</h3>
                <p>Sign up and personalize your cooking profile.</p>
            </div>

            <div class="step-card">
                <div class="step-number">2</div>
                <h3>Explore Recipes</h3>
                <p>Search recipes by category, ingredients or cuisine.</p>
            </div>

            <div class="step-card">
                <div class="step-number">3</div>
                <h3>Cook & Save</h3>
                <p>Prepare amazing dishes and save your favourites.</p>
            </div>

        </div>

    </div>

</section>

<!-- CONTINUE IN PART 3 -->

<!-- ===========================
     STATISTICS
=========================== -->

<section class="statistics">
    <div class="container">
        <div class="section-heading">
            <h2>Trusted By Food Lovers</h2>
            <p>Join thousands of users who cook smarter every day.</p>
        </div>

        <div class="stats-grid">

            <div class="stat-card">
                <i class="fa-solid fa-bowl-food"></i>
                <h2>500+</h2>
                <p>Recipes</p>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-users"></i>
                <h2>10K+</h2>
                <p>Users</p>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-heart"></i>
                <h2>25K+</h2>
                <p>Favorites</p>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-star"></i>
                <h2>4.9</h2>
                <p>Average Rating</p>
            </div>

        </div>
    </div>
</section>

<!-- ===========================
     TESTIMONIALS
=========================== -->

<section class="testimonials">

    <div class="container">

        <div class="section-heading">
            <h2>What Our Users Say</h2>
            <p>Real experiences from our community.</p>
        </div>

        <div class="testimonial-grid">

            <div class="testimonial-card">
                <img src="assets/images/homepage/testimonial-1.jpg" alt="">
                <h3>Emily Johnson</h3>
                <span>Home Chef</span>
                <p>"Flavourly has completely changed the way I organize recipes. The interface is beautiful and easy to use."</p>
            </div>

            <div class="testimonial-card">
                <img src="assets/images/homepage/testimonial-2.jpg" alt="">
                <h3>David Wilson</h3>
                <span>Fitness Enthusiast</span>
                <p>"The nutrition insights and AI recipe suggestions are exactly what I needed for healthy cooking."</p>
            </div>

            <div class="testimonial-card">
                <img src="assets/images/homepage/testimonial-3.jpg" alt="">
                <h3>Sophia Brown</h3>
                <span>Food Blogger</span>
                <p>"This feels like a premium cooking platform. Fast, modern and beautifully designed."</p>
            </div>

        </div>

    </div>

</section>

<!-- ===========================
     CTA
=========================== -->

<section class="cta">

    <div class="container">

        <div class="cta-box">

            <h2>Ready To Transform Your Cooking Experience?</h2>

            <p>
                Discover recipes, generate meals using AI and organize your favourite dishes with Flavourly.
            </p>

            <div class="hero-buttons">

                <a href="signup.jsp" class="btn btn-primary">
                    Get Started
                </a>

                <a href="login.jsp" class="btn btn-outline">
                    Login
                </a>

            </div>

        </div>

    </div>

</section>

<!-- ===========================
     FOOTER
=========================== -->

<footer class="footer">

    <div class="container">

        <div class="footer-top">

            <div class="footer-about">

                <div class="logo">

                    <div class="logo-icon">
                        <i class="fa-solid fa-utensils"></i>
                    </div>

                    <span>Flavourly</span>

                </div>

                <p>
                    AI Inspired Digital Recipe Management System built to help everyone cook smarter,
                    healthier and faster.
                </p>

            </div>

            <div class="footer-links">

                <h3>Quick Links</h3>

                <ul>

                    <li><a href="#">Home</a></li>
                    <li><a href="#">Recipes</a></li>
                    <li><a href="#">Categories</a></li>
                    <li><a href="#">AI Generator</a></li>

                </ul>

            </div>

            <div class="footer-links">

                <h3>Support</h3>

                <ul>

                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms</a></li>

                </ul>

            </div>

            <div class="footer-social">

                <h3>Follow Us</h3>

                <div class="social-icons">

                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>

                    <a href="#"><i class="fa-brands fa-instagram"></i></a>

                    <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>

                    <a href="#"><i class="fa-brands fa-x-twitter"></i></a>

                </div>

            </div>

        </div>

        <div class="footer-bottom">

            <p>
                © 2026 Flavourly – AI Inspired Digital Recipe Management System. All Rights Reserved.
            </p>

        </div>

    </div>

</footer>

<script src="assets/js/script.js"></script>

</body>
</html>
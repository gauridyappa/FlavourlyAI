<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar">

    <div class="container nav-container">

        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">

            <div class="logo-icon">
                <i class="fa-solid fa-utensils"></i>
            </div>

            <span>Flavourly</span>

        </a>

        <ul class="nav-links">

            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>

            <li><a href="#">Recipes</a></li>

            <li><a href="#">Categories</a></li>

            <li><a href="#">AI Tools</a></li>

            <li><a href="#">About</a></li>

            <li><a href="#">Contact</a></li>

        </ul>

        <div class="nav-buttons">

            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">
                Login
            </a>

            <a href="${pageContext.request.contextPath}/signup.jsp" class="btn btn-primary">
                Sign Up
            </a>

        </div>

        <div class="menu-toggle">

            <i class="fa-solid fa-bars"></i>

        </div>

    </div>

</nav>
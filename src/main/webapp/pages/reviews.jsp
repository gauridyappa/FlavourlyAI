<%@page import="java.util.List"%>
<%@page import="com.flavourly.model.Recipe"%>
<%@page import="com.flavourly.model.Review"%>
<%@page import="com.flavourly.model.User"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
User loggedUser=(User)session.getAttribute("loggedUser");
if(loggedUser==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
List<Review> allReviews=(List<Review>)request.getAttribute("allReviews");
List<Review> myReviews=(List<Review>)request.getAttribute("myReviews");
List<Recipe> recipes=(List<Recipe>)request.getAttribute("recipes");
Integer totalReviews=(Integer)request.getAttribute("totalReviews");
Integer myReviewCount=(Integer)request.getAttribute("myReviewCount");
Integer fiveStarCount=(Integer)request.getAttribute("fiveStarCount");
Double averageRating=(Double)request.getAttribute("averageRating");
if(allReviews==null)allReviews=new java.util.ArrayList<>();
if(myReviews==null)myReviews=new java.util.ArrayList<>();
if(recipes==null)recipes=new java.util.ArrayList<>();
if(totalReviews==null)totalReviews=0;
if(myReviewCount==null)myReviewCount=0;
if(fiveStarCount==null)fiveStarCount=0;
if(averageRating==null)averageRating=0.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Reviews | Flavourly – AI Inspired Digital Recipe Management System</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/variables.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/dashboard.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reviews.css">
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
<li class="active"><a href="<%=request.getContextPath()%>/reviews"><i class="fa-solid fa-star"></i><span>Reviews</span></a></li>
<li><a href="<%=request.getContextPath()%>/profile"><i class="fa-solid fa-user"></i><span>Profile</span></a></li>
<li><a href="<%=request.getContextPath()%>/settings"><i class="fa-solid fa-gear"></i><span>Settings</span></a></li>
<li><a href="<%=request.getContextPath()%>/logout"><i class="fa-solid fa-right-from-bracket"></i><span>Logout</span></a></li>
</ul>
</aside>
<div class="main-content">
<header class="topbar">
<div class="left-top">
<button type="button" class="menu-btn"><i class="fa-solid fa-bars"></i></button>
<div class="page-title"><h2>Recipe Reviews</h2><p>Share experiences and discover community favorites</p></div>
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
<section class="reviews-hero">
<div class="reviews-hero-content">
<span class="reviews-hero-badge"><i class="fa-solid fa-star"></i>Community Feedback</span>
<h1>Rate, Review & Discover</h1>
<p>Share your cooking experiences, explore community opinions and discover the most appreciated recipes on Flavourly.</p>
</div>
<div class="reviews-hero-visual"><div class="reviews-hero-circle"><i class="fa-solid fa-comments"></i></div></div>
</section>
<section class="reviews-summary-grid">
<div class="reviews-summary-card">
<div class="reviews-summary-icon"><i class="fa-solid fa-comments"></i></div>
<div><h2><%=totalReviews%></h2><p>Total Reviews</p></div>
</div>
<div class="reviews-summary-card">
<div class="reviews-summary-icon"><i class="fa-solid fa-star"></i></div>
<div><h2><%=String.format("%.1f",averageRating)%></h2><p>Average Rating</p></div>
</div>
<div class="reviews-summary-card">
<div class="reviews-summary-icon"><i class="fa-solid fa-ranking-star"></i></div>
<div><h2><%=fiveStarCount%></h2><p>Five Star Reviews</p></div>
</div>
<div class="reviews-summary-card">
<div class="reviews-summary-icon"><i class="fa-solid fa-user-pen"></i></div>
<div><h2><%=myReviewCount%></h2><p>My Reviews</p></div>
</div>
</section>
<section class="reviews-main-grid">
<div class="review-form-card">
<div class="reviews-card-header">
<div><h2>Write a Review</h2><p>Share your experience with the community</p></div>
<div class="reviews-header-icon"><i class="fa-solid fa-pen"></i></div>
</div>
<%
String success=request.getParameter("success");
String error=request.getParameter("error");
if("reviewAdded".equals(success)){
%>
<div class="review-message success"><i class="fa-solid fa-circle-check"></i><span>Your review was added successfully.</span></div>
<%
}else if("reviewUpdated".equals(success)){
%>
<div class="review-message success"><i class="fa-solid fa-circle-check"></i><span>Your review was updated successfully.</span></div>
<%
}else if("reviewDeleted".equals(success)){
%>
<div class="review-message success"><i class="fa-solid fa-circle-check"></i><span>Your review was deleted successfully.</span></div>
<%
}else if("alreadyReviewed".equals(error)){
%>
<div class="review-message error"><i class="fa-solid fa-circle-exclamation"></i><span>You have already reviewed this recipe. You can edit your existing review instead.</span></div>
<%
}else if(error!=null){
%>
<div class="review-message error"><i class="fa-solid fa-circle-exclamation"></i><span>Something went wrong. Please try again.</span></div>
<%
}
%>
<%
if(recipes.isEmpty()){
%>
<div class="reviews-empty-state"><i class="fa-solid fa-book-open"></i><h3>No Recipes Available</h3><p>Recipes must be available before reviews can be submitted.</p></div>
<%
}else{
%>
<form action="<%=request.getContextPath()%>/addReview" method="post" class="review-form">
<div class="review-form-group">
<label for="recipeId">Choose Recipe</label>
<div class="review-select-box">
<i class="fa-solid fa-bowl-food"></i>
<select id="recipeId" name="recipeId" required>
<option value="">Select a recipe</option>
<%
for(Recipe recipe:recipes){
%>
<option value="<%=recipe.getRecipeId()%>"><%=recipe.getRecipeName()%> - <%=recipe.getCategoryName()%></option>
<%
}
%>
</select>
<i class="fa-solid fa-chevron-down review-select-arrow"></i>
</div>
</div>
<div class="review-form-group">
<label>Your Rating</label>
<div class="review-star-rating">
<input type="radio" id="star5" name="rating" value="5" required>
<label for="star5" title="5 Stars"><i class="fa-solid fa-star"></i></label>
<input type="radio" id="star4" name="rating" value="4">
<label for="star4" title="4 Stars"><i class="fa-solid fa-star"></i></label>
<input type="radio" id="star3" name="rating" value="3">
<label for="star3" title="3 Stars"><i class="fa-solid fa-star"></i></label>
<input type="radio" id="star2" name="rating" value="2">
<label for="star2" title="2 Stars"><i class="fa-solid fa-star"></i></label>
<input type="radio" id="star1" name="rating" value="1">
<label for="star1" title="1 Star"><i class="fa-solid fa-star"></i></label>
</div>
<p class="review-rating-help">Select a rating from 1 to 5 stars</p>
</div>
<div class="review-form-group">
<label for="review">Your Review</label>
<div class="review-textarea-box">
<i class="fa-regular fa-message"></i>
<textarea id="review" name="review" maxlength="1000" placeholder="Tell the community about your experience with this recipe..." required></textarea>
</div>
<div class="review-form-help"><span><i class="fa-solid fa-circle-info"></i> Share useful and respectful feedback</span><span id="reviewCharacterCount">0 / 1000</span></div>
</div>
<button type="submit" class="review-submit-btn"><i class="fa-solid fa-paper-plane"></i>Submit Review</button>
</form>
<%
}
%>
</div>
<div class="reviews-insight-card">
<div class="reviews-card-header">
<div><h2>Community Insights</h2><p>Feedback at a glance</p></div>
<div class="reviews-header-icon"><i class="fa-solid fa-chart-simple"></i></div>
</div>
<div class="reviews-rating-overview">
<div class="reviews-average-circle">
<strong><%=String.format("%.1f",averageRating)%></strong>
<span>out of 5</span>
</div>
<div class="reviews-rating-details">
<div class="reviews-display-stars">
<%
int roundedRating=(int)Math.round(averageRating);
for(int i=1;i<=5;i++){
if(i<=roundedRating){
%>
<i class="fa-solid fa-star"></i>
<%
}else{
%>
<i class="fa-regular fa-star"></i>
<%
}
}
%>
</div>
<h3>Community Rating</h3>
<p>Based on <%=totalReviews%> submitted review<%=totalReviews==1?"":"s"%>.</p>
</div>
</div>
<div class="reviews-insight-list">
<div><span><i class="fa-solid fa-comments"></i>Total Feedback</span><strong><%=totalReviews%></strong></div>
<div><span><i class="fa-solid fa-ranking-star"></i>Five Star Reviews</span><strong><%=fiveStarCount%></strong></div>
<div><span><i class="fa-solid fa-user-pen"></i>Your Contributions</span><strong><%=myReviewCount%></strong></div>
</div>
</div>
</section>
<section class="community-reviews-card">
<div class="reviews-card-header">
<div><h2>Community Reviews</h2><p>See what users are saying about Flavourly recipes</p></div>
<div class="reviews-header-icon"><i class="fa-solid fa-users"></i></div>
</div>
<%
if(allReviews.isEmpty()){
%>
<div class="reviews-empty-state"><i class="fa-regular fa-comments"></i><h3>No Reviews Yet</h3><p>Be the first to share a recipe experience with the community.</p></div>
<%
}else{
%>
<div class="community-reviews-grid">
<%
for(Review review:allReviews){
%>
<div class="community-review-item">
<div class="community-review-top">
<div class="community-review-user">
<div class="community-review-avatar"><i class="fa-solid fa-user"></i></div>
<div><h3><%=review.getUserName()%></h3><p>Reviewed <strong><%=review.getRecipeName()%></strong></p></div>
</div>
<div class="community-review-stars">
<%
for(int i=1;i<=5;i++){
if(i<=review.getRating()){
%>
<i class="fa-solid fa-star"></i>
<%
}else{
%>
<i class="fa-regular fa-star"></i>
<%
}
}
%>
</div>
</div>
<p class="community-review-text"><%=review.getReview()%></p>
<div class="community-review-footer">
<span><i class="fa-regular fa-clock"></i><%=review.getCreatedAt()%></span>
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=review.getRecipeId()%>">View Recipe <i class="fa-solid fa-arrow-right"></i></a>
</div>
</div>
<%
}
%>
</div>
<%
}
%>
</section>
<section class="my-reviews-card">
<div class="reviews-card-header">
<div><h2>My Reviews</h2><p>Manage the reviews you have submitted</p></div>
<div class="reviews-header-icon"><i class="fa-solid fa-user-pen"></i></div>
</div>
<%
if(myReviews.isEmpty()){
%>
<div class="reviews-empty-state"><i class="fa-regular fa-star"></i><h3>No Reviews Submitted</h3><p>Your submitted reviews will appear here.</p></div>
<%
}else{
%>
<div class="my-reviews-list">
<%
for(Review review:myReviews){
%>
<div class="my-review-item">
<div class="my-review-main">
<div class="my-review-icon"><i class="fa-solid fa-bowl-food"></i></div>
<div class="my-review-info">
<div class="my-review-title">
<h3><%=review.getRecipeName()%></h3>
<div class="my-review-stars">
<%
for(int i=1;i<=5;i++){
if(i<=review.getRating()){
%>
<i class="fa-solid fa-star"></i>
<%
}else{
%>
<i class="fa-regular fa-star"></i>
<%
}
}
%>
</div>
</div>
<p><%=review.getReview()%></p>
<span><i class="fa-regular fa-clock"></i><%=review.getCreatedAt()%></span>
</div>
</div>
<div class="my-review-actions">
<a href="<%=request.getContextPath()%>/recipe-details?id=<%=review.getRecipeId()%>" class="review-view-btn" title="View Recipe"><i class="fa-solid fa-eye"></i></a>
<button type="button" class="review-edit-btn" title="Edit Review" onclick="toggleEditReview(<%=review.getReviewId()%>)"><i class="fa-solid fa-pen"></i></button>
<form action="<%=request.getContextPath()%>/deleteReview" method="post" onsubmit="return confirm('Are you sure you want to delete this review?');">
<input type="hidden" name="reviewId" value="<%=review.getReviewId()%>">
<button type="submit" class="review-delete-btn" title="Delete Review"><i class="fa-solid fa-trash"></i></button>
</form>
</div>
</div>
<div class="edit-review-form" id="editReviewForm<%=review.getReviewId()%>">
<form action="<%=request.getContextPath()%>/editReview" method="post">
<input type="hidden" name="reviewId" value="<%=review.getReviewId()%>">
<div class="edit-review-header">
<div><h3>Edit Review</h3><p>Update your rating and feedback for <%=review.getRecipeName()%></p></div>
<button type="button" onclick="toggleEditReview(<%=review.getReviewId()%>)"><i class="fa-solid fa-xmark"></i></button>
</div>
<div class="edit-review-rating">
<%
for(int i=1;i<=5;i++){
%>
<label>
<input type="radio" name="rating" value="<%=i%>" <%=review.getRating()==i?"checked":""%> required>
<span><i class="fa-solid fa-star"></i> <%=i%></span>
</label>
<%
}
%>
</div>
<textarea name="review" maxlength="1000" required><%=review.getReview()%></textarea>
<div class="edit-review-buttons">
<button type="button" class="edit-review-cancel" onclick="toggleEditReview(<%=review.getReviewId()%>)">Cancel</button>
<button type="submit" class="edit-review-save"><i class="fa-solid fa-check"></i>Save Changes</button>
</div>
</form>
</div>
<%
}
%>
</div>
<%
}
%>
</section>
</main>
</div>
</div>
<script src="<%=request.getContextPath()%>/assets/js/dashboard.js"></script>
<script>
document.addEventListener("DOMContentLoaded",function(){
const reviewTextarea=document.getElementById("review");
const reviewCharacterCount=document.getElementById("reviewCharacterCount");
if(reviewTextarea&&reviewCharacterCount){
reviewTextarea.addEventListener("input",function(){
reviewCharacterCount.textContent=reviewTextarea.value.length+" / 1000";
});
}
});
function toggleEditReview(reviewId){
const form=document.getElementById("editReviewForm"+reviewId);
if(form){
form.classList.toggle("show");
}
}
</script>
</body>
</html>
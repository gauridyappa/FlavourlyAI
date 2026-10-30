package com.flavourly.servlet;
import com.flavourly.dao.RecipeDAO;
import com.flavourly.dao.ReviewDAO;
import com.flavourly.model.Recipe;
import com.flavourly.model.Review;
import com.flavourly.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/reviews")
public class ReviewsServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private ReviewDAO reviewDAO;
private RecipeDAO recipeDAO;
@Override
public void init(){
reviewDAO=new ReviewDAO();
recipeDAO=new RecipeDAO();
}
@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
User loggedUser=(User)session.getAttribute("loggedUser");
List<Review> allReviews=reviewDAO.getAllReviews();
List<Review> myReviews=reviewDAO.getReviewsByUser(loggedUser.getUserId());
List<Recipe> recipes=recipeDAO.getAllRecipes();
int totalReviews=allReviews.size();
int myReviewCount=myReviews.size();
double totalRating=0;
int fiveStarCount=0;
for(Review review:allReviews){
totalRating+=review.getRating();
if(review.getRating()==5){
fiveStarCount++;
}
}
double averageRating=totalReviews>0?totalRating/totalReviews:0;
request.setAttribute("allReviews",allReviews);
request.setAttribute("myReviews",myReviews);
request.setAttribute("recipes",recipes);
request.setAttribute("totalReviews",totalReviews);
request.setAttribute("myReviewCount",myReviewCount);
request.setAttribute("averageRating",averageRating);
request.setAttribute("fiveStarCount",fiveStarCount);
request.getRequestDispatcher("/pages/reviews.jsp").forward(request,response);
}
}
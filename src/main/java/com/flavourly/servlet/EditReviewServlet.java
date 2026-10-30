package com.flavourly.servlet;
import com.flavourly.dao.ReviewDAO;
import com.flavourly.model.Review;
import com.flavourly.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/editReview")
public class EditReviewServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private ReviewDAO reviewDAO;
@Override
public void init(){
reviewDAO=new ReviewDAO();
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
request.setCharacterEncoding("UTF-8");
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
try{
User loggedUser=(User)session.getAttribute("loggedUser");
int reviewId=Integer.parseInt(request.getParameter("reviewId"));
int rating=Integer.parseInt(request.getParameter("rating"));
String reviewText=request.getParameter("review");
if(rating<1||rating>5){
response.sendRedirect(request.getContextPath()+"/reviews?error=invalidRating");
return;
}
if(reviewText==null||reviewText.trim().isEmpty()){
response.sendRedirect(request.getContextPath()+"/reviews?error=invalidReview");
return;
}
Review review=new Review();
review.setReviewId(reviewId);
review.setUserId(loggedUser.getUserId());
review.setRating(rating);
review.setReview(reviewText.trim());
boolean updated=reviewDAO.updateReview(review);
if(updated){
response.sendRedirect(request.getContextPath()+"/reviews?success=reviewUpdated");
}else{
response.sendRedirect(request.getContextPath()+"/reviews?error=updateFailed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/reviews?error=invalidData");
}
}
}
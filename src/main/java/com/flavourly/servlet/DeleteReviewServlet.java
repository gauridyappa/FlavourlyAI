package com.flavourly.servlet;
import com.flavourly.dao.ReviewDAO;
import com.flavourly.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/deleteReview")
public class DeleteReviewServlet extends HttpServlet{
private static final long serialVersionUID=1L;
private ReviewDAO reviewDAO;
@Override
public void init(){
reviewDAO=new ReviewDAO();
}
@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
HttpSession session=request.getSession(false);
if(session==null||session.getAttribute("loggedUser")==null){
response.sendRedirect(request.getContextPath()+"/login.jsp");
return;
}
try{
User loggedUser=(User)session.getAttribute("loggedUser");
int reviewId=Integer.parseInt(request.getParameter("reviewId"));
boolean deleted=reviewDAO.deleteReview(reviewId,loggedUser.getUserId());
if(deleted){
response.sendRedirect(request.getContextPath()+"/reviews?success=reviewDeleted");
}else{
response.sendRedirect(request.getContextPath()+"/reviews?error=deleteFailed");
}
}catch(Exception e){
e.printStackTrace();
response.sendRedirect(request.getContextPath()+"/reviews?error=invalidData");
}
}
}
package com.flavourly.servlet;

import java.io.IOException;

import com.flavourly.model.User;
import com.flavourly.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = new User();

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setPassword(request.getParameter("password"));
        
        System.out.println(user.getFullName());
        System.out.println(user.getEmail());
        System.out.println(user.getPhone());
        System.out.println(user.getPassword());

        boolean status = userService.registerUser(user);
        
        System.out.println("Registration Status : " + status);

        if (status) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("signup.jsp?error=emailExists");
        }
    }
}
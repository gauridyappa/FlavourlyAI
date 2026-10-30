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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User loggedUser = userService.loginUser(email, password);

        if (loggedUser != null) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", loggedUser);

            response.sendRedirect(request.getContextPath()+"/dashboard");

        } else {

            response.sendRedirect("login.jsp?error=invalid");

        }
    }
}
package com.flavourly.service;

import com.flavourly.dao.UserDAO;
import com.flavourly.model.User;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public boolean registerUser(User user) {

        if (userDAO.emailExists(user.getEmail())) {
            return false;
        }

        user.setProfileImage("default-profile.png");
        user.setBio("");
        user.setRole("USER");
        user.setAccountStatus("ACTIVE");

        return userDAO.registerUser(user);
    }

    public User loginUser(String email, String password) {
        return userDAO.loginUser(email, password);
    }

}
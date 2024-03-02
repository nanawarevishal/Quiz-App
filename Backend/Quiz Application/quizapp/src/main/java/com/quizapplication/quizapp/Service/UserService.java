package com.quizapplication.quizapp.Service;

import java.util.List;

import com.quizapplication.quizapp.Entity.User;

public interface UserService {

    public User createUser(User user);

    public String deleteUser(Long userId);

    public User updateUser(User user,Long userId);
    
    public User findUserById(Long userId);

    public User findUserByToken(String jwt);

    public List<User> getAllUsers();

    public List<User> setRankUser();

    public List<User> getAllUsersByRankUsers();
}

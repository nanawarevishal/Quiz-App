package com.quizapplication.quizapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizapplication.quizapp.Entity.User;

public interface UserRepository extends JpaRepository<User,Long> {
    
    public User findByEmail(String email);
}

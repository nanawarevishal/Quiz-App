package com.quizapplication.quizapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizapplication.quizapp.Entity.Category;

public interface CategoryRepository extends JpaRepository<Category,Long> {
    
}

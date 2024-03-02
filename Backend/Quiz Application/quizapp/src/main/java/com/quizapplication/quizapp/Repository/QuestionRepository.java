package com.quizapplication.quizapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.quizapplication.quizapp.Entity.Question;

public interface QuestionRepository extends JpaRepository<Question,Long> {
    
}

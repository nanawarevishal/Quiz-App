package com.quizapplication.quizapp.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.quizapplication.quizapp.Entity.Quiz;
import java.util.List;


public interface QuizRepository extends JpaRepository<Quiz,Long> {
    
    @Query("SELECT q FROM Quiz q WHERE q.category.id = :categoryId")
    public List<Quiz> findByCategory(@Param("categoryId") Long categoryId);

}

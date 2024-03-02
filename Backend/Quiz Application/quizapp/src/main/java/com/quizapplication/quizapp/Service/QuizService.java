package com.quizapplication.quizapp.Service;

import java.util.List;

import com.quizapplication.quizapp.Entity.Question;
import com.quizapplication.quizapp.Entity.Quiz;

public interface QuizService {
    
    public Quiz createQuiz(Quiz quiz,Long categoryId);

    public Quiz findQuizById(Long quizId);

    public Quiz updateQuiz(Quiz quiz , Long quizId);

    public List<Question> allQuestionsOfQuiz(Long quizId);

    public List<Quiz> findQuizByCategory(Long categoryId);
}

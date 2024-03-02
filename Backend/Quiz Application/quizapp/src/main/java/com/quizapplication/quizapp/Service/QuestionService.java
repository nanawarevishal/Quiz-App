package com.quizapplication.quizapp.Service;

import com.quizapplication.quizapp.Entity.Question;

public interface QuestionService {
    
    public Question createQuestion(Question question,Long quizId);

    public String deleteQuestion(Long questionId);

    public Question updateQuestion(Question question,long questionId);
    
    public Question findQuestionById(Long questionId);

    public boolean isCorrect(Long questionId,Integer choice);
}

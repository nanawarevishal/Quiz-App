package com.quizapplication.quizapp.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quizapplication.quizapp.Entity.Category;
import com.quizapplication.quizapp.Entity.Question;
import com.quizapplication.quizapp.Entity.Quiz;
import com.quizapplication.quizapp.Exception.QuizException;
import com.quizapplication.quizapp.Repository.QuizRepository;


@Service
public class QuizServiceImpl implements QuizService {

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private CategoryService categoryService;


    @Override
    public Quiz createQuiz(Quiz quiz,Long categoryId) {

        Category category = categoryService.findCategoryById(categoryId);

        Quiz createQuiz = new Quiz();
        createQuiz.setCategory(category);
        createQuiz.setTitle(quiz.getTitle());

        return quizRepository.save(createQuiz);
    }

    @Override
    public List<Quiz> findQuizByCategory(Long categoryId) {

        List<Quiz>quizs = quizRepository.findByCategory(categoryId);

        return quizs;
    }

    @Override
    public Quiz findQuizById(Long quizId) {
        
        Optional<Quiz>opt = quizRepository.findById(quizId);

        if(opt.isPresent()){
            return opt.get();
        }

        throw new QuizException("Quiz is not exist with id: "+quizId);
    }

    @Override
    public Quiz updateQuiz(Quiz quiz, Long quizId) {
        
        Quiz createQuiz = findQuizById(quizId);
        if(quiz.getCategory()!=null){
            createQuiz.setCategory(quiz.getCategory());
        }

        if(quiz.getTitle()!=null){
            createQuiz.setTitle(quiz.getTitle());
        }

        if(quiz.getCatImage()!=null){
            createQuiz.setCatImage(quiz.getCatImage());
        }

        return quizRepository.save(createQuiz);

    }

    @Override
    public List<Question> allQuestionsOfQuiz(Long quizId) {
        
        Quiz quiz = findQuizById(quizId);
        List<Question>questions = quiz.getQuestions();
        
        return questions;
    }
}

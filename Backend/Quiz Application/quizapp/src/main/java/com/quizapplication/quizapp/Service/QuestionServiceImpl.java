package com.quizapplication.quizapp.Service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quizapplication.quizapp.Entity.Question;
import com.quizapplication.quizapp.Entity.Quiz;
import com.quizapplication.quizapp.Exception.QuestionException;
import com.quizapplication.quizapp.Repository.QuestionRepository;
import com.quizapplication.quizapp.Repository.QuizRepository;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuizService quizService;

    @Autowired
    private QuizRepository quizRepository;

    @Override
    public Question createQuestion(Question question,Long quizId) {

        Quiz quiz = quizService.findQuizById(quizId);
        
        Question createQueStion = new Question();
        createQueStion.setContent(question.getContent());
        createQueStion.setQuiz(quiz);
        createQueStion.setAnswers(question.getAnswers());
        createQueStion.setCorrectAnswer(question.getCorrectAnswer());
        createQueStion.setExplanation(question.getExplanation());

        quiz.getQuestions().add(createQueStion);
        quizRepository.save(quiz);

        return questionRepository.save(createQueStion);
    }

    @Override
    public String deleteQuestion(Long questionId) {
        
        Question question = findQuestionById(questionId);

        questionRepository.delete(question);

        return "Question deleted Successfully";
    }
    
    @Override
    public Question updateQuestion(Question question,long questionId) {

        Question updateQuestion = findQuestionById(questionId);

        updateQuestion.setContent(question.getContent());
        updateQuestion.setAnswers(question.getAnswers());
        updateQuestion.setExplanation(question.getExplanation());
        updateQuestion.setCorrectAnswer(question.getCorrectAnswer());

        return questionRepository.save(updateQuestion);
    }


    @Override
    public Question findQuestionById(Long questionId) {

        Optional<Question>opt = questionRepository.findById(questionId);
        
        if(opt.isPresent()){
            return opt.get();
        }

        throw new QuestionException("Question not found with Id: "+questionId);
    }

    @Override
    public boolean isCorrect(Long questionId, Integer choice) {
        
        Question question = findQuestionById(questionId);

        if(question.getCorrectAnswer() == choice){
            return true;
        }

        return false;
    }

}

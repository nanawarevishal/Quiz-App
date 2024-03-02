package com.quizapplication.quizapp.Controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.quizapplication.quizapp.Entity.Question;
import com.quizapplication.quizapp.Entity.Quiz;
import com.quizapplication.quizapp.Entity.User;
import com.quizapplication.quizapp.Exception.UserException;
import com.quizapplication.quizapp.Service.QuizService;
import com.quizapplication.quizapp.Service.UserService;

@CrossOrigin(origins = {"http://localhost:59814", "http://10.0.2.2:8080"})
@RestController
@RequestMapping("/api/quiz/")
public class QuizController {
    
    @Autowired
    private QuizService quizService;

    @Autowired
    private UserService userService;

    @PostMapping("create-quiz/{categoryId}")
    public ResponseEntity<Quiz> createQuiz(@RequestBody Quiz quiz,@PathVariable("categoryId")Long categoryId){

        Quiz createQuiz = quizService.createQuiz(quiz,categoryId);

        return new ResponseEntity<Quiz>(createQuiz, HttpStatus.CREATED);
    }

    // @GetMapping("category-quizs/{categoryId}")
    @GetMapping("category-quiz")
    public ResponseEntity<List<Quiz>> findQuizByCategoryHandler(@RequestParam("categoryId")Long categoryId,@RequestHeader("Authorization")String jwt){

        User user = userService.findUserByToken(jwt);

        if(user== null){
            throw new UserException("Invalid token: "+jwt);
        }

        List<Quiz>quizs = quizService.findQuizByCategory(categoryId);

        return new ResponseEntity<List<Quiz>>(quizs, HttpStatus.OK);
    }

    @GetMapping("all-quizQue")
    public ResponseEntity<List<Question>> findAllQuestionOFQuiz(@RequestParam("quizId")Long quizId,@RequestHeader("Authorization")String jwt){

        User user = userService.findUserByToken(jwt);

        if(user== null){
            throw new UserException("Invalid token: "+jwt);
        }

        List<Question>questions = quizService.allQuestionsOfQuiz(quizId);

        return new ResponseEntity<List<Question>>(questions, HttpStatus.OK);
    }

    @PutMapping("update-quiz/{quizId}")
    public ResponseEntity<Quiz> updateQuiz(@RequestBody Quiz quiz,@PathVariable("quizId")Long quizId){

        Quiz updateQuiz = quizService.updateQuiz(quiz, quizId);

        return new ResponseEntity<Quiz>(updateQuiz, HttpStatus.OK);
    }
}

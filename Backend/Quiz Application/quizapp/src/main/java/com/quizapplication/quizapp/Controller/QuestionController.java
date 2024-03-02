package com.quizapplication.quizapp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quizapplication.quizapp.Entity.Question;
import com.quizapplication.quizapp.Response.ApiResponse;
import com.quizapplication.quizapp.Service.QuestionService;

@RestController
@RequestMapping("/question/")
public class QuestionController {
    
    @Autowired
    private QuestionService questionService;

    @PostMapping("create-question/{quizId}")
    public ResponseEntity<Question> createQuestionHandler(@RequestBody Question question,@PathVariable("quizId")Long quizId){
        
        Question createQuestion = questionService.createQuestion(question, quizId);

        return new ResponseEntity<Question>(createQuestion, HttpStatus.CREATED);
    }

    @PutMapping("update-question/{questionId}")
    public ResponseEntity<Question> updateQuestionHandler(@RequestBody Question question,@PathVariable("questionId")Long questionId){
        
        Question updateQuestion = questionService.updateQuestion(question, questionId);

        return new ResponseEntity<Question>(updateQuestion, HttpStatus.OK);
    }

    @GetMapping("answer/{questionId}/{choice}")
    public ResponseEntity<ApiResponse> checkCorrectAnswer(@PathVariable("questionId")Long questionId,@PathVariable("choice")Integer choice){

        boolean checkCorrect = questionService.isCorrect(questionId, choice);

        ApiResponse response = new ApiResponse();

        if(checkCorrect){
            response.setMsg("Correct answer Congratulations...!");
            response.setStatus(true);

            return new ResponseEntity<ApiResponse>(response, HttpStatus.OK);
        }

        response.setMsg("Incorrect answer..!");
        response.setStatus(false);

        return new ResponseEntity<ApiResponse>(response, HttpStatus.OK);
    }    
}

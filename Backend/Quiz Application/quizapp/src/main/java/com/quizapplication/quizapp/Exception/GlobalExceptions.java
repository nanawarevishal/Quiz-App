package com.quizapplication.quizapp.Exception;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice
public class GlobalExceptions {
   
    @ExceptionHandler(UserException.class)
    public ResponseEntity<ErrorDetails> userExceptionHandler(UserException e,WebRequest request){

        ErrorDetails error = new ErrorDetails();
        error.setMessage(e.getMessage());
        error.setError(request.getDescription(false));
        error.setTimeStamp(LocalDateTime.now());
        error.setStatus(400);

        return new ResponseEntity<ErrorDetails>(error, HttpStatus.BAD_REQUEST);
    }

}

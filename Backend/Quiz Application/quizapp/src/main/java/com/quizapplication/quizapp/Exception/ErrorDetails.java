package com.quizapplication.quizapp.Exception;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ErrorDetails {
    
    private String message;

    private String error;

    private LocalDateTime timeStamp;

    private int status;
}

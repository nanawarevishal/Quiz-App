package com.quizapplication.quizapp.Entity;

import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Answer {
    

    private Long id;

    private String content;

    @ManyToOne
    private Question question;

    private boolean correct;
}

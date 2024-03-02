package com.quizapplication.quizapp.Entity;

import java.util.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapKeyColumn;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;
    
    private String content;

    @ManyToOne
    @JsonIgnore
    private Quiz quiz;

    @ElementCollection
    @CollectionTable(name = "answers", joinColumns = @JoinColumn(name = "question_id"))
    @MapKeyColumn(name = "answerIndex") // Updated to use a different name
    @Column(name = "answerValue")       // Updated to use a different name
    private Map<Integer, String> answers = new HashMap<>();

    private Integer correctAnswer;

    private String explanation;

    // @OneToMany(mappedBy = "question",cascade = CascadeType.ALL)
    // private List<Answer>answers = new ArrayList<>();
}

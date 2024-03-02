package com.quizapplication.quizapp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quizapplication.quizapp.Entity.Category;
import com.quizapplication.quizapp.Service.CategoryService;

@RestController
@RequestMapping("/api/category/")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @PostMapping("create-category")
    public ResponseEntity<Category> createCategoryHandler(@RequestBody Category category){

        Category createCategory = categoryService.createCategory(category);

        return new ResponseEntity<Category>(createCategory,HttpStatus.CREATED);
    }
}

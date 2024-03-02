package com.quizapplication.quizapp.Service;

import com.quizapplication.quizapp.Entity.Category;

public interface CategoryService {
    
    public Category createCategory(Category category);

    public Category findCategoryById(Long categoryId);

}

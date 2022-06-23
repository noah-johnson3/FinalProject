package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer>{

}

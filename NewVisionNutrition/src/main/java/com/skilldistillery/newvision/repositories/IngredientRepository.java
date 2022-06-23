package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer>{

}

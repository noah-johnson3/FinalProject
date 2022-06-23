package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Ingredient;
import com.skilldistillery.newvision.entities.Recipe;

public interface IngredientService {
	
	Ingredient createIngredient(Ingredient ing, String username);
	Ingredient findById(int id);
	Ingredient findByName(String name);
	List<Ingredient> findByRecipe(Recipe recipe);
	List<Ingredient> findAll();
}

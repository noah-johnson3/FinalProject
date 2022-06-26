package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Nutrients;

public interface NutrientService {

	Nutrients findById(int id);
	
	Nutrients findByMealId(int mealId);
	
	Nutrients findByIngredientId(int ingredientId);
	
	Nutrients addNutrients(Nutrients nutrients, String username);
	
	Nutrients updateNutrients(Nutrients nutrients, String username);
	
	List<Nutrients> findByMealWithIngredients(int mealId);
	
	
	List<Nutrients> findByRecipeWithIngredients(int recipeId);
	
	
}

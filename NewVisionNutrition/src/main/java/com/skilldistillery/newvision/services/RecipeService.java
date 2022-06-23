package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Recipe;

public interface RecipeService {

	Recipe createRecipe(Recipe recipe, String username);
	List<Recipe> findByTimeRequire(int minutes);
	List<Recipe> findByIngredientName(String ingredient);
	List<Recipe> findByNutritionValue(Double calories, Double protein, Double carbs, Double fats, Integer sugarInGrams, Integer sodiumInGrams);
	Recipe findByAuthor(String username);
	Recipe addUser(String username, int id, Recipe recipe);
	Recipe updateRecipe(Recipe recipe, String username, int id);
	boolean deletedRecipe(String username, int id);
	List<Recipe> findAll();
}

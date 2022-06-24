package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Recipe;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.RecipeRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private RecipeRepository recipeRepo;
	
	
	@Override
	public Recipe createRecipe(Recipe recipe, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			recipe.setUser(user);
			recipe = recipeRepo.saveAndFlush(recipe);

		}
		return recipe;
	}

	@Override
	public List<Recipe> findByTimeRequire(int minutes) {
		return recipeRepo.findByTime(minutes);
	}

	@Override
	public List<Recipe> findByIngredientName(String ingredient) {
		return recipeRepo.findByIngredient(ingredient);
	}

	@Override
	public List<Recipe> findByNutritionValue(Double calories, Double protein, Double carbs, Double fats,
			Integer sugarInGrams, Integer sodiumInGrams) {
		return recipeRepo.findByNutrients(protein, carbs, sugarInGrams, sodiumInGrams, calories, fats);
	}

	@Override
	public List<Recipe> findByAuthor(String username) {
		return recipeRepo.findByUser_UsernameEquals(username);
	}

	@Override
	public Recipe addUser(String username, int id, Recipe recipe) {
		User user = userRepo.findByUsernameEquals(username);
		Recipe updatedRecipe = null;
		if (user != null) {
			Optional<Recipe> op = recipeRepo.findById(id);
			if (op.isPresent()) {
				updatedRecipe = op.get();
				List<Recipe> recipes = user.getRecipes();
				recipes.add(updatedRecipe);
				user.setRecipes(recipes);
				userRepo.saveAndFlush(user);
				updatedRecipe = recipeRepo.saveAndFlush(updatedRecipe);
			}
		}
		return updatedRecipe;
	}

	@Override
	public Recipe updateRecipe(Recipe recipe, String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Recipe updatedRecipe = null;
		if (user != null) {
			Optional<Recipe> op = recipeRepo.findById(id);
			if (op.isPresent()) {
				updatedRecipe = op.get();
				updatedRecipe.setCalories(recipe.getCalories());
				updatedRecipe.setCarbs(recipe.getCarbs());
				updatedRecipe.setFats(recipe.getFats());
				updatedRecipe.setImageUrl(recipe.getImageUrl());
				updatedRecipe.setIngredients(recipe.getIngredients());
				updatedRecipe.setLink(recipe.getLink());
				updatedRecipe.setName(recipe.getName());
				updatedRecipe.setProtein(recipe.getProtein());
				updatedRecipe.setRecipeText(recipe.getRecipeText());
				updatedRecipe.setSodium(recipe.getSodium());
				updatedRecipe.setSugar(recipe.getSugar());
				updatedRecipe.setTimeRequired(recipe.getTimeRequired());
				updatedRecipe = recipeRepo.saveAndFlush(updatedRecipe);
			}
		}
		return updatedRecipe;
	}

	@Override
	public boolean deletedRecipe(String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Recipe deletedRecipe = null;
		Optional<Recipe> op = recipeRepo.findById(id);
		if (op.isPresent()) {
			deletedRecipe = op.get();
		}
		if (deletedRecipe.getUser() == user) {
			recipeRepo.deleteById(id);
		}
		return !recipeRepo.existsById(id);
	}

	@Override
	public List<Recipe> findAll() {
		return recipeRepo.findAll();

	}

}

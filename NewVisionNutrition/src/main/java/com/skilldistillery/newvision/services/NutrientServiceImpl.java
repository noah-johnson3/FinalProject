package com.skilldistillery.newvision.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Ingredient;
import com.skilldistillery.newvision.entities.Meal;
import com.skilldistillery.newvision.entities.Nutrients;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.IngredientRepository;
import com.skilldistillery.newvision.repositories.MealRepository;
import com.skilldistillery.newvision.repositories.NutrientsRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class NutrientServiceImpl implements NutrientService {

	@Autowired
	private MealRepository mr;
	
	@Autowired
	private IngredientRepository ir;
	
	@Autowired
	private NutrientsRepository nr;
	
	@Autowired
	private UserRepository ur; 

	@Override
	public Nutrients findById(int id) {
		Nutrients nutrients = null;
		Optional<Nutrients> op = nr.findById(id);
		if(op.isPresent()) {
			nutrients = op.get();
		}
		
		return nutrients;
	}

	@Override
	public Nutrients findByMealId(int mealId) {
		
		return nr.findByMeal_IdEquals(mealId);
	}

	@Override
	public Nutrients findByIngredientId(int ingredientId) {
		return nr.findByIngredient_IdEquals(ingredientId);
	}

	@Override
	public Nutrients addNutrients(Nutrients nutrients, String username) {
		User user = ur.findByUsernameEquals(username);
		if(user != null) {
			nr.saveAndFlush(nutrients);
		}
		return null;
	}

	@Override
	public Nutrients updateNutrients(Nutrients nutrients, String username) {
		User user = ur.findByUsernameEquals(username);
		Nutrients updatedNutrients = null;
		if(user != null) {
			Optional<Nutrients> op = nr.findById(nutrients.getId());
			if(op.isPresent()) {
				updatedNutrients = op.get();
				updatedNutrients.setCalories(nutrients.getCalories());
				updatedNutrients.setCarbs(nutrients.getCarbs());
				updatedNutrients.setFats(nutrients.getFats());
				updatedNutrients.setProtein(nutrients.getProtein());
				updatedNutrients.setSodium(nutrients.getSodium());
				updatedNutrients.setSugar(nutrients.getSugar());
				updatedNutrients = nr.saveAndFlush(updatedNutrients);
			}
		}
		
		return updatedNutrients;
	}

	@Override
	public List<Nutrients> findByMealWithIngredients(int mealId) {
		Meal meal = null;
		List<Nutrients> ingNutrients = new ArrayList<>();
		Optional<Meal> op = mr.findById(mealId);
		if(op.isPresent()) {
			meal = op.get();
			if(meal.getIngredients() != null) {
				for(Ingredient ing : meal.getIngredients()) {
					ingNutrients.add(ing.getNutrients());
				}
			}
		}
		
		return ingNutrients;
	}
	
	
	
}

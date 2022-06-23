package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.newvision.entities.Ingredient;
import com.skilldistillery.newvision.entities.Recipe;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.IngredientRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

public class IngredientServiceImpl implements IngredientService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private IngredientRepository ingRepo;
	
	@Override
	public Ingredient createIngredient(Ingredient ing, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			ing = ingRepo.saveAndFlush(ing);

		}
		return ing;
	}

	@Override
	public Ingredient findById(int id) {
		Ingredient ing = null;
		Optional<Ingredient> op = ingRepo.findById(id);
		if(op.isPresent()) {
			ing = op.get();
		}
		return ing;
	}

	@Override
	public Ingredient findByName(String name) {
		return ingRepo.findByNameEquals(name);
	}

	@Override
	public List<Ingredient> findByRecipe(Recipe recipe) {
		return ingRepo.findByRecipe(recipe.getId());
	}

	@Override
	public List<Ingredient> findAll() {
		return ingRepo.findAll();
	}

}

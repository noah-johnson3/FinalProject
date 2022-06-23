package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Meal;
import com.skilldistillery.newvision.entities.TrackedDay;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.MealRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

public class MealServiceImpl implements MealService {
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private MealRepository mealRepo;
	
	
	@Override
	public Meal createMeal(Meal meal, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			meal = mealRepo.saveAndFlush(meal);

		}
		return meal;
	}

	@Override
	public List<Meal> findByTrackedDay(TrackedDay day, String username) {
		List<Meal> meals = null;
		if(userRepo.findByUsernameEquals(username) != null) {
			meals = mealRepo.findByTrackDay_IdEquals(day.getId());
		}
		return meals;
	}

	@Override
	public Meal findById(String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Meal meal = null;
		if(user != null) {
			Optional<Meal> op = mealRepo.findById(id);
			if(op.isPresent()) {
				meal = op.get();
			}
		}
		return meal;
	}

	@Override
	public boolean deletedMeal(int id, String username) {
		User user = userRepo.findByUsernameEquals(username);
		Meal deletedMeal = null;
		Optional<Meal> op = mealRepo.findById(id);
		if (op.isPresent()) {
			deletedMeal = op.get();
		}
		if(deletedMeal.getTrackDay().getUser() == user) {
			mealRepo.deleteById(id);
		}
		return !mealRepo.existsById(id);
	}

}

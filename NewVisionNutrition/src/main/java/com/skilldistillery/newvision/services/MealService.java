package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Meal;
import com.skilldistillery.newvision.entities.TrackedDay;

public interface MealService {
	
	Meal createMeal(Meal meal,String username);
	List<Meal> findByTrackedDay(TrackedDay day, String username);
	Meal findById(String username, int id);
	boolean deletedMeal(int id, String username);
	
}
package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Meal;
import com.skilldistillery.newvision.entities.TrackedDay;
import com.skilldistillery.newvision.services.MealService;

@RequestMapping("api")
@RestController
public class MealController {
	
	@Autowired
	private MealService mealService;
	
	@GetMapping("meals/{id}")
	public Meal findById(@PathVariable int id, HttpServletResponse res, Principal principal) {
		Meal meal = null;
		try {
			meal = mealService.findById(principal.getName(), id);
			if (meal == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return meal;
	}
	
	@GetMapping("meals/byDay")
	public List<Meal> findByDay(@RequestBody TrackedDay trackedDay, HttpServletResponse res, Principal principal) {
		List<Meal> meals = null;
		try {
			meals = mealService.findByTrackedDay(trackedDay, principal.getName());
			if (meals == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return meals;
	}
	
	@PostMapping("meals")
	public Meal createMeal(HttpServletResponse res, @RequestBody Meal meal, Principal principal) {

		try {
			meal = mealService.createMeal(meal, principal.getName());
			if (meal == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return meal;

	}
	
	@DeleteMapping("meals/{id}")
	public void deleteMeal(HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean removed = false;
		try {
			removed = mealService.deletedMeal(id, principal.getName());
			if (!removed) {
				res.setStatus(400);
			} else {
				res.setStatus(204);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
	}

}

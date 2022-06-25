package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Ingredient;
import com.skilldistillery.newvision.entities.Recipe;
import com.skilldistillery.newvision.services.IngredientService;

@RequestMapping("api")
@RestController
@CrossOrigin({ "*", "http://localhost:4200" })
public class IngredientController {
	
	@Autowired
	private IngredientService ingService;
	
	@GetMapping("ingredients/{name}")
	public Ingredient findByName(HttpServletResponse res, @PathVariable String name) {
		Ingredient ing = null;
		try {
			ing = ingService.findByName(name);
			if (ing == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return ing;
	}
	@GetMapping("ingredients")
	public List<Ingredient> findAllIng(HttpServletResponse res) {
		List<Ingredient> ing = null;
		try {
			ing = ingService.findAll();
			if (ing == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return ing;
	}
	@GetMapping("ingredients/recipe")
	public List<Ingredient> findByRecipe(HttpServletResponse res, @RequestBody Recipe recipe) {
		List<Ingredient> ing = null;
		try {
			ing = ingService.findByRecipe(recipe);
			if (ing == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return ing;
	}
	
	@GetMapping("ingredients/{id}")
	public Ingredient findById(@PathVariable int id, HttpServletResponse res) {
		Ingredient ing = null;
		try {
			ing = ingService.findById(id);
			if (ing == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return ing;
	}
	
	@PostMapping("Indredients")
	public Ingredient createIng(HttpServletResponse res, @RequestBody Ingredient ing, Principal principal) {

		try {
			ing = ingService.createIngredient(ing, principal.getName());
			if (ing == null) {
				res.setStatus(404);
			} else {
				res.setStatus(201);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return ing;

	}
	
	
	
}

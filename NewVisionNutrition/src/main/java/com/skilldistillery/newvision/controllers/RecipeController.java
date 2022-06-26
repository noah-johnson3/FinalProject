package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Recipe;
import com.skilldistillery.newvision.services.RecipeService;

@RequestMapping("api")
@RestController
@CrossOrigin({ "*", "http://localhost:4200" })
public class RecipeController {
	
	@Autowired
	private RecipeService rs;
	
	@GetMapping("recipes/time/{minutes}")
	public List<Recipe> findByTime(@PathVariable int minutes, HttpServletResponse res){
		List<Recipe> recipes = null;
		try {
			recipes = rs.findByTimeRequire(minutes);
			if(recipes == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return recipes;
	}
	@GetMapping("recipes/ingredient/{name}")
	public List<Recipe> findByIngredient(@PathVariable String name, HttpServletResponse res){
		List<Recipe> recipes = null;
		try {
			recipes = rs.findByIngredientName(name);
			if(recipes == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return recipes;
	}
	
	@GetMapping("recipes/author/{username}")
	public List<Recipe> findByNutrition(@PathVariable String username, HttpServletResponse res){
		List<Recipe> recipes = null;
		try {
			recipes = rs.findByAuthor(username);
			if(recipes == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return recipes;
	}
	
	@PostMapping("recipes")
	public Recipe createRecipe(@RequestBody Recipe recipe, Principal principal, HttpServletResponse res ) {
		try {
			recipe = rs.createRecipe(recipe, principal.getName());
			if(recipe == null) {
				res.setStatus(400);
			}else {
				res.setStatus(201);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return recipe;
	}
	
	@PutMapping("recipes/{id}")
	public Recipe updateRecipe(@RequestBody Recipe recipe, Principal principal, HttpServletResponse res, @PathVariable int id ) {
		try {
			recipe = rs.updateRecipe(recipe, principal.getName(), id);
			if(recipe == null) {
				res.setStatus(400);
			}else {
				res.setStatus(200);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return recipe;
	}
	
	@PutMapping("recipes/addUser/{id}")
	public Recipe addUser(@RequestBody Recipe recipe, Principal principal, HttpServletResponse res, @PathVariable int id ) {
		try {
			recipe = rs.addUser(principal.getName(), id, recipe);
			if(recipe == null) {
				res.setStatus(400);
			}else {
				res.setStatus(200);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return recipe;
	}
	
	@GetMapping("recipes")
	public List<Recipe> findAll(HttpServletResponse res){
		List<Recipe> recipes = null;
		try {
			recipes = rs.findAll();
			if(recipes == null) {
				res.setStatus(500);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return recipes;
	}
	
	@DeleteMapping("recipes/{id}")
	public void deleteRecipe(@PathVariable int id, Principal principal, HttpServletResponse res) {
		try {
			boolean deleted = rs.deletedRecipe(principal.getName(), id);
			if(!deleted) {
				res.setStatus(401);
			}else {
				res.setStatus(204);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
	}
}

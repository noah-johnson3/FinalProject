package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Nutrients;
import com.skilldistillery.newvision.services.NutrientService;

@CrossOrigin({ "*", "http://localhost:4200" })
@RequestMapping("api")
@RestController
public class NutrientsController {
	
	@Autowired 
	private NutrientService nutriServ;
	
	@GetMapping("nutrients/{id}")
	public Nutrients getById(HttpServletResponse res, @PathVariable int id) {
		Nutrients nutrients = null;
		try {
			nutrients = nutriServ.findById(id);
			if(nutrients == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return nutrients;
	}
	@GetMapping("nutrients/ingredient/{id}")
	public Nutrients getByIngredient(HttpServletResponse res, @PathVariable int id) {
		Nutrients nutrients = null;
		try {
			nutrients = nutriServ.findByIngredientId(id);
			if(nutrients == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return nutrients;
	}
	@GetMapping("nutrients/meal/{id}")
	public Nutrients getByMealId(HttpServletResponse res, @PathVariable int id) {
		Nutrients nutrients = null;
		try {
			nutrients = nutriServ.findByMealId(id);
			if(nutrients == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return nutrients;
	}
	@GetMapping("nutrients/meal/ingredients/{id}")
	public List<Nutrients> getByMealIdWithIngredients(HttpServletResponse res, @PathVariable int id) {
		List<Nutrients> nutrients = null;
		try {
			nutrients = nutriServ.findByMealWithIngredients(id);
			if(nutrients == null) {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return nutrients;
	}
	
	@PostMapping("nutrients")
	public Nutrients createNutrients(HttpServletResponse res, @RequestBody Nutrients nutrients, Principal principal) {
		try {
			nutrients = nutriServ.addNutrients(nutrients, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return nutrients;
	}
	@PutMapping("nutrients")
	public Nutrients updateNutrients(HttpServletResponse res, @RequestBody Nutrients nutrients, Principal principal) {
		try {
			nutrients = nutriServ.updateNutrients(nutrients, principal.getName());
			res.setStatus(200);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return nutrients;
	}
	
	
}

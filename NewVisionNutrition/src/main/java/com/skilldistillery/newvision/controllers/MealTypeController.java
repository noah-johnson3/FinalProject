package com.skilldistillery.newvision.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.MealType;
import com.skilldistillery.newvision.services.MealTypeService;

@RequestMapping("api")
@RestController
public class MealTypeController {
	
	@Autowired
	private MealTypeService mts;
	
	@GetMapping("mealTypes/{id}")
	public MealType findById(@PathVariable int id, HttpServletResponse res) {
		MealType mealT = null;
		try {
			mealT = mts.findById(id);
			if (mealT == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return mealT;
	}
	
	@GetMapping("mealTypes")
	public List<MealType> findAllBlogs (HttpServletResponse res) {
		List<MealType> mealTs = null;
		try {
			mealTs = mts.findAll();
			if (mealTs == null) {
				res.setStatus(500);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return mealTs;
	}

}

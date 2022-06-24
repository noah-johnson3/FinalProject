package com.skilldistillery.newvision.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.services.RecipeService;

@RequestMapping("api")
@RestController
public class RecipeController {
	
	@Autowired
	private RecipeService rs;

}

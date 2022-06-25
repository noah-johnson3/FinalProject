package com.skilldistillery.newvision.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Gender;
import com.skilldistillery.newvision.services.GenderService;

@RequestMapping("api")
@RestController
@CrossOrigin({ "*", "http://localhost:4200" })
public class GenderController {
	
	@Autowired
	private GenderService genderServ;
	
	@GetMapping("genders/{id}")
	public Gender findById(@PathVariable int id, HttpServletResponse res) {
		Gender gender = null;
		try {
			gender = genderServ.findById(id);
			if (gender == null) {
				res.setStatus(400);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return gender;
	}
	
	@GetMapping("genders")
	public List<Gender> findAll(HttpServletResponse res) {
		List<Gender> gender = null;
		try {
			gender = genderServ.findAll();
			if (gender == null) {
				res.setStatus(400);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return gender;
	}
	

}

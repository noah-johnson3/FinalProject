package com.skilldistillery.newvision.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class UserController {

		@Autowired
		private UserService userService;
		
		
		@GetMapping("users/{id}")
		public User findUserById(HttpServletResponse res, @PathVariable("id")int id) {
			User user = null;
			try {
				user = userService.getUserById(id);
			}catch(Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
			
			return user;
		}
}

package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		
		@GetMapping("users")
		public List<User> index(HttpServletResponse res) {
			List<User> users = userService.index();
			return users;
		}
		
//		@PutMapping("users/{id}")
//		public User updateUser(@RequestBody User user,
//		 @PathVariable int id, HttpServletResponse res, HttpServletRequest req) {
//			userService.updateUser(user, id);
//			res.setStatus(HttpServletResponse.SC_OK);
//			res.setHeader("location", req.getRequestURI() + "/" + user.getId());
//			return user;
//		}
		
		@PutMapping("users/{id}")
		public User updateUser(@RequestBody User user, @PathVariable int id, HttpServletResponse res, Principal principal) {
			try {
				user = userService.updateUser(user, id, principal.getName());
				if(user == null) {
					res.setStatus(404);
				}
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
			return user;
		}
		
		@DeleteMapping("users/{id}")
		public void deactivate(@PathVariable int id, HttpServletResponse res, Principal principal) {
			try {
				if(!userService.deactivate(principal.getName(), id)) {
					res.setStatus(500);
				}else {
					res.setStatus(200);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				res.setStatus(400);
			}
		}
}

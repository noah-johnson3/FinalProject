package com.skilldistillery.newvision.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.services.BlogService;

@RequestMapping("api")
@RestController
public class BlogController {
	
	@Autowired
	private BlogService blogService;
	
	@GetMapping("blogs/{topicName}")
	public List<Blog> findByTopic(HttpServletResponse res, @PathVariable String topicName) {
		List<Blog> blogs = null;
		System.out.println("IN find By topic ***********************");
		try {
			System.out.println(topicName);
			blogs = blogService.findByTopic(topicName);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blogs;
		
	}

}

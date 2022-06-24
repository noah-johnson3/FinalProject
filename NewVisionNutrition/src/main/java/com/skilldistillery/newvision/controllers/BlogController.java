package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
		try {
			blogs = blogService.findByTopic(topicName);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return blogs;

	}

	@GetMapping("blogs/{username}")
	public List<Blog> findByAuthor(@PathVariable String username, HttpServletResponse res) {
		List<Blog> blogs = null;
		try {
			blogs = blogService.findByUsername(username);
			if (blogs == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return blogs;
	}

	@GetMapping("blogs/{id}")
	public Blog findById(@PathVariable int id, HttpServletResponse res) {
		Blog blog = null;
		try {
			blog = blogService.findById(id);
			if (blog == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return blog;
	}

	@PostMapping("blogs")
	public Blog createBlog(HttpServletResponse res, @RequestBody Blog blog, Principal principal) {

		try {
			blog = blogService.createBlog(blog, principal.getName());
			if (blog == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return blog;

	}
	
	@PutMapping("blogs/{id}")
	public Blog updateBlog(HttpServletResponse res, @PathVariable int id, @RequestBody Blog blog,
			Principal principal) {
		try {
			blog = blogService.updateBlog(blog, principal.getName(), id);
			if (blog == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return blog;
	}
	
	@DeleteMapping("blogs/{id}")
	public void deleteBlog(HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean removed = false;
		try {
			removed = blogService.deleteBlog(principal.getName(), id);
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
	
	@GetMapping("blogs")
	public List<Blog> findAllBlogs (HttpServletResponse res) {
		List<Blog> blogs = null;
		try {
			blogs = blogService.findAll();
			if (blogs == null) {
				res.setStatus(500);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return blogs;
	}

}

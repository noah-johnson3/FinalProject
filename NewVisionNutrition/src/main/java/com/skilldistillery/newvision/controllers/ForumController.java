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

import com.skilldistillery.newvision.entities.ForumPost;
import com.skilldistillery.newvision.services.ForumService;

public class ForumController {

	@Autowired
	private ForumService forumServ;
	
	@GetMapping("forums")
	public List<ForumPost> getMainPosts(HttpServletResponse res) {
		List<ForumPost> posts = null;
		try {
			posts = forumServ.getMainPosts();
			if(posts == null) {
				res.setStatus(204);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return posts;
	}
	
	@GetMapping("forums/topic/{topic}")
	public List<ForumPost> getByTopic(HttpServletResponse res, @PathVariable String topic) {
		List<ForumPost> posts = null;
		try {
			posts = forumServ.getMainPostsByTopic(topic);
			if(posts == null) {
				res.setStatus(204);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return posts;
	}
	
	
	@GetMapping("forums/responses/{id}")
	public List<ForumPost> getResponses(HttpServletResponse res,  @PathVariable int id) {
		List<ForumPost> posts = null;
		try {
			posts = forumServ.getResponsesByPostId(id);
			if(posts == null) {
				res.setStatus(204);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return posts;
	}
	
	@PutMapping("forums/{id}")
	public ForumPost editPost(HttpServletResponse res, @PathVariable int id, @RequestBody ForumPost post, Principal principal) {
		try {
			post = forumServ.editPost(post, id, principal.getName());
			if(post == null) {
				res.setStatus(401);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return post;
		
	}
	
	@PostMapping("forums")
	public ForumPost createPost(HttpServletResponse res, @RequestBody ForumPost post, Principal principal) {
		try {
			post = forumServ.createPost(post, principal.getName());
			res.setStatus(201);
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
		return post;
		
	}
	
	@DeleteMapping("forums/{id}")
	public void deletePost(HttpServletResponse res, @PathVariable int id, Principal principal) {
		try {
			boolean deleted = forumServ.deletePost(id, principal.getName());
			if(deleted) {
				res.setStatus(204);
			}else {
				res.setStatus(401);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		
	}
	
	
	
	
}

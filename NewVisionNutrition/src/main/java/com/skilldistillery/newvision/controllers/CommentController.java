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
import com.skilldistillery.newvision.entities.Comment;
import com.skilldistillery.newvision.services.CommentService;

@RequestMapping("api")
@RestController
public class CommentController {

	@Autowired
	private CommentService commService;

	@GetMapping("comments/{id}")
	public List<Comment> findByBlogId(HttpServletResponse res, @PathVariable int id) {
		List<Comment> comments = null;
		try {
			comments = commService.findByBlogId(id);
			if (comments == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return comments;

	}
	
//	@GetMapping("comments/{id}")
//	public Comment findById(@PathVariable int id, HttpServletResponse res) {
//		Comment comment = null;
//		try {
//			comment = commService.;
//			if (comment == null) {
//				res.setStatus(404);
//			} else {
//				res.setStatus(200);
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			res.setStatus(404);
//		}
//		return comment;
//	}
	
	@PostMapping("comments")
	public Comment createComment(HttpServletResponse res, @RequestBody Comment comment, Principal principal) {

		try {
			comment = commService.createComment(comment, principal.getName());
			if (comment == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return comment;

	}
	
	@PutMapping("comments/{id}")
	public Comment updateComment(HttpServletResponse res, @PathVariable int id, @RequestBody Comment comment,
			Principal principal) {
		try {
			comment = commService.updateComment(comment, principal.getName(), id);
			if (comment == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return comment;
	}
	
	@DeleteMapping("comments/{id}")
	public void deleteBlog(HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean removed = false;
		try {
			removed = commService.deleteComment(principal.getName(), id);
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

}

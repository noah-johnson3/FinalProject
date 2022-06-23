package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Comment;

public interface CommentService {
	
	Comment createComment(Comment comm, String username);
	List<Comment> findByBlogId(int id);
	Comment updateComment(Comment comm, String username, int id);
	boolean deleteComment(String username, int id);

}

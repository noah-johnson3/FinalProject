package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Blog;

public interface BlogService {
	
	List<Blog> findByTopic(String topicName);
	List<Blog> findByUsername(String username);
	Blog findById(int id);
	Blog createBlog(Blog blog, String username);
	Blog updateBlog(Blog blog, String username, int id);
	boolean deleteBlog(String username, int id);
	List<Blog> findAll();
	
}

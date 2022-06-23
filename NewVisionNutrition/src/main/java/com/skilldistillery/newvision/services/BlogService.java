package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Blog;

public interface BlogService {
	
	List<Blog> findByTopic(String topicName);

}

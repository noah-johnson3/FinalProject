package com.skilldistillery.newvision.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.repositories.BlogRepository;

@Service
public class BlogServiceImpl implements BlogService {
	
	@Autowired
	private BlogRepository blogRepo;

	@Override
	public List<Blog> findByTopic(String topicName) {
		return blogRepo.findBlogByTopicName(topicName);
	}

}

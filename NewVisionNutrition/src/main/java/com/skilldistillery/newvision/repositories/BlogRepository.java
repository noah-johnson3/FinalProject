package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Blog;

public interface BlogRepository extends JpaRepository<Blog, Integer>{
	
	Blog findBlogByUser_Id(int id);
	List<Blog> findBlogByTopics_Name(String topicName);

}

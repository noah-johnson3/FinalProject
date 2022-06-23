package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Blog;

public interface BlogRepository extends JpaRepository<Blog, Integer>{
	
	Blog findBlogByUser_Id(int id);
	
	@Query("SELECT b FROM Blog b JOIN b.topics bt WHERE bt.name = :topicName ")
	List<Blog> findBlogByTopicName(@Param("topicName")String topicName);

}
